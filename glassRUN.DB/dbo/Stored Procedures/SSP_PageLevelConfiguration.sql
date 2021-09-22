
CREATE PROCEDURE [dbo].[SSP_PageLevelConfiguration] --'<Json><ServicesAction>GetPageLevelConfiguration</ServicesAction><CompanyId>0</CompanyId><UserId>0</UserId><RoleId>0</RoleId><PageName>Create Enquiry</PageName></Json>'
@xmlDoc XML
AS 



BEGIN


DECLARE @intPointer INT;
Declare @UserId bigint
declare @RoleId BIGINT
declare @CompanyId bigint
Declare @PageName nvarchar(250)
Declare @PageId bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @RoleId = tmp.[RoleId],
@UserId = tmp.[UserId],
@CompanyId = tmp.[CompanyId],
@PageName =tmp.[PageName]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
							[RoleId] bigint,
							[UserId] bigint,
							[CompanyId] bigint,
							PageName nvarchar(250)
			)tmp;

print  '@PageId' + Convert(nvarchar(250),@PageId) 
print  '@@RoleId' + Convert(nvarchar(250),@RoleId) 
print  '@@UserId' + Convert(nvarchar(250),@UserId) 
print  '@@PageName' + Convert(nvarchar(250),@PageName) 

set @PageId  =(select PageId  From Pages  where PageName=@PageName)


if(exists(select * From  [PageWiseConfiguration]  where PageId=@PageId and UserId=@UserId))
	begin
		set @RoleId  = 0
		set @CompanyId = 0
	end
else if(exists(select * From  [PageWiseConfiguration]  where PageId=@PageId and RoleId=@RoleId))
	begin
		set @UserId  = 0
		set @CompanyId = 0
	end

else if(exists(select * From  [PageWiseConfiguration]  where PageId=@PageId and CompanyId=@CompanyId))
	begin
		set @UserId  = 0
		set @RoleId = 0
	end

else 
	begin
		set @CompanyId = 0
		set @UserId  = 0
		set @RoleId = 0
	end;

print  '@@Roleid' + Convert(nvarchar(250),@RoleId) 
print  '@@UserId' + Convert(nvarchar(250),@UserId) 
print  '@@PageName' + Convert(nvarchar(250),@PageName) ;
print  '@@PageName' + Convert(nvarchar(250),@PageId) ;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array],
pwc.SettingName,
pwc.SettingValue ,
pwc.RoleId,
pwc.UserId,
pwc.CompanyId,
pwc.PageId,
p.PageName
from PageWiseConfiguration pwc join Pages p on p.PageId=pwc.PageId
where pwc.IsActive=1 
--and pwc.RoleId=@RoleId  and pwc.UserId =@UserId and pwc.CompanyId = @CompanyId and pwc.PageId=@PageId
				
	FOR XML path('PageWiseConfigurationList'),ELEMENTS,ROOT('Json')) AS XML)

	  

END