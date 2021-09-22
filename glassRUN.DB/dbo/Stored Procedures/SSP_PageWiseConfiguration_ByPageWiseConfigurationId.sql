CREATE PROCEDURE [dbo].[SSP_PageWiseConfiguration_ByPageWiseConfigurationId] --'<Json><ServicesAction>GetPageWiseConfigurationByPageWiseConfigurationId</ServicesAction><PageId>6</PageId><RoleId>0</RoleId><UserId>464</UserId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @userDimensionMappingId nvarchar(100)
declare @pageId nvarchar(100)
declare @pageName nvarchar(100)
declare @roleId nvarchar(100)
declare @userId nvarchar(100)
declare @controlId nvarchar(100)
declare @CultureId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
 @pageId = tmp.[PageId], 
  @roleId = tmp.[RoleId],
 @userId = tmp.[UserId]
  
 
       
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [PageId] bigint,	
	[RoleId] bigint,
	[UserId] bigint
	

   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((Select 'true' AS [@json:Array] ,
		[PageWiseConfigurationId]
      ,[PageId]
	  ,(Select PageName from pages where PageId=[PageWiseConfiguration].[PageId]) as PageName
	   ,(Select RoleName from RoleMaster where RoleMasterId=[PageWiseConfiguration].[RoleId]) as RoleName
	   ,(Select top 1 Description from PageWiseConfigurationMaster where SettingName=[PageWiseConfiguration].[SettingName]) as Description
      ,[RoleId]
      ,[UserId]
      ,[CompanyId]
     
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      
      ,SettingName
	  ,SettingValue as InputValue
	  ,NEWID() as PropertyGUID
	   ,(select cast ((SELECT  'true' AS [@json:Array]  ,[LoginId] as Id
      ,[Name]	  
   from [Login]
   WHERE IsActive = 1  and LoginId=[PageWiseConfiguration].UserId
 FOR XML path('UserList'),ELEMENTS) AS xml))
  
 FROM [dbo].[PageWiseConfiguration] WHERE ([PageId] = @pageId OR @pageId = '') and (UserId = @userId OR @userId = '')
  and (RoleId = @roleId OR @roleId = '') AND IsActive=1
 FOR XML path('PageWiseConfigurationList'),ELEMENTS,ROOT('Json')) AS XML)
 
 

END
