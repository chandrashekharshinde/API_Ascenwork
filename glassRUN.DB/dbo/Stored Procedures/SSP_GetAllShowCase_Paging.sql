CREATE PROCEDURE [dbo].[SSP_GetAllShowCase_Paging]-- '<Json><ServicesAction>GetAllTransportVehicle_Paging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><VehicleName></VehicleName><VehicleNameCriteria></VehicleNameCriteria><VehicleRegistrationNumber></VehicleRegistrationNumber><VehicleRegistrationNumberCriteria></VehicleRegistrationNumberCriteria><TransporterName></TransporterName><TransporterNameCriteria></TransporterNameCriteria><VehicleTypeName></VehicleTypeName><VehicleTypeNameCriteria></VehicleTypeNameCriteria><NumberOfCompartments></NumberOfCompartments><NumberOfCompartmentsCriteria></NumberOfCompartmentsCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><SequenceNumber></SequenceNumber><SequenceNumberCriteria></SequenceNumberCriteria><InsuranceValidityDate></InsuranceValidityDate><InsuranceValidityDateCriteria></InsuranceValidityDateCriteria><FitnessCertificateDate></FitnessCertificateDate><FitnessCertificateDateCriteria></FitnessCertificateDateCriteria><VehicleOwnerName></VehicleOwnerName><VehicleOwnerNameCriteria></VehicleOwnerNameCriteria><VehicleOwnerAddress1></VehicleOwnerAddress1><VehicleOwnerAddress1Criteria></VehicleOwnerAddress1Criteria><VehicleOwnerAddress2></VehicleOwnerAddress2><VehicleOwnerAddress2Criteria></VehicleOwnerAddress2Criteria><Field1></Field1><Field1Criteria></Field1Criteria><Field2></Field2><Field2Criteria></Field2Criteria><Field3></Field3><Field3Criteria></Field3Criteria><Field4></Field4><Field4Criteria></Field4Criteria><Field5></Field5><Field5Criteria></Field5Criteria><Field6></Field6><Field6Criteria></Field6Criteria><Field7></Field7><Field7Criteria></Field7Criteria><Field8></Field8><Field8Criteria></Field8Criteria><Field9></Field9><Field9Criteria></Field9Criteria><Field10></Field10><Field10Criteria></Field10Criteria><CompanyId>664</CompanyId><RoleId>2</RoleId></Json>'
(
	@xmlDoc XML
)
AS
BEGIN
	
	-- exec [dbo].[SSP_GetAllTransportVehicle_Paging] '<Json><ServicesAction>GetAllPaymentPlanPaging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><PlanName></PlanName><PlanNameCriteria></PlanNameCriteria><SlabName></SlabName><SlabNameCriteria></SlabNameCriteria><Amount></Amount><AmountCriteria></AmountCriteria><AmountUnitName></AmountUnitName><AmountUnitNameCriteria></AmountUnitNameCriteria><EffectiveFrom></EffectiveFrom><EffectiveFromCriteria></EffectiveFromCriteria><EffectiveTo></EffectiveTo><EffectiveToCriteria></EffectiveToCriteria><ApplicableAfterName></ApplicableAfterName><ApplicableAfterNameCriteria></ApplicableAfterNameCriteria></Json>'	
	
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
		DECLARE @whereClause nvarchar(4000)

		Declare @PageSize INT
		Declare @PageIndex INT
		Declare @OrderBy NVARCHAR(100)

		Declare @RoleId INT
		Declare @CompanyId INT

		DECLARE @VehicleName nvarchar(100)
		DECLARE @VehicleNameCriteria nvarchar(100)
		DECLARE @VehicleRegistrationNumber nvarchar(100)
		DECLARE @VehicleRegistrationNumberCriteria nvarchar(100)
		DECLARE @TransporterName nvarchar(100)
		DECLARE @TransporterNameCriteria nvarchar(100)
		DECLARE @VehicleTypeName nvarchar(100)
		DECLARE @VehicleTypeNameCriteria nvarchar(100)
		DECLARE @NumberOfCompartments nvarchar(100)
		DECLARE @NumberOfCompartmentsCriteria nvarchar(100)
		DECLARE @TruckSize nvarchar(100)
		DECLARE @TruckSizeCriteria nvarchar(100)
		DECLARE @SequenceNumber nvarchar(100)
		DECLARE @SequenceNumberCriteria nvarchar(100)
		DECLARE @InsuranceValidityDate nvarchar(100)
		DECLARE @InsuranceValidityDateCriteria nvarchar(100)
		DECLARE @FitnessCertificateDate nvarchar(100)
		DECLARE @FitnessCertificateDateCriteria nvarchar(100)
		DECLARE @VehicleOwnerName nvarchar(100)
		DECLARE @VehicleOwnerNameCriteria nvarchar(100)
		DECLARE @VehicleOwnerAddress1 nvarchar(100)
		DECLARE @VehicleOwnerAddress1Criteria nvarchar(100)
		DECLARE @VehicleOwnerAddress2 nvarchar(100)
		DECLARE @VehicleOwnerAddress2Criteria nvarchar(100)
		DECLARE @Field1 nvarchar(100)
		DECLARE @Field1Criteria nvarchar(100)
		DECLARE @Field2 nvarchar(100)
		DECLARE @Field2Criteria nvarchar(100)
		DECLARE @Field3 nvarchar(100)
		DECLARE @Field3Criteria nvarchar(100)
		DECLARE @Field4 nvarchar(100)
		DECLARE @Field4Criteria nvarchar(100)
		DECLARE @Field5 nvarchar(100)
		DECLARE @Field5Criteria nvarchar(100)
		DECLARE @Field6 nvarchar(100)
		DECLARE @Field6Criteria nvarchar(100)
		DECLARE @Field7 nvarchar(100)
		DECLARE @Field7Criteria nvarchar(100)
		DECLARE @Field8 nvarchar(100)
		DECLARE @Field8Criteria nvarchar(100)
		DECLARE @Field9 nvarchar(100)
		DECLARE @Field9Criteria nvarchar(100)
		DECLARE @Field10 nvarchar(100)
		DECLARE @Field10Criteria nvarchar(100)

		Set  @whereClause =''

		SELECT
			@VehicleName=tmp.[VehicleName],
			@VehicleNameCriteria=tmp.[VehicleNameCriteria],
			@VehicleRegistrationNumber=tmp.[VehicleRegistrationNumber],
			@VehicleRegistrationNumberCriteria=tmp.[VehicleRegistrationNumberCriteria],
			@TransporterName=tmp.[TransporterName],
			@TransporterNameCriteria=tmp.[TransporterNameCriteria],
			@VehicleTypeName=tmp.[VehicleTypeName],
			@VehicleTypeNameCriteria=tmp.[VehicleTypeNameCriteria],
			@NumberOfCompartments=tmp.[NumberOfCompartments],
			@NumberOfCompartmentsCriteria=tmp.[NumberOfCompartmentsCriteria],
			@TruckSize=tmp.[TruckSize],
			@TruckSizeCriteria=tmp.[TruckSizeCriteria],
			@SequenceNumber=tmp.[SequenceNumber],
			@SequenceNumberCriteria=tmp.[SequenceNumberCriteria],
			@InsuranceValidityDate=tmp.[InsuranceValidityDate],
			@InsuranceValidityDateCriteria=tmp.[InsuranceValidityDateCriteria],
			@FitnessCertificateDate=tmp.[FitnessCertificateDate],
			@FitnessCertificateDateCriteria=tmp.[FitnessCertificateDateCriteria],
			@VehicleOwnerName=tmp.[VehicleOwnerName],
			@VehicleOwnerNameCriteria=tmp.[VehicleOwnerNameCriteria],
			@VehicleOwnerAddress1=tmp.[VehicleOwnerAddress1],
			@VehicleOwnerAddress1Criteria=tmp.[VehicleOwnerAddress1Criteria],
			@VehicleOwnerAddress2=tmp.[VehicleOwnerAddress2],
			@VehicleOwnerAddress2Criteria=tmp.[VehicleOwnerAddress2Criteria],
			@Field1=tmp.[Field1],
			@Field1Criteria=tmp.[Field1Criteria],
			@Field2=tmp.[Field2],
			@Field2Criteria=tmp.[Field2Criteria],
			@Field3=tmp.[Field3],
			@Field3Criteria=tmp.[Field3Criteria],
			@Field4=tmp.[Field4],
			@Field4Criteria=tmp.[Field4Criteria],
			@Field5=tmp.[Field5],
			@Field5Criteria=tmp.[Field5Criteria],
			@Field6=tmp.[Field6],
			@Field6Criteria=tmp.[Field6Criteria],
			@Field7=tmp.[Field7],
			@Field7Criteria=tmp.[Field7Criteria],
			@Field8=tmp.[Field8],
			@Field8Criteria=tmp.[Field8Criteria],
			@Field9=tmp.[Field9],
			@Field9Criteria=tmp.[Field9Criteria],
			@Field10=tmp.[Field10],
			@Field10Criteria=tmp.[Field10Criteria],
			@RoleId=tmp.[RoleId],
			@CompanyId=tmp.[CompanyId],
			@PageSize = tmp.[PageSize],
			@PageIndex = tmp.[PageIndex],
			@OrderBy = tmp.[OrderBy]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),  
			[VehicleName] nvarchar(100),
			[VehicleNameCriteria] nvarchar(100),
			[VehicleRegistrationNumber] nvarchar(100),
			[VehicleRegistrationNumberCriteria] nvarchar(100),
			[TransporterName] nvarchar(100),
			[TransporterNameCriteria] nvarchar(100),
			[VehicleTypeName] nvarchar(100),
			[VehicleTypeNameCriteria] nvarchar(100),
			[NumberOfCompartments] nvarchar(100),
			[NumberOfCompartmentsCriteria] nvarchar(100),
			[TruckSize] nvarchar(100),
			[TruckSizeCriteria] nvarchar(100),
			[SequenceNumber] nvarchar(100),
			[SequenceNumberCriteria] nvarchar(100),
			[InsuranceValidityDate] nvarchar(100),
			[InsuranceValidityDateCriteria] nvarchar(100),
			[FitnessCertificateDate] nvarchar(100),
			[FitnessCertificateDateCriteria] nvarchar(100),
			[VehicleOwnerName] nvarchar(100),
			[VehicleOwnerNameCriteria] nvarchar(100),
			[VehicleOwnerAddress1] nvarchar(100),
			[VehicleOwnerAddress1Criteria] nvarchar(100),
			[VehicleOwnerAddress2] nvarchar(100),
			[VehicleOwnerAddress2Criteria] nvarchar(100),
			[Field1] nvarchar(100),
			[Field1Criteria] nvarchar(100),
			[Field2] nvarchar(100),
			[Field2Criteria] nvarchar(100),
			[Field3] nvarchar(100),
			[Field3Criteria] nvarchar(100),
			[Field4] nvarchar(100),
			[Field4Criteria] nvarchar(100),
			[Field5] nvarchar(100),
			[Field5Criteria] nvarchar(100),
			[Field6] nvarchar(100),
			[Field6Criteria] nvarchar(100),
			[Field7] nvarchar(100),
			[Field7Criteria] nvarchar(100),
			[Field8] nvarchar(100),
			[Field8Criteria] nvarchar(100),
			[Field9] nvarchar(100),
			[Field9Criteria] nvarchar(100),
			[Field10] nvarchar(100),
			[Field10Criteria] nvarchar(100),
			[RoleId] int,
			[CompanyId] int
		)tmp


		IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ShowCaseId' END


		IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

		SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


		IF @VehicleName !=''
		BEGIN
		
			IF @VehicleNameCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleName LIKE ''%' + @VehicleName + '%'''
			END
			IF @VehicleNameCriteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleName NOT LIKE ''%' + @VehicleName + '%'''
			END
			IF @VehicleNameCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleName LIKE ''' + @VehicleName + '%'''
			END
			IF @VehicleNameCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleName LIKE ''%' + @VehicleName + ''''
			END          
			IF @VehicleNameCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleName =  ''' +@VehicleName+ ''''
			END
			IF @VehicleNameCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleName <>  ''' +@VehicleName+ ''''
			END
		END

		IF @VehicleRegistrationNumber !=''
		BEGIN
		
			IF @VehicleRegistrationNumberCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleRegistrationNumber LIKE ''%' + @VehicleRegistrationNumber + '%'''
			END
			IF @VehicleRegistrationNumberCriteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleRegistrationNumber NOT LIKE ''%' + @VehicleRegistrationNumber + '%'''
			END
			IF @VehicleRegistrationNumberCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleRegistrationNumber LIKE ''' + @VehicleRegistrationNumber + '%'''
			END
			IF @VehicleRegistrationNumberCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleRegistrationNumber LIKE ''%' + @VehicleRegistrationNumber + ''''
			END          
			IF @VehicleRegistrationNumberCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleRegistrationNumber =  ''' +@VehicleRegistrationNumber+ ''''
			END
			IF @VehicleRegistrationNumberCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleRegistrationNumber <>  ''' +@VehicleRegistrationNumber+ ''''
			END
		END

		IF @TransporterName !=''
		BEGIN
		
			IF @TransporterNameCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @TransporterName + '%'''
			END
			IF @TransporterNameCriteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and c.CompanyName NOT LIKE ''%' + @TransporterName + '%'''
			END
			IF @TransporterNameCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''' + @TransporterName + '%'''
			END
			IF @TransporterNameCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @TransporterName + ''''
			END          
			IF @TransporterNameCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and c.CompanyName =  ''' +@TransporterName+ ''''
			END
			IF @TransporterNameCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and c.CompanyName <>  ''' +@TransporterName+ ''''
			END
		END

		IF @VehicleTypeName !=''
		BEGIN
		
			IF @VehicleTypeNameCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and lvt.Name LIKE ''%' + @VehicleTypeName + '%'''
			END
			IF @VehicleTypeNameCriteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and lvt.Name NOT LIKE ''%' + @VehicleTypeName + '%'''
			END
			IF @VehicleTypeNameCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and lvt.Name LIKE ''' + @VehicleTypeName + '%'''
			END
			IF @VehicleTypeNameCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and lvt.Name LIKE ''%' + @VehicleTypeName + ''''
			END          
			IF @VehicleTypeNameCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and lvt.Name =  ''' +@VehicleTypeName+ ''''
			END
			IF @VehicleTypeNameCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and lvt.Name <>  ''' +@VehicleTypeName+ ''''
			END
		END

		IF @NumberOfCompartments !=''
		BEGIN
			IF @NumberOfCompartmentsCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(tv.NumberOfCompartments,0)) =  CONVERT(float,'''+@NumberOfCompartments+''')'
			END
			Else IF @NumberOfCompartmentsCriteria = '>'
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(tv.NumberOfCompartments,0)) >  CONVERT(float,'''+@NumberOfCompartments+''')'
			END
			Else IF @NumberOfCompartmentsCriteria = '<'
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(tv.NumberOfCompartments,0)) <  CONVERT(float,'''+@NumberOfCompartments+''')'
			END
		END

		IF @TruckSize !=''
		BEGIN
		
			IF @TruckSizeCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and ts.TruckSize LIKE ''%' + @TruckSize + '%'''
			END
			IF @TruckSizeCriteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and ts.TruckSize NOT LIKE ''%' + @TruckSize + '%'''
			END
			IF @TruckSizeCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and ts.TruckSize LIKE ''' + @TruckSize + '%'''
			END
			IF @TruckSizeCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and ts.TruckSize LIKE ''%' + @TruckSize + ''''
			END          
			IF @TruckSizeCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and ts.TruckSize =  ''' +@TruckSize+ ''''
			END
			IF @TruckSizeCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and ts.TruckSize <>  ''' +@TruckSize+ ''''
			END
		END

		IF @SequenceNumber !=''
		BEGIN
			IF @SequenceNumberCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(tv.SequenceNumber,0)) =  CONVERT(float,'''+@SequenceNumber+''')'
			END
			Else IF @SequenceNumberCriteria = '>'
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(tv.SequenceNumber,0)) >  CONVERT(float,'''+@SequenceNumber+''')'
			END
			Else IF @SequenceNumberCriteria = '<'
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(tv.SequenceNumber,0)) <  CONVERT(float,'''+@SequenceNumber+''')'
			END
		END

		IF @InsuranceValidityDate !=''
		BEGIN
			IF @InsuranceValidityDateCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(date,tv.InsuranceValidityDate,103) = CONVERT(date,'''+@InsuranceValidityDate+''',103)'
			END
			Else IF @InsuranceValidityDateCriteria = '>='
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(date,tv.InsuranceValidityDate,103) > CONVERT(date,'''+@InsuranceValidityDate+''',103)'
			END
			Else IF @InsuranceValidityDateCriteria = '<'
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(date,tv.InsuranceValidityDate,103) < CONVERT(date,'''+@InsuranceValidityDate+''',103)'
			END
		END

		IF @FitnessCertificateDate !=''
		BEGIN
			IF @FitnessCertificateDateCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(date,tv.FitnessCertificateDate,103) = CONVERT(date,'''+@FitnessCertificateDate+''',103)'
			END
			Else IF @FitnessCertificateDateCriteria = '>='
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(date,tv.FitnessCertificateDate,103) > CONVERT(date,'''+@FitnessCertificateDate+''',103)'
			END
			Else IF @FitnessCertificateDateCriteria = '<'
			BEGIN
				SET @whereClause = @whereClause + ' and CONVERT(date,tv.FitnessCertificateDate,103) < CONVERT(date,'''+@FitnessCertificateDate+''',103)'
			END
		END

		IF @VehicleOwnerName !=''
		BEGIN
		
			IF @VehicleOwnerNameCriteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerName LIKE ''%' + @VehicleOwnerName + '%'''
			END
			IF @VehicleOwnerNameCriteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerName NOT LIKE ''%' + @VehicleOwnerName + '%'''
			END
			IF @VehicleOwnerNameCriteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerName LIKE ''' + @VehicleOwnerName + '%'''
			END
			IF @VehicleOwnerNameCriteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerName LIKE ''%' + @VehicleOwnerName + ''''
			END          
			IF @VehicleOwnerNameCriteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerName =  ''' +@VehicleOwnerName+ ''''
			END
			IF @VehicleOwnerNameCriteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerName <>  ''' +@VehicleOwnerName+ ''''
			END
		END

		IF @VehicleOwnerAddress1 !=''
		BEGIN
		
			IF @VehicleOwnerAddress1Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress1 LIKE ''%' + @VehicleOwnerAddress1 + '%'''
			END
			IF @VehicleOwnerAddress1Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress1 NOT LIKE ''%' + @VehicleOwnerAddress1 + '%'''
			END
			IF @VehicleOwnerAddress1Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress1 LIKE ''' + @VehicleOwnerAddress1 + '%'''
			END
			IF @VehicleOwnerAddress1Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress1 LIKE ''%' + @VehicleOwnerAddress1 + ''''
			END          
			IF @VehicleOwnerAddress1Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress1 =  ''' +@VehicleOwnerAddress1+ ''''
			END
			IF @VehicleOwnerAddress1Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress1 <>  ''' +@VehicleOwnerAddress1+ ''''
			END
		END

		IF @VehicleOwnerAddress2 !=''
		BEGIN
		
			IF @VehicleOwnerAddress2Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress2 LIKE ''%' + @VehicleOwnerAddress2 + '%'''
			END
			IF @VehicleOwnerAddress2Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress2 NOT LIKE ''%' + @VehicleOwnerAddress2 + '%'''
			END
			IF @VehicleOwnerAddress2Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress2 LIKE ''' + @VehicleOwnerAddress2 + '%'''
			END
			IF @VehicleOwnerAddress2Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress2 LIKE ''%' + @VehicleOwnerAddress2 + ''''
			END          
			IF @VehicleOwnerAddress2Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress2 =  ''' +@VehicleOwnerAddress2+ ''''
			END
			IF @VehicleOwnerAddress2Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.VehicleOwnerAddress2 <>  ''' +@VehicleOwnerAddress2+ ''''
			END
		END

		IF @Field1 !=''
		BEGIN
		
			IF @Field1Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field1 LIKE ''%' + @Field1 + '%'''
			END
			IF @Field1Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field1 NOT LIKE ''%' + @Field1 + '%'''
			END
			IF @Field1Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field1 LIKE ''' + @Field1 + '%'''
			END
			IF @Field1Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field1 LIKE ''%' + @Field1 + ''''
			END          
			IF @Field1Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field1 =  ''' +@Field1+ ''''
			END
			IF @Field1Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field1 <>  ''' +@Field1+ ''''
			END
		END

		IF @Field2 !=''
		BEGIN
		
			IF @Field2Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field2 LIKE ''%' + @Field2 + '%'''
			END
			IF @Field2Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field2 NOT LIKE ''%' + @Field2 + '%'''
			END
			IF @Field2Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field2 LIKE ''' + @Field2 + '%'''
			END
			IF @Field2Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field2 LIKE ''%' + @Field2 + ''''
			END          
			IF @Field2Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field2 =  ''' +@Field2+ ''''
			END
			IF @Field2Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field2 <>  ''' +@Field2+ ''''
			END
		END

		IF @Field3 !=''
		BEGIN
		
			IF @Field3Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field3 LIKE ''%' + @Field3 + '%'''
			END
			IF @Field3Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field3 NOT LIKE ''%' + @Field3 + '%'''
			END
			IF @Field3Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field3 LIKE ''' + @Field3 + '%'''
			END
			IF @Field3Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field3 LIKE ''%' + @Field3 + ''''
			END          
			IF @Field3Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field3 =  ''' +@Field3+ ''''
			END
			IF @Field3Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field3 <>  ''' +@Field3+ ''''
			END
		END

		IF @Field4 !=''
		BEGIN
		
			IF @Field4Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field4 LIKE ''%' + @Field4 + '%'''
			END
			IF @Field4Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field4 NOT LIKE ''%' + @Field4 + '%'''
			END
			IF @Field4Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field4 LIKE ''' + @Field4 + '%'''
			END
			IF @Field4Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field4 LIKE ''%' + @Field4 + ''''
			END          
			IF @Field4Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field4 =  ''' +@Field4+ ''''
			END
			IF @Field4Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field4 <>  ''' +@Field4+ ''''
			END
		END

		IF @Field5 !=''
		BEGIN
		
			IF @Field5Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field5 LIKE ''%' + @Field5 + '%'''
			END
			IF @Field5Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field5 NOT LIKE ''%' + @Field5 + '%'''
			END
			IF @Field5Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field5 LIKE ''' + @Field5 + '%'''
			END
			IF @Field5Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field5 LIKE ''%' + @Field5 + ''''
			END          
			IF @Field5Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field5 =  ''' +@Field5+ ''''
			END
			IF @Field5Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field5 <>  ''' +@Field5+ ''''
			END
		END

		IF @Field6 !=''
		BEGIN
		
			IF @Field6Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field6 LIKE ''%' + @Field6 + '%'''
			END
			IF @Field6Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field6 NOT LIKE ''%' + @Field6 + '%'''
			END
			IF @Field6Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field6 LIKE ''' + @Field6 + '%'''
			END
			IF @Field6Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field6 LIKE ''%' + @Field6 + ''''
			END          
			IF @Field6Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field6 =  ''' +@Field6+ ''''
			END
			IF @Field6Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field6 <>  ''' +@Field6+ ''''
			END
		END

		IF @Field7 !=''
		BEGIN
		
			IF @Field7Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field7 LIKE ''%' + @Field7 + '%'''
			END
			IF @Field7Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field7 NOT LIKE ''%' + @Field7 + '%'''
			END
			IF @Field7Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field7 LIKE ''' + @Field7 + '%'''
			END
			IF @Field7Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field7 LIKE ''%' + @Field7 + ''''
			END          
			IF @Field7Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field7 =  ''' +@Field7+ ''''
			END
			IF @Field7Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field7 <>  ''' +@Field7+ ''''
			END
		END

		IF @Field8 !=''
		BEGIN
		
			IF @Field8Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field8 LIKE ''%' + @Field8 + '%'''
			END
			IF @Field8Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field8 NOT LIKE ''%' + @Field8 + '%'''
			END
			IF @Field8Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field8 LIKE ''' + @Field8 + '%'''
			END
			IF @Field8Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field8 LIKE ''%' + @Field8 + ''''
			END          
			IF @Field8Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field8 =  ''' +@Field8+ ''''
			END
			IF @Field8Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field8 <>  ''' +@Field8+ ''''
			END
		END

		IF @Field9 !=''
		BEGIN
		
			IF @Field9Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field9 LIKE ''%' + @Field9 + '%'''
			END
			IF @Field9Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field9 NOT LIKE ''%' + @Field9 + '%'''
			END
			IF @Field9Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field9 LIKE ''' + @Field9 + '%'''
			END
			IF @Field9Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field9 LIKE ''%' + @Field9 + ''''
			END          
			IF @Field9Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field9 =  ''' +@Field9+ ''''
			END
			IF @Field9Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field9 <>  ''' +@Field9+ ''''
			END
		END

		IF @Field10 !=''
		BEGIN
		
			IF @Field10Criteria = 'contains'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field10 LIKE ''%' + @Field10 + '%'''
			END
			IF @Field10Criteria = 'doesnotcontain'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field10 NOT LIKE ''%' + @Field10 + '%'''
			END
			IF @Field10Criteria = 'startswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field10 LIKE ''' + @Field10 + '%'''
			END
			IF @Field10Criteria = 'endswith'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field10 LIKE ''%' + @Field10 + ''''
			END          
			IF @Field10Criteria = '='
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field10 =  ''' +@Field10+ ''''
			END
			IF @Field10Criteria = '<>'
			BEGIN
				SET @whereClause = @whereClause + ' and tv.Field10 <>  ''' +@Field10+ ''''
			END
		END


		if @RoleId = 7 or @RoleId = 2
		BEGIN
			SET @whereClause = @whereClause + ' and tv.TransporterId =  (' + CONVERT(NVARCHAR(10), @companyid)+')'
		END

		Set @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array],
						[RowNumber], 
						[TotalCount],
						 [ShowCaseId]
						 ,TypeValue
      ,[Type]
      ,[CompanyId]
      ,[CompanyType]
      ,[CompanyCode]
      ,[ProductCode]
      ,[ProductName]
      ,[FromDate]
      ,[ToDate]
      
      ,[Description]
      ,[Title]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
						
					From (
						SELECT 
							ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate, CreatedDate) desc) as RowNumber, 
							COUNT([ShowCaseId]) OVER () as TotalCount,
							 [ShowCaseId]
							 ,(Select Name from Lookup where LookupId=[ShowCase].Type) as TypeValue
							 
      ,[Type]
      ,[CompanyId]
      ,[CompanyType]
      ,[CompanyCode]
      ,[ProductCode]
      ,[ProductName]
      ,[FromDate]
      ,[ToDate]
      
      ,[Description]
      ,[Title]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
						
						FROM [dbo].[ShowCase] 
						
						WHERE IsActive = 1 and 
						' + @whereClause +'
						) as tmp 
					where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '  ORDER BY '+@OrderBy+'
				FOR XML path(''ShowCaseList''),ELEMENTS,ROOT(''Json'')) AS XML)'

		PRINT @sql
		EXEC sp_executesql @sql

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
