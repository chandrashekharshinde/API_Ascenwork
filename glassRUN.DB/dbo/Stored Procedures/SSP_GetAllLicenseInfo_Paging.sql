

CREATE PROCEDURE [dbo].[SSP_GetAllLicenseInfo_Paging]
(
	@xmlDoc XML
)
AS
BEGIN
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Declare @sqlTotalCount nvarchar(4000)
		Declare @sql nvarchar(4000)
		DECLARE @whereClause NVARCHAR(max)

		Declare @PageSize INT
		Declare @PageIndex INT
		Declare @OrderBy NVARCHAR(100)

		DECLARE @LicenseId		nvarchar(100)
		DECLARE @CustomerCode	nvarchar(100)
		DECLARE @ProductCode	nvarchar(100)
		DECLARE @ActivationCode	nvarchar(100)
		DECLARE @FromDate		nvarchar(100)
		DECLARE @ToDate			nvarchar(100)
		DECLARE @UserTypeCode	nvarchar(100)
		DECLARE @NoOfUsers		nvarchar(100)
		DECLARE @LicenseType	nvarchar(100)
		DECLARE @IPAddress		nvarchar(100)

		DECLARE @CustomerCodeCriteria	nvarchar(100)
		DECLARE @ProductCodeCriteria	nvarchar(100)
		DECLARE @ActivationCodeCriteria	nvarchar(100)
		DECLARE @FromDateCriteria		nvarchar(100)
		DECLARE @ToDateCriteria			nvarchar(100)
		DECLARE @UserTypeCodeCriteria	nvarchar(100)
		DECLARE @NoOfUsersCriteria		nvarchar(100)
		DECLARE @LicenseTypeCriteria	nvarchar(100)
		DECLARE @IPAddressCriteria		nvarchar(100)

		Set  @whereClause =''

		SELECT
			@LicenseId=tmp.[LicenseId],
			@CustomerCode=tmp.[CustomerCode],
			@CustomerCodeCriteria=tmp.[CustomerCodeCriteria],
			@ProductCode=tmp.[ProductCode],
			@ProductCodeCriteria=tmp.[ProductCodeCriteria],
			@ActivationCode=tmp.[ActivationCode],
			@ActivationCodeCriteria=tmp.[ActivationCodeCriteria],
			@FromDate=tmp.[FromDate],
			@FromDateCriteria=tmp.[FromDateCriteria],
			@ToDate=tmp.[ToDate],
			@ToDateCriteria=tmp.[ToDateCriteria],
			@UserTypeCode=tmp.[UserTypeCode],
			@UserTypeCodeCriteria=tmp.[UserTypeCodeCriteria],
			@NoOfUsers=tmp.[NoOfUsers],
			@NoOfUsersCriteria=tmp.[NoOfUsersCriteria],
			@LicenseType=tmp.[LicenseType],
			@LicenseTypeCriteria=tmp.[LicenseTypeCriteria],
			@IPAddress=tmp.[IPAddress],
			@IPAddressCriteria=tmp.[IPAddressCriteria],
			@PageSize = tmp.[PageSize],
			@PageIndex = tmp.[PageIndex],
			@OrderBy = tmp.[OrderBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),  
			[LicenseId] [bigint] ,
			[CustomerCode] [nvarchar](100) ,
			[ProductCode] [nvarchar](100) ,
			[ActivationCode] [nvarchar](500) ,
			[FromDate] [datetime] ,
			[ToDate] [datetime] ,
			[UserTypeCode] [nvarchar](100) ,
			[NoOfUsers] [nvarchar](100) ,
			[LicenseType] [nvarchar](100) ,
			[IPAddress] [nvarchar](100),
			[CustomerCodeCriteria] [nvarchar](100) ,
			[ProductCodeCriteria] [nvarchar](100) ,
			[ActivationCodeCriteria] [nvarchar](500) ,
			[FromDateCriteria] [datetime] ,
			[ToDateCriteria] [datetime] ,
			[UserTypeCodeCriteria] [nvarchar](100) ,
			[NoOfUsersCriteria] [nvarchar](100) ,
			[LicenseTypeCriteria] [nvarchar](100) ,
			[IPAddressCriteria] [nvarchar](100)
		)tmp

		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'LicenseId' END

		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

		--IF @PlanName !=''
		--BEGIN
		
		--  IF @PlanNameCriteria = 'contains'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and PlanName LIKE ''%' + @PlanName + '%'''
		--  END
		--  IF @PlanNameCriteria = 'doesnotcontain'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and PlanName NOT LIKE ''%' + @PlanName + '%'''
		--  END
		--  IF @PlanNameCriteria = 'startswith'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and PlanName LIKE ''' + @PlanName + '%'''
		--  END
		--  IF @PlanNameCriteria = 'endswith'
		--  BEGIN
		  
		--  SET @whereClause = @whereClause + ' and PlanName LIKE ''%' + @PlanName + ''''
		--  END          
		--  IF @PlanNameCriteria = '='
		-- BEGIN
		
		-- SET @whereClause = @whereClause + ' and PlanName =  ''' +@PlanName+ ''''
		--  END
		--  IF @PlanNameCriteria = '<>'
		-- BEGIN
		
		-- SET @whereClause = @whereClause + ' and PlanName <>  ''' +@PlanName+ ''''
		--  END
		--END

		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						RowNumber,
						TotalCount,
						[LicenseId], 
						[CustomerCode], 
						[ProductCode], 
						[ActivationCode], 
						[FromDate], 
						[ToDate], 
						[UserTypeCode], 
						[NoOfUsers], 
						[LicenseType], 
						[IPAddress]
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY LicenseId desc) as RowNumber, 
							COUNT(LicenseId) OVER () as TotalCount,
							[LicenseId], 
							[CustomerCode], 
							[ProductCode], 
							[ActivationCode], 
							[FromDate], 
							[ToDate], 
							[UserTypeCode], 
							[NoOfUsers], 
							[LicenseType], 
							[IPAddress]
						FROM [LicenseInfo]
						WHERE 1 = 1 
						and ' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''LicenseInfoList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
