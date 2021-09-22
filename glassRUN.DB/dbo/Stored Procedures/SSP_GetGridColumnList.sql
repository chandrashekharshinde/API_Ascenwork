
CREATE PROCEDURE [dbo].[SSP_GetGridColumnList] --'<Json><ServicesAction>LoadGridConfiguration</ServicesAction><RoleId>3</RoleId><UserId>8</UserId><PageName>Approve Enquiries</PageName><ControllerName>SalesAdminApproval</ControllerName></Json>'
@xmlDoc XML
AS
 BEGIN 
 
DECLARE @intPointer INT
Declare @PageName nvarchar(300)
Declare @controllerName nvarchar(300)
Declare @RoleId INT
Declare @RoleMasterId INT
Declare @UserId int
Declare @CultureId int
Declare @ObjectId int
Declare @ObjectName nvarchar(max)
Declare @PageId int

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT    
    @PageName = tmp.[PageName],
    @controllerName = tmp.[ControllerName],
    @RoleId = tmp.[RoleId],
    @RoleMasterId = tmp.[RoleId],
    @UserId = tmp.[UserId],
    @CultureId = tmp.[CultureId],
    @ObjectName = tmp.[ObjectName]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageName] nvarchar(2000),
   [ControllerName] nvarchar(2000),
   [RoleId] int,
   [UserId] int,
   [CultureId] int,
   [ObjectId] int,
   [ObjectName] nvarchar(max)
   )tmp


   if exists (select GridColumnConfigurationId from GridColumnConfiguration where LoginId = @UserId and IsActive = 1 and PageId in (select PageId from Pages where PageName=@pageName and ControllerName = @controllerName ))
    BEGIN
     set @UserId=@UserId
    end
     else
     BEGIN
      set @UserId=0
     end;

 print @UserId;

 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select Cast((SELECT distinct
       'true' AS [@json:Array]  , [GridColumnId]
      ,[visibleIndex]
      ,[ObjectId]
      ,[dataField]
      ,[dataType]
      ,[PropertyName]
      ,[PropertyType]
      ,[format]
      ,[filterOperations]
      ,[alignment]
      ,[caption]
      ,[ResourceValue]
      ,[ResourceKey]
      ,[LoginId]
      ,[ResourceId]
      ,[PageId]
      ,[cellTemplate]
      ,[cssClass]
      ,[fixed]
      ,[visible]
      ,[allowHiding]
      ,[GroupIndex]
      ,[IsPinned]
      ,[IsExportAvailable]
      ,[IsAvailable]
      ,[IsMandatory]
      ,[IsDefault]
      ,[IsSystemMandatory]
      ,[SequenceNumber]
      ,[IsDetailsViewAvailable]
      ,[IsGrouped]
      ,[GroupSequence]
      ,[IsActive]
      ,[RoleId]
      ,[ControlName]
      ,[PageName]
      ,[ControllerName] from GridColumnConfigurationView 
	 -- where Roleid=@RoleId and LoginId=@UserId and ControlName=@ObjectName and PageName=@PageName and ControllerName=@controllerName
FOR XML PATH('GridColumnList'),ELEMENTS,ROOT('Json')) AS XML)
 
END