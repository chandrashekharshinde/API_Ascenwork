CREATE PROCEDURE [dbo].[SSP_GetPageControlsAccessList] --'<Json><ServicesAction>GetPageControlsByPageName</ServicesAction><PageName>InquiryListGrid</PageName><RoleId>29</RoleId><UserId>0</UserId></Json>'
@xmlDoc XML
AS 
 BEGIN 
	
DECLARE @intPointer INT
Declare @PageName nvarchar(300)
Declare @RoleId INT
Declare @UserId int

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT    
	   @PageName = tmp.[PageName],
	   @RoleId = tmp.[RoleId],
	   @UserId = tmp.[UserId]

	   
	  
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PageName] nvarchar(2000),
			[RoleId] int,
			[UserId] int
			)tmp


			if exists (select RoleWiseFieldAccessId from RoleWiseFieldAccess where LoginId = @UserId and PageId in (select PageId from Pages where PageName = @pageName))
 BEGIN
 set @RoleId=-1
 end
 else
 BEGIN
  set @UserId=-1
 end



Select Cast((SELECT	o.ObjectId
      ,ObjectName
	  ,PageId
       ,  
	(Cast((SELECT op.[ObjectPropertiesId] ,
	op.[ObjectId] ,
	PageId,
	[PropertyName] ,
	AccessId,
	[ResourceKey] ,
	[OnScreenDisplay] 
		
    FROM [ObjectProperties] op left join RoleWiseFieldAccess rwfa on op.ObjectPropertiesId = rwfa.ObjectPropertiesId  
	WHERE op.IsActive = 1 and rwfa.IsActive= 1 and op.ObjectId = o.ObjectId

	and (LoginId=@UserId or  RoleId=@RoleId)

	FOR XML RAW('ObjectPropertiesList'),ELEMENTS) AS XML))
 

    from [Object] o join PageObjectMapping pom on o.ObjectId = pom.ObjectId
    WHERE o.IsActive = 1 AND pom.PageId in (select PageId from Pages where PageName = @pageName)

    FOR XML RAW('ObjectList'),ELEMENTS,ROOT('Json')) AS XML)
 
END
