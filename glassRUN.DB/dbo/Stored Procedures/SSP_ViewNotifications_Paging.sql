
CREATE PROCEDURE [dbo].[SSP_ViewNotifications_Paging] --'<Json><ServicesAction>LoadViewNotificationsGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><Title></Title><TitleCriteria></TitleCriteria><CreatedDate></CreatedDate><CreatedDateCriteria></CreatedDateCriteria><RoleMasterId>3</RoleMasterId><UserId>507</UserId><LoginId>507</LoginId><CultureId>1101</CultureId><PageName>ViewNotifications</PageName><PageControlName></PageControlName></Json>'
	(@xmlDoc XML)
AS
BEGIN
	--Added By Chetan Tambe (17 Sept 2019)
	DECLARE @sqlTotalCount NVARCHAR(max)
	DECLARE @sql NVARCHAR(max)
	DECLARE @sql1 NVARCHAR(max)
	DECLARE @sql2 NVARCHAR(max)
	DECLARE @sql3 NVARCHAR(max)
	DECLARE @intPointer INT;
	DECLARE @whereClause NVARCHAR(max)
	DECLARE @roleId BIGINT
	DECLARE @userId BIGINT
	DECLARE @LoginId BIGINT
	DECLARE @PageSize INT
	DECLARE @PageIndex INT
	DECLARE @OrderBy NVARCHAR(150)
	DECLARE @PageName NVARCHAR(150)
	DECLARE @PageControlName NVARCHAR(150)
	DECLARE @CreatedDate NVARCHAR(150)
	DECLARE @CreatedDateCriteria NVARCHAR(50)
	DECLARE @IsAckDatetime NVARCHAR(150)
	DECLARE @IsAckDatetimeCriteria NVARCHAR(50)
	DECLARE @Title NVARCHAR(50)
	DECLARE @TitleCriteria NVARCHAR(50)
	DECLARE @PaginationClause NVARCHAR(max)

	SET @whereClause = ''
	SET @PaginationClause = ''

	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	SELECT @Title = tmp.[Title]
		,@TitleCriteria = tmp.[TitleCriteria]
		,@CreatedDate = tmp.[CreatedDate]
		,@CreatedDateCriteria = tmp.[CreatedDateCriteria]
		,@PageSize = tmp.[PageSize]
		,@PageIndex = tmp.[PageIndex]
		,@roleId = tmp.[RoleMasterId]
		,@LoginId = tmp.[LoginId]
		,@IsAckDatetime = tmp.[IsAckDatetime]
		,@IsAckDatetimeCriteria = tmp.[IsAckDatetimeCriteria]

	FROM OPENXML(@intpointer, 'Json', 2) WITH (
			[PageIndex] INT
			,[PageSize] INT
			,[RoleMasterId] BIGINT
			,[CreatedDate] NVARCHAR(150)
			,[CreatedDateCriteria] NVARCHAR(50)
			,[LoginId] BIGINT
			,[Title] NVARCHAR(150)
			,[TitleCriteria] NVARCHAR(50)
			,[IsAckDatetime] NVARCHAR(150)
			,[IsAckDatetimeCriteria] NVARCHAR(50)
			) tmp

	IF (RTRIM(@orderBy) = '')
	BEGIN
		SET @orderBy = 'CreatedDate desc'
	END

	IF (RTRIM(@whereClause) = '')
	BEGIN
		SET @whereClause = ' and 1=1'
	END


	SET @PageIndex = (CONVERT(BIGINT, @PageIndex) + 1)

	

	IF @Title != ''
	BEGIN
		IF @TitleCriteria = 'contains'
		BEGIN
			SET @whereClause = @whereClause + ' and Title LIKE ''%' + @Title + '%'''
		END

		IF @TitleCriteria = 'notcontains'
		BEGIN
			SET @whereClause = @whereClause + ' and Title NOT LIKE ''%' + @Title + '%'''
		END

		IF @TitleCriteria = 'startswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Title LIKE ''' + @Title + '%'''
		END

		IF @TitleCriteria = 'endswith'
		BEGIN
			SET @whereClause = @whereClause + ' and Title LIKE ''%' + @Title + ''''
		END

		IF @TitleCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber =  ''' + @Title + ''''
		END

		IF @TitleCriteria = '<>'
		BEGIN
			SET @whereClause = @whereClause + ' and SalesOrderNumber <>  ''' + @Title + ''''
		END
	END



	IF @CreatedDate != ''
	BEGIN
		IF @CreatedDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,CreatedDate,103) >= CONVERT(date,''' + @CreatedDate + ''',103)'
		END
		ELSE IF @CreatedDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,CreatedDate,103) < CONVERT(date,''' + @CreatedDate + ''',103)'
		END
		ELSE IF @CreatedDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,CreatedDate,103) = CONVERT(date,''' + @CreatedDate + ''',103)'
		END
	END

	IF @IsAckDatetime != ''
	BEGIN
		IF @IsAckDatetimeCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,IsAckDatetime,103) >= CONVERT(date,''' + @IsAckDatetime + ''',103)'
		END
		ELSE IF @IsAckDatetimeCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,IsAckDatetime,103) < CONVERT(date,''' + @IsAckDatetime + ''',103)'
		END
		ELSE IF @IsAckDatetimeCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,IsAckDatetime,103) = CONVERT(date,''' + @IsAckDatetime + ''',103)'
		END
	END

	SET @PaginationClause = '' + (
				SELECT [dbo].[fn_GetPaginationString](@PageSize, @PageIndex)
				) + ''

	PRINT @whereClause

	SET @sql = 
		'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select  ''true'' AS [@json:Array]
		,(Select Count(NotificationRequestId) FROM [dbo].[NotificationRequest] txtp1 WHERE NotifcationType=''PORTAL''
		 ' + @whereClause + ' and LoginId=' + CAST(@LoginId as nvarchar(50)) + 
		' ) [TotalCount] ,NotificationRequestId, Title, CreatedDate, IsAckDatetime, IsNull(IsAck,0) as IsAck from 
		(select ROW_NUMBER() OVER (ORDER BY NotificationRequestId desc) as [rownumber],
		* from  NotificationRequest  where NotifcationType=''PORTAL'' and LoginId=' + CAST(@LoginId as nvarchar(50)) + ')tmp  WHERE ' + @PaginationClause +  
		+ @whereClause + ' order by CreatedDate desc FOR XML path(''EventNotificationList''),ELEMENTS,ROOT(''Json'')) AS XML)'

	PRINT @whereClause
	PRINT @sql
	PRINT @sql1

	EXEC (@sql + @sql1)
END