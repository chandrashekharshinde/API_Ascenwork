CREATE PROCEDURE [dbo].[SSP_UserDimensionMapping_ByUserDimensionMappingId] --'<Json><ServicesAction>GetUserDimensionMappingByUserDimensionMappingId</ServicesAction><PageName>SalesAdminApproval</PageName><RoleId>4</RoleId><UserId>463</UserId><ControlId>5</ControlId></Json>'

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

SELECT @userDimensionMappingId = tmp.[UserDimensionMappingId],
 @pageId = tmp.[PageId],
 @pageName = tmp.[PageName],
  @roleId = tmp.[RoleId],
 @userId = tmp.[UserId],
  @controlId = tmp.[ControlId]
 
       
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [UserDimensionMappingId] bigint,
	[PageId] bigint,
	[PageName] nvarchar(200),
	[RoleId] bigint,
	[UserId] bigint,
	[ControlId] bigint

   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((Select 'true' AS [@json:Array]  ,[UserDimensionMappingId]
      ,[UserId]
	  
      ,[RoleMasterId] as RoleId	
	  ,(Select RoleName from RoleMaster where RoleMasterId=[UserDimensionMapping].[RoleMasterId]) as RoleName
      ,[DimensionName] as PropertyName
	  ,(Select PagePropertiesId from PageProperties where propertyname=[UserDimensionMapping].[DimensionName]) as PagePropertiesId
      ,(Select PageName from Pages where ControllerName=[UserDimensionMapping].[PageName]) as [PageName]
	  ,(Select PageId from Pages where ControllerName=[UserDimensionMapping].[PageName]) as PageId
	  ,[PageName] as ControllerName
      --,CASE WHEN [OperatorType]=1 THEN 'In' ELSE 'Equal' END as ControlTypeId
      ,[ControlId]
	  --,ControlTypeId
	  ,OperatorType as ControlType
	  ,(Select ControlName from PageControl where PageControlId=[UserDimensionMapping].[ControlId]) as DisplayName
      ,[DimensionValue] as ControlValue
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]  
	  ,NEWID() as PropertyGUID
  ,(select cast ((SELECT  'true' AS [@json:Array]  ,[LoginId] as Id
      ,[Name]	  
   from [Login]
   WHERE IsActive = 1  and LoginId=[UserDimensionMapping].UserId
 FOR XML path('UserList'),ELEMENTS) AS xml))
 FROM [dbo].[UserDimensionMapping] WHERE ([PageName] = @pageName OR @pageName = '') and (UserId = @userId OR @userId = '')
 and (ControlId = @controlId OR @controlId = '') and (RoleMasterId = @roleId OR @roleId = '') AND IsActive=1
 FOR XML path('PropertyMappingList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END











































