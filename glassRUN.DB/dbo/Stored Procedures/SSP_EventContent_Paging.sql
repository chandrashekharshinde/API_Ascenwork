CREATE PROCEDURE [dbo].[SSP_EventContent_Paging] --'<Json><ServicesAction>LoadUserProfile</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><UserName></UserName><UserNameCriteria></UserNameCriteria><EmailId></EmailId><EmailIdCriteria></EmailIdCriteria><LicenseNumber></LicenseNumber><LicenseNumberCriteria></LicenseNumberCriteria><ContactNumber></ContactNumber><ContactNumberCriteria></ContactNumberCriteria><CarrierId>358</CarrierId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
Declare @sql1 nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @whereClauseIcon NVARCHAR(max)

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)

DECLARE @RoleName nvarchar(150)
DECLARE @RoleNameCriteria nvarchar(50)
DECLARE @UserName nvarchar(150)
DECLARE @UserNameCriteria nvarchar(50)
DECLARE @Recipient nvarchar(150)
DECLARE @RecipientCriteria nvarchar(50)
DECLARE @NotificationType nvarchar(150)
DECLARE @NotificationTypeCriteria nvarchar(50)
DECLARE @EventCode nvarchar(150)
DECLARE @EventCodeCriteria nvarchar(50)










set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	@EventCode=tmp.[EventCode],
	@EventCodeCriteria=tmp.[EventCodeCriteria],
	@NotificationType=tmp.[NotificationType],
	@NotificationTypeCriteria=tmp.[NotificationTypeCriteria],
    @RoleName=tmp.[RoleName],
	@RoleNameCriteria=tmp.[RoleNameCriteria],
	@UserName=tmp.[UserName],
	@UserNameCriteria=tmp.[UserNameCriteria],
	@Recipient=tmp.[Recipient],
	@RecipientCriteria=tmp.[RecipientCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
	[PageIndex] int,
	[PageSize] int,
	[OrderBy] nvarchar(2000),
	[EventCode] nvarchar(150),
	[EventCodeCriteria] nvarchar(50),
	[NotificationType] nvarchar(150),
	[NotificationTypeCriteria] nvarchar(50),
	[RoleName] nvarchar(150),
	[RoleNameCriteria] nvarchar(50),
	[UserName] nvarchar(150),
	[UserNameCriteria] nvarchar(50),
	[Recipient] nvarchar(150),
	[RecipientCriteria] nvarchar(50),
	[CarrierId] int
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @EventCode !=''
BEGIN

  IF @EventCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @EventCode + '%'''
  END
  IF @EventCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode NOT LIKE ''%' + @EventCode + '%'''
  END
  IF @EventCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''' + @EventCode + '%'''
  END
  IF @EventCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @EventCode + ''''
  END          
  IF @EventCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode =  ''' +@EventCode+ ''''
  END
  IF @EventCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode <>  ''' +@EventCode+ ''''
  END
END

IF @NotificationType !=''
BEGIN

  IF @NotificationTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and NotificationType LIKE ''%' + @NotificationType + '%'''
  END
  IF @NotificationTypeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and NotificationType NOT LIKE ''%' + @NotificationType + '%'''
  END
  IF @NotificationTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and NotificationType LIKE ''' + @NotificationType + '%'''
  END
  IF @NotificationTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and NotificationType LIKE ''%' + @NotificationType + ''''
  END          
  IF @NotificationTypeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and NotificationType =  ''' +@NotificationType+ ''''
  END
  IF @NotificationTypeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and NotificationType <>  ''' +@NotificationType+ ''''
  END
END

IF @RoleName !=''
BEGIN

  IF @RoleNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @RoleName + '%'''
  END
  IF @RoleNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') NOT LIKE ''%' + @RoleName + '%'''
  END
  IF @RoleNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') LIKE ''' + @RoleName + '%'''
  END
  IF @RoleNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @RoleName + ''''
  END          
  IF @RoleNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') =  ''' +@RoleName+ ''''
  END
  IF @RoleNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') <>  ''' +@RoleName+ ''''
  END
END

IF @UserName !=''
BEGIN

  IF @UserNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') NOT LIKE ''%' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') LIKE ''' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @UserName + ''''
  END          
  IF @UserNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') =  ''' +@UserName+ ''''
  END
  IF @UserNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') <>  ''' +@UserName+ ''''
  END
END

IF @Recipient !=''
BEGIN

  IF @RecipientCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @Recipient + '%'''
  END
  IF @RecipientCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') NOT LIKE ''%' + @Recipient + '%'''
  END
  IF @RecipientCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') LIKE ''' + @Recipient + '%'''
  END
  IF @RecipientCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') LIKE ''%' + @Recipient + ''''
  END          
  IF @RecipientCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') =  ''' +@Recipient+ ''''
  END
  IF @RecipientCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') <>  ''' +@Recipient+ ''''
  END
END



set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			[EventContentId],
			[EventMasterId],
			[NotificationTypeMasterId],
			[EventCode],
			[NotificationType],
			EventDescription,
			[RoleName] as RoleName,
			[UserName] as UserName,
			[Recipient] as Recipient,
			[IsActive],
			[CreatedBy],
			[CreatedDate],	
			[UpdatedBy],
			[UpdatedDate]

			 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ec.UpdatedDate,ec.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			
		    ec.[EventContentId],
			ec.[EventMasterId],
			ec.[NotificationTypeMasterId],
			ec.EventCode,
			ec.NotificationType,
			(select top 1 EventDescription from EventMaster where EventMasterId=ec.[EventMasterId]) as EventDescription,
			STUFF( (SELECT '', '' +  Recipient + Replace('' ('' + RecipientType + '')'',''()'','''') FROM EventRecipient op  where op.EventContentid = ec.EventContentId and isnull(Recipient,'''') != '''' and op.EventContentId=ec.EventContentId  and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') Recipient,
			STUFF( (SELECT '', '' +  [UserName] + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join Login l on ep.userid =l.LoginId where  isnull(ep.UserId,'''') != ''''  and ep.EventContentId=ec.EventContentId and ep.isactive=1  fOR XML PATH (''''))  , 1, 1, '''') UserName,
			STUFF( (SELECT '', '' +  RoleName + Replace('' ('' + RecipientType + '')'',''()'','''') FROM  EventRecipient ep join RoleMaster op  on ep.RoleMasterId=op.RoleMasterId where  isnull(ep.RoleMasterId,'''') != '''' and ep.EventContentId=ec.EventContentId and ep.isactive=1 fOR XML PATH (''''))  , 1, 1, '''') RoleName,
			ec.[IsActive],
			ec.[CreatedBy],
			ec.[CreatedDate],	
			ec.[UpdatedBy],
			ec.[UpdatedDate] 
			from EventContent ec 
			where ec.IsActive = 1 
			  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''EventContentList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END
