
CREATE PROCEDURE [dbo].[SSP_EventRetrySettings_Paging] 
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

DECLARE @EventName nvarchar(150)
DECLARE @EventNameCriteria nvarchar(50)
DECLARE @NotificationTypeName nvarchar(150)
DECLARE @NotificationTypeNameCriteria nvarchar(50)
DECLARE @RetryCount nvarchar(150)
DECLARE @RetryCountCriteria nvarchar(50)








set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @EventName=tmp.[EventName],
	@EventNameCriteria=tmp.[EventNameCriteria],
	@NotificationTypeName=tmp.[NotificationTypeName],
	@NotificationTypeNameCriteria=tmp.[NotificationTypeNameCriteria],
	@RetryCount=tmp.[RetryCount],
	@RetryCountCriteria=tmp.[RetryCountCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [EventName] nvarchar(150),
   [EventNameCriteria] nvarchar(50),
   [NotificationTypeName] nvarchar(150),
   [NotificationTypeNameCriteria] nvarchar(50),
   [RetryCount] nvarchar(150),
   [RetryCountCriteria] nvarchar(50)
 
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @EventName !=''
BEGIN

  IF @EventNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and em.EventCode LIKE ''%' + @EventName + '%'''
  END
  IF @EventNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and em.EventCode NOT LIKE ''%' + @EventName + '%'''
  END
  IF @EventNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and em.EventCode LIKE ''' + @EventName + '%'''
  END
  IF @EventNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and em.EventCode LIKE ''%' + @EventName + ''''
  END          
  IF @EventNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and em.EventCode =  ''' +@EventName+ ''''
  END
  IF @EventNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and em.EventCode <>  ''' +@EventName+ ''''
  END
END

IF @NotificationTypeName !=''
BEGIN

  IF @NotificationTypeNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.NotificationType LIKE ''%' + @NotificationTypeName + '%'''
  END
  IF @NotificationTypeNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.NotificationType NOT LIKE ''%' + @NotificationTypeName + '%'''
  END
  IF @NotificationTypeNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.NotificationType LIKE ''' + @NotificationTypeName + '%'''
  END
  IF @NotificationTypeNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.NotificationType LIKE ''%' + @NotificationTypeName + ''''
  END          
  IF @NotificationTypeNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ers.NotificationType =  ''' +@NotificationTypeName+ ''''
  END
  IF @NotificationTypeNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ers.NotificationType <>  ''' +@NotificationTypeName+ ''''
  END
END

IF @RetryCount !=''
BEGIN

  IF @RetryCountCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.RetryCount LIKE ''%' + @RetryCount + '%'''
  END
  IF @RetryCountCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.RetryCount NOT LIKE ''%' + @RetryCount + '%'''
  END
  IF @RetryCountCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.RetryCount LIKE ''' + @RetryCount + '%'''
  END
  IF @RetryCountCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ers.RetryCount LIKE ''%' + @RetryCount + ''''
  END          
  IF @RetryCountCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ers.RetryCount =  ''' +@RetryCount+ ''''
  END
  IF @RetryCountCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ers.RetryCount <>  ''' +@RetryCount+ ''''
  END
END



set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			EventRetrySettingsId,
			NotificationType,
			RetryCount,
			RetryInterval,
			EventCode 

			 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ers.UpdatedDate,ers.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			
			ers.EventRetrySettingsId,
			ers.NotificationType,
			ers.RetryCount,
			ers.RetryInterval,
			em.EventCode 
			from EventretrySettings ers
			inner join  EventMaster em on ers.EventMasterId=em.EventMasterId
			inner join NotificationTypeMaster ntm on ers.notificationTypemasterId=ntm.NotificationTypeMasterId
			where em.IsActive=1 and ers.IsActive=1 and ntm.IsActive=1

			and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''EventRetrySettingsList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END
