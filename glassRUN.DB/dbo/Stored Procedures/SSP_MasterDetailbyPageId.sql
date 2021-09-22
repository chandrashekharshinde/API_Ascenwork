CREATE PROCEDURE [dbo].[SSP_MasterDetailbyPageId] --'<Json><ServicesAction>GetAllMasterDetailByPageid</ServicesAction><PageId>6</PageId><RoleId>4</RoleId><UserId>512</UserId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @PageId bigint
Declare @RoleId bigint
Declare @userId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @PageId = tmp.[PageId],
@RoleId = tmp.[RoleId],
@userId = tmp.[UserId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PageId] bigint,
			[RoleId] bigint,
			[UserId] bigint
           
			)tmp ;

	
			 if @userId !=0 
			 BEGIN
				SET @RoleId=0
			 END;
			 Print @RoleId;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , 
    [PageWiseConfigurationMasterId]
      ,[PageId]
	  ,(Select PageName from Pages where PageId=PageWiseConfigurationMaster.[PageId]) as PageName
      ,[SettingName]
      ,[Description]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	  ,ISNULL((select SettingValue from PageWiseConfiguration where SettingName=PageWiseConfigurationMaster.SettingName 
	  and (RoleId=@RoleId or @RoleId=0) and PageId=@PageId and (UserId=@userId or @userId=0)),0) as InputValue
  FROM PageWiseConfigurationMaster WHERE IsActive = 1 and PageId=@PageId order by SettingName Asc 
	FOR XML path('MasterList'),ELEMENTS,ROOT('Json')) AS XML)
END

