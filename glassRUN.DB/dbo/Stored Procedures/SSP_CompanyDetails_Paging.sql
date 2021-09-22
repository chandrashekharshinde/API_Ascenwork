CREATE PROCEDURE [dbo].[SSP_CompanyDetails_Paging] 
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

DECLARE @CompanyName nvarchar(150)
DECLARE @CompanyNameCriteria nvarchar(50)
DECLARE @CompanyMnemonic nvarchar(150)
DECLARE @CompanyMnemonicCriteria nvarchar(50)
DECLARE @CompanyType nvarchar(150)
DECLARE @CompanyTypeCriteria nvarchar(50)
DECLARE @ParentCompany nvarchar(150)
DECLARE @ParentCompanyCriteria nvarchar(50)
DECLARE @AddressLine1 nvarchar(150)
DECLARE @AddressLine1Criteria nvarchar(50)
DECLARE @AddressLine2 nvarchar(150)
DECLARE @AddressLine2Criteria nvarchar(50)
DECLARE @AddressLine3 nvarchar(150)
DECLARE @AddressLine3Criteria nvarchar(50)
DECLARE @City nvarchar(150)
DECLARE @CityCriteria nvarchar(50)
DECLARE @State nvarchar(150)
DECLARE @StateCriteria nvarchar(50)
DECLARE @Country nvarchar(150)
DECLARE @CountryCriteria nvarchar(50)
DECLARE @Postcode nvarchar(150)
DECLARE @PostcodeCriteria nvarchar(50)
DECLARE @Region nvarchar(150)
DECLARE @RegionCriteria nvarchar(50)
DECLARE @RouteCode nvarchar(150)
DECLARE @RouteCodeCriteria nvarchar(50)
DECLARE @ZoneCode nvarchar(150)
DECLARE @ZoneCodeCriteria nvarchar(50)
DECLARE @CategoryCode nvarchar(150)
DECLARE @CategoryCodeCriteria nvarchar(50)
DECLARE @BranchPlant nvarchar(150)
DECLARE @BranchPlantCriteria nvarchar(50)
DECLARE @Email nvarchar(150)
DECLARE @EmailCriteria nvarchar(50)
DECLARE @SiteURL nvarchar(150)
DECLARE @SiteURLCriteria nvarchar(50)
DECLARE @ContactPersonNumber nvarchar(150)
DECLARE @ContactPersonNumberCriteria nvarchar(50)
DECLARE @ContactPersonName nvarchar(150)
DECLARE @ContactPersonNameCriteria nvarchar(50)
DECLARE @SequenceNo nvarchar(150)
DECLARE @SequenceNoCriteria nvarchar(50)
DECLARE @SubChannel nvarchar(150)
DECLARE @SubChannelCriteria nvarchar(50)
DECLARE @Field1 nvarchar(150)
DECLARE @Field1Criteria nvarchar(50)
DECLARE @Field2 nvarchar(150)
DECLARE @Field2Criteria nvarchar(50)
DECLARE @Field3 nvarchar(150)
DECLARE @Field3Criteria nvarchar(50)
DECLARE @Field4 nvarchar(150)
DECLARE @Field4Criteria nvarchar(50)
DECLARE @Field5 nvarchar(150)
DECLARE @Field5Criteria nvarchar(50)
DECLARE @Field6 nvarchar(150)
DECLARE @Field6Criteria nvarchar(50)
DECLARE @Field7 nvarchar(150)
DECLARE @Field7Criteria nvarchar(50)
DECLARE @Field8 nvarchar(150)
DECLARE @Field8Criteria nvarchar(50)
DECLARE @Field9 nvarchar(150)
DECLARE @Field9Criteria nvarchar(50)
DECLARE @Field10 nvarchar(150)
DECLARE @Field10Criteria nvarchar(50)
DECLARE @CreditLimit nvarchar(150)
DECLARE @CreditLimitCriteria nvarchar(50)
DECLARE @AvailableCreditLimit nvarchar(150)
DECLARE @AvailableCreditLimitCriteria nvarchar(50)
DECLARE @EmptiesLimit nvarchar(150)
DECLARE @EmptiesLimitCriteria nvarchar(50)
DECLARE @ActualEmpties nvarchar(150)
DECLARE @ActualEmptiesCriteria nvarchar(50)
DECLARE @PaymentTermCode nvarchar(150)
DECLARE @PaymentTermCodeCriteria nvarchar(50)
DECLARE @CategoryType nvarchar(150)
DECLARE @CategoryTypeCriteria nvarchar(50)
DECLARE @CompanyTypeName nvarchar(150)
DECLARE @CompanyTypeNameCriteria nvarchar(50)
DECLARE @SearchType nvarchar(50)








set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @CompanyName=tmp.[CompanyName],
	@CompanyNameCriteria=tmp.[CompanyNameCriteria],
	@CompanyMnemonic=tmp.[CompanyMnemonic],
	@CompanyMnemonicCriteria=tmp.[CompanyMnemonicCriteria],
	@ParentCompany=tmp.[ParentCompany],
	@ParentCompanyCriteria=tmp.[ParentCompanyCriteria],
	@AddressLine1=tmp.[AddressLine1],
	@AddressLine1Criteria=tmp.[AddressLine1Criteria],
	@AddressLine2=tmp.[AddressLine2],
	@AddressLine2Criteria=tmp.[AddressLine2Criteria],
	@AddressLine3=tmp.[AddressLine3],
	@AddressLine3Criteria=tmp.[AddressLine3Criteria],
	@City=tmp.[City],
	@CityCriteria=tmp.[CityCriteria],
	@State=tmp.[State],
	@StateCriteria=tmp.[StateCriteria],
	@Country=tmp.[Country],
	@CountryCriteria=tmp.[CountryCriteria],
	@Postcode=tmp.[Postcode],
	@PostcodeCriteria=tmp.[PostcodeCriteria],
	@Region=tmp.[Region],
	@RegionCriteria=tmp.[RegionCriteria],
	@RouteCode=tmp.[RouteCode],
	@RouteCodeCriteria=tmp.[RouteCodeCriteria],
	@ZoneCode=tmp.[ZoneCode],
	@ZoneCodeCriteria=tmp.[ZoneCodeCriteria],
	@CategoryCode=tmp.[CategoryCode],
	@CategoryCodeCriteria=tmp.[CategoryCodeCriteria],
	@BranchPlant=tmp.[BranchPlant],
	@BranchPlantCriteria=tmp.[BranchPlantCriteria],
	@Email=tmp.[Email],
	@EmailCriteria=tmp.[EmailCriteria],
	@SiteURL=tmp.[SiteURL],
	@SiteURLCriteria=tmp.[SiteURLCriteria],
	@ContactPersonNumber=tmp.[ContactPersonNumber],
	@ContactPersonNumberCriteria=tmp.[ContactPersonNumberCriteria],
	@ContactPersonName=tmp.[ContactPersonName],
	@ContactPersonNameCriteria=tmp.[ContactPersonNameCriteria],
	@SequenceNo=tmp.[SequenceNo],
	@SequenceNoCriteria=tmp.[SequenceNoCriteria],
	@SubChannel=tmp.[SubChannel],
	@SubChannelCriteria=tmp.[SubChannelCriteria],
	@Field1=tmp.[Field1],
	@Field1Criteria=tmp.[Field1Criteria],
	@Field2=tmp.[Field2],
	@Field2Criteria=tmp.[Field2Criteria],
	@Field3=tmp.[Field3],
	@Field3Criteria=tmp.[Field3Criteria],
	@Field4=tmp.[Field4],
	@Field4Criteria=tmp.[Field4Criteria],
	@Field5=tmp.[Field5],
	@Field5Criteria=tmp.[Field5Criteria],
	@Field6=tmp.[Field6],
	@Field6Criteria=tmp.[Field6Criteria],
	@Field7=tmp.[Field7],
	@Field7Criteria=tmp.[Field7Criteria],
	@Field8=tmp.[Field8],
	@Field8Criteria=tmp.[Field8Criteria],
	@Field9=tmp.[Field9],
	@Field9Criteria=tmp.[Field9Criteria],
	@Field10=tmp.[Field10],
	@Field10Criteria=tmp.[Field10Criteria],
	@CreditLimit=tmp.[CreditLimit],
	@CreditLimitCriteria=tmp.[CreditLimitCriteria],
	@AvailableCreditLimit=tmp.[AvailableCreditLimit],
	@AvailableCreditLimitCriteria=tmp.[AvailableCreditLimitCriteria],
	@EmptiesLimit=tmp.[EmptiesLimit],
	@EmptiesLimitCriteria=tmp.[EmptiesLimitCriteria],
	@ActualEmpties=tmp.[ActualEmpties],
	@ActualEmptiesCriteria=tmp.[ActualEmptiesCriteria],
	@PaymentTermCode=tmp.[PaymentTermCode],
	@PaymentTermCodeCriteria=tmp.[PaymentTermCodeCriteria],
	@CategoryType=tmp.[CategoryType],
	@CategoryTypeCriteria=tmp.[CategoryTypeCriteria],
	@CompanyTypeName=tmp.[CompanyTypeName],
	@CompanyTypeNameCriteria=tmp.[CompanyTypeNameCriteria],
	@SearchType=tmp.[SearchType],
	@PageSize = tmp.[PageSize],
	@PageIndex = tmp.[PageIndex],
	@OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
		[PageIndex] int,
		[PageSize] int,
		[OrderBy] nvarchar(2000),
		[CompanyName] nvarchar(150),
		[CompanyNameCriteria] nvarchar(50),
		[CompanyMnemonic] nvarchar(150),
		[CompanyMnemonicCriteria] nvarchar(50),
		[ParentCompany] nvarchar(150),
		[ParentCompanyCriteria] nvarchar(50),
		[AddressLine1] nvarchar(150),
		[AddressLine1Criteria] nvarchar(150),
		[AddressLine2] nvarchar(150),
		[AddressLine2Criteria] nvarchar(150),
		[AddressLine3] nvarchar(150),
		[AddressLine3Criteria] nvarchar(150),
		[City] nvarchar(150),
		[CityCriteria] nvarchar(150),
		[State] nvarchar(150),
		[StateCriteria] nvarchar(150),
		[Country] nvarchar(150),
		[CountryCriteria] nvarchar(150),
		[Postcode] nvarchar(150),
		[PostcodeCriteria] nvarchar(150),
		[Region] nvarchar(150),
		[RegionCriteria] nvarchar(150),
		[RouteCode] nvarchar(150),
		[RouteCodeCriteria] nvarchar(150),
		[ZoneCode] nvarchar(150),
		[ZoneCodeCriteria] nvarchar(150),
		[CategoryCode] nvarchar(150),
		[CategoryCodeCriteria] nvarchar(150),
		[BranchPlant] nvarchar(150),
		[BranchPlantCriteria] nvarchar(150),
		[Email] nvarchar(150),
		[EmailCriteria] nvarchar(150),
		[SiteURL] nvarchar(150),
		[SiteURLCriteria] nvarchar(150),
		[ContactPersonNumber] nvarchar(150),
		[ContactPersonNumberCriteria] nvarchar(150),
		[ContactPersonName] nvarchar(150),
		[ContactPersonNameCriteria] nvarchar(150),
		[SequenceNo] nvarchar(150),
		[SequenceNoCriteria] nvarchar(150),
		[SubChannel] nvarchar(150),
		[SubChannelCriteria] nvarchar(150),
		[Field1] nvarchar(150),
		[Field1Criteria] nvarchar(150),
		[Field2] nvarchar(150),
		[Field2Criteria] nvarchar(150),
		[Field3] nvarchar(150),
		[Field3Criteria] nvarchar(150),
		[Field4] nvarchar(150),
		[Field4Criteria] nvarchar(150),
		[Field5] nvarchar(150),
		[Field5Criteria] nvarchar(150),
		[Field6] nvarchar(150),
		[Field6Criteria] nvarchar(150),
		[Field7] nvarchar(150),
		[Field7Criteria] nvarchar(150),
		[Field8] nvarchar(150),
		[Field8Criteria] nvarchar(150),
		[Field9] nvarchar(150),
		[Field9Criteria] nvarchar(150),
		[Field10] nvarchar(150),
		[Field10Criteria] nvarchar(150),
		[CreditLimit] nvarchar(150),
		[CreditLimitCriteria] nvarchar(150),
		[AvailableCreditLimit] nvarchar(150),
		[AvailableCreditLimitCriteria] nvarchar(150),
		[EmptiesLimit] nvarchar(150),
		[EmptiesLimitCriteria] nvarchar(150),
		[ActualEmpties] nvarchar(150),
		[ActualEmptiesCriteria] nvarchar(150),
		[PaymentTermCode] nvarchar(150),
		[PaymentTermCodeCriteria] nvarchar(150),
		[CategoryType] nvarchar(150),
		[CategoryTypeCriteria] nvarchar(150),
		[CompanyTypeName]nvarchar(150),
	    [CompanyTypeNameCriteria]nvarchar(150),
		[SearchType]nvarchar(150)
 
   
           
   )tmp

   
IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ModifiedDate' END

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1);


IF @SearchType='0'
	 BEGIN
		 SET @whereClause = @whereClause + 'and companytype not in (28,29)'
	 END
	 ELSE
	 BEGIN
	  SET @whereClause = @whereClause + 'and companytype= '+@SearchType
	 END

IF @CompanyName !=''
BEGIN

  IF @CompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName NOT LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @CompanyName + ''''
  END          
  IF @CompanyNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and c.CompanyName =  ''' +@CompanyName+ ''''
  END
  IF @CompanyNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and c.CompanyName <>  ''' +@CompanyName+ ''''
  END
END

IF @CompanyMnemonic !=''
BEGIN

  IF @CompanyMnemonicCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyMnemonic LIKE ''%' + @CompanyMnemonic + '%'''
  END
  IF @CompanyMnemonicCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyMnemonic NOT LIKE ''%' + @CompanyMnemonic + '%'''
  END
  IF @CompanyMnemonicCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyMnemonic LIKE ''' + @CompanyMnemonic + '%'''
  END
  IF @CompanyMnemonicCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyMnemonic LIKE ''%' + @CompanyMnemonic + ''''
  END          
  IF @CompanyMnemonicCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and c.CompanyMnemonic =  ''' +@CompanyMnemonic+ ''''
  END
  IF @CompanyMnemonicCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and c.CompanyMnemonic <>  ''' +@CompanyMnemonic+ ''''
  END
END

IF @CompanyTypeName !=''
BEGIN

  IF @CompanyTypeNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.CompanyType) LIKE ''%' + @CompanyTypeName + '%'''
  END
  IF @CompanyTypeNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.CompanyType) NOT LIKE ''%' + @CompanyTypeName + '%'''
  END
  IF @CompanyTypeNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.CompanyType) LIKE ''' + @CompanyTypeName + '%'''
  END
  IF @CompanyTypeNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.CompanyType) LIKE ''%' + @CompanyTypeName + ''''
  END          
  IF @CompanyTypeNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.CompanyType) =  ''' +@CompanyTypeName+ ''''
  END
  IF @CompanyTypeNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.CompanyType) <>  ''' +@CompanyTypeName+ ''''
  END
END

IF @ParentCompany !=''
BEGIN

  IF @ParentCompanyCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId) LIKE ''%' + @ParentCompany + '%'''
  END
  IF @ParentCompanyCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId) NOT LIKE ''%' + @ParentCompany + '%'''
  END
  IF @ParentCompanyCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId) LIKE ''' + @ParentCompany + '%'''
  END
  IF @ParentCompanyCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId) LIKE ''%' + @ParentCompany + ''''
  END          
  IF @ParentCompanyCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId) =  ''' +@ParentCompany+ ''''
  END
  IF @ParentCompanyCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId) <>  ''' +@ParentCompany+ ''''
  END
END

IF @AddressLine1 !=''
BEGIN

  IF @AddressLine1Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 LIKE ''%' + @AddressLine1 + '%'''
  END
  IF @AddressLine1Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 NOT LIKE ''%' + @AddressLine1 + '%'''
  END
  IF @AddressLine1Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 LIKE ''' + @AddressLine1 + '%'''
  END
  IF @AddressLine1Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine1 LIKE ''%' + @AddressLine1 + ''''
  END          
  IF @AddressLine1Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine1 =  ''' +@AddressLine1+ ''''
  END
  IF @AddressLine1Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine1 <>  ''' +@AddressLine1+ ''''
  END
END

IF @AddressLine2 !=''
BEGIN

  IF @AddressLine2Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 LIKE ''%' + @AddressLine2 + '%'''
  END
  IF @AddressLine2Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 NOT LIKE ''%' + @AddressLine2 + '%'''
  END
  IF @AddressLine2Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 LIKE ''' + @AddressLine2 + '%'''
  END
  IF @AddressLine2Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine2 LIKE ''%' + @AddressLine2 + ''''
  END          
  IF @AddressLine2Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine2 =  ''' +@AddressLine2+ ''''
  END
  IF @AddressLine2Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine2 <>  ''' +@AddressLine2+ ''''
  END
END

IF @AddressLine3 !=''
BEGIN

  IF @AddressLine3Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 LIKE ''%' + @AddressLine3 + '%'''
  END
  IF @AddressLine3Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 NOT LIKE ''%' + @AddressLine3 + '%'''
  END
  IF @AddressLine3Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 LIKE ''' + @AddressLine3 + '%'''
  END
  IF @AddressLine3Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AddressLine3 LIKE ''%' + @AddressLine3 + ''''
  END          
  IF @AddressLine3Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine3 =  ''' +@AddressLine3+ ''''
  END
  IF @AddressLine3Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and AddressLine3 <>  ''' +@AddressLine3+ ''''
  END
END

IF @City !=''
BEGIN

  IF @CityCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.City LIKE ''%' + @City + '%'''
  END
  IF @CityCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.City NOT LIKE ''%' + @City + '%'''
  END
  IF @CityCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.City LIKE ''' + @City + '%'''
  END
  IF @CityCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.City LIKE ''%' + @City + ''''
  END          
  IF @CityCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and c.City =  ''' +@City+ ''''
  END
  IF @CityCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and c.City <>  ''' +@City+ ''''
  END
END

IF @State !=''
BEGIN

  IF @StateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.State LIKE ''%' + @State + '%'''
  END
  IF @StateCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.State NOT LIKE ''%' + @State + '%'''
  END
  IF @StateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.State LIKE ''' + @State + '%'''
  END
  IF @StateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.State LIKE ''%' + @State + ''''
  END          
  IF @StateCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and c.State =  ''' +@State+ ''''
  END
  IF @StateCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and c.State <>  ''' +@State+ ''''
  END
END

IF @Country !=''
BEGIN

  IF @CountryCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Country LIKE ''%' + @Country + '%'''
  END
  IF @CountryCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Country NOT LIKE ''%' + @Country + '%'''
  END
  IF @CountryCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Country LIKE ''' + @Country + '%'''
  END
  IF @CountryCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Country LIKE ''%' + @Country + ''''
  END          
  IF @CountryCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Country =  ''' +@Country+ ''''
  END
  IF @CountryCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Country <>  ''' +@Country+ ''''
  END
END

IF @Postcode !=''
BEGIN

  IF @PostcodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Postcode LIKE ''%' + @Postcode + '%'''
  END
  IF @PostcodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Postcode NOT LIKE ''%' + @Postcode + '%'''
  END
  IF @PostcodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Postcode LIKE ''' + @Postcode + '%'''
  END
  IF @PostcodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Postcode LIKE ''%' + @Postcode + ''''
  END          
  IF @PostcodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Postcode =  ''' +@Postcode+ ''''
  END
  IF @PostcodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Postcode <>  ''' +@Postcode+ ''''
  END
END

IF  @Region !=''
BEGIN

  IF  @RegionCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.Region) LIKE ''%' +  @Region + '%'''
  END
  IF  @RegionCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.Region) NOT LIKE ''%' +  @Region + '%'''
  END
  IF  @RegionCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.Region) LIKE ''' +  @Region + '%'''
  END
  IF  @RegionCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.Region) LIKE ''%' +  @Region + ''''
  END          
  IF  @RegionCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.Region) =  ''' + @Region+ ''''
  END
  IF  @RegionCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Code from [lookup] where LookUpId=c.Region) <>  ''' + @Region+ ''''
  END
END

IF  @RouteCode !=''
BEGIN

  IF  @RouteCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RouteCode LIKE ''%' +  @RouteCode + '%'''
  END
  IF  @RouteCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RouteCode NOT LIKE ''%' +  @RouteCode + '%'''
  END
  IF  @RouteCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RouteCode LIKE ''' +  @RouteCode + '%'''
  END
  IF  @RouteCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RouteCode LIKE ''%' +  @RouteCode + ''''
  END          
  IF  @RouteCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and RouteCode =  ''' + @RouteCode+ ''''
  END
  IF  @RouteCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and RouteCode <>  ''' + @RouteCode+ ''''
  END
END

IF   @ZoneCode !=''
BEGIN

  IF   @ZoneCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ZoneCode LIKE ''%' +   @ZoneCode + '%'''
  END
  IF   @ZoneCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ZoneCode NOT LIKE ''%' +   @ZoneCode + '%'''
  END
  IF   @ZoneCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ZoneCode LIKE ''' +   @ZoneCode + '%'''
  END
  IF   @ZoneCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ZoneCode LIKE ''%' +   @ZoneCode + ''''
  END          
  IF   @ZoneCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ZoneCode =  ''' +  @ZoneCode+ ''''
  END
  IF   @ZoneCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ZoneCode <>  ''' +  @ZoneCode+ ''''
  END
END

IF  @BranchPlant !=''
BEGIN

  IF  @BranchPlantCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''%' +  @BranchPlant + '%'''
  END
  IF  @BranchPlantCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant NOT LIKE ''%' +  @BranchPlant + '%'''
  END
  IF  @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''' +  @BranchPlant + '%'''
  END
  IF  @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''%' +  @BranchPlant + ''''
  END          
  IF  @BranchPlantCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlant =  ''' + @BranchPlant+ ''''
  END
  IF  @BranchPlantCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlant <>  ''' + @BranchPlant+ ''''
  END
END

IF  @CategoryCode !=''
BEGIN

  IF  @CategoryCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryCode LIKE ''%' +  @CategoryCode + '%'''
  END
  IF  @CategoryCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryCode NOT LIKE ''%' +  @CategoryCode + '%'''
  END
  IF  @CategoryCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryCode LIKE ''' +  @CategoryCode + '%'''
  END
  IF  @CategoryCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryCode LIKE ''%' +  @CategoryCode + ''''
  END          
  IF  @CategoryCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and CategoryCode =  ''' + @CategoryCode+ ''''
  END
  IF  @CategoryCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and CategoryCode <>  ''' + @CategoryCode+ ''''
  END
END

IF   @Email !=''
BEGIN

  IF   @EmailCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Email LIKE ''%' +   @Email + '%'''
  END
  IF   @EmailCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Email NOT LIKE ''%' +   @Email + '%'''
  END
  IF   @EmailCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Email LIKE ''' +   @Email + '%'''
  END
  IF   @EmailCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Email LIKE ''%' +   @Email + ''''
  END          
  IF   @EmailCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Email =  ''' +  @Email+ ''''
  END
  IF   @EmailCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Email <>  ''' +  @Email+ ''''
  END
END

IF   @SiteURL !=''
BEGIN

  IF   @SiteURLCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SiteURL LIKE ''%' +   @SiteURL + '%'''
  END
  IF   @SiteURLCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SiteURL NOT LIKE ''%' +   @SiteURL + '%'''
  END
  IF   @SiteURLCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SiteURL LIKE ''' +   @SiteURL + '%'''
  END
  IF   @SiteURLCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SiteURL LIKE ''%' +   @SiteURL + ''''
  END          
  IF   @SiteURLCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SiteURL =  ''' +  @SiteURL+ ''''
  END
  IF   @SiteURLCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SiteURL <>  ''' +  @SiteURL+ ''''
  END
END

IF   @ContactPersonNumber !=''
BEGIN

  IF   @ContactPersonNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonNumber LIKE ''%' +   @ContactPersonNumber + '%'''
  END
  IF   @ContactPersonNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonNumber NOT LIKE ''%' +   @ContactPersonNumber + '%'''
  END
  IF   @ContactPersonNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonNumber LIKE ''' +   @ContactPersonNumber + '%'''
  END
  IF   @ContactPersonNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonNumber LIKE ''%' +   @ContactPersonNumber + ''''
  END          
  IF   @ContactPersonNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ContactPersonNumber =  ''' +  @ContactPersonNumber+ ''''
  END
  IF   @ContactPersonNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ContactPersonNumber <>  ''' +  @ContactPersonNumber+ ''''
  END
END

IF   @ContactPersonName !=''
BEGIN

  IF   @ContactPersonNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonName LIKE ''%' +   @ContactPersonName + '%'''
  END
  IF   @ContactPersonNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonName NOT LIKE ''%' +   @ContactPersonName + '%'''
  END
  IF   @ContactPersonNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonName LIKE ''' +   @ContactPersonName + '%'''
  END
  IF   @ContactPersonNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactPersonName LIKE ''%' +   @ContactPersonName + ''''
  END          
  IF   @ContactPersonNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ContactPersonName =  ''' +  @ContactPersonName+ ''''
  END
  IF   @ContactPersonNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ContactPersonName <>  ''' +  @ContactPersonName+ ''''
  END
END

IF   @SequenceNo !=''
BEGIN

  IF   @SequenceNoCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SequenceNo LIKE ''%' +   @SequenceNo + '%'''
  END
  IF   @SequenceNoCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SequenceNo NOT LIKE ''%' +   @SequenceNo + '%'''
  END
  IF   @SequenceNoCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SequenceNo LIKE ''' +   @SequenceNo + '%'''
  END
  IF   @SequenceNoCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SequenceNo LIKE ''%' +   @SequenceNo + ''''
  END          
  IF   @SequenceNoCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SequenceNo =  ''' +  @SequenceNo+ ''''
  END
  IF   @SequenceNoCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SequenceNo <>  ''' +  @SequenceNo+ ''''
  END
END

IF   @SubChannel !=''
BEGIN

  IF   @SubChannelCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SubChannel LIKE ''%' +   @SubChannel + '%'''
  END
  IF   @SubChannelCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SubChannel NOT LIKE ''%' +   @SubChannel + '%'''
  END
  IF   @SubChannelCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SubChannel LIKE ''' +   @SubChannel + '%'''
  END
  IF   @SubChannelCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SubChannel LIKE ''%' +   @SubChannel + ''''
  END          
  IF   @SubChannelCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SubChannel =  ''' +  @SubChannel+ ''''
  END
  IF   @SubChannelCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SubChannel <>  ''' +  @SubChannel+ ''''
  END
END

IF   @Field1 !=''
BEGIN

  IF   @Field1Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 LIKE ''%' +   @Field1 + '%'''
  END
  IF   @Field1Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 NOT LIKE ''%' +   @Field1 + '%'''
  END
  IF   @Field1Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 LIKE ''' +   @Field1 + '%'''
  END
  IF   @Field1Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 LIKE ''%' +   @Field1 + ''''
  END          
  IF   @Field1Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field1 =  ''' +  @Field1+ ''''
  END
  IF   @Field1Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field1 <>  ''' +  @Field1+ ''''
  END
END

IF   @Field2 !=''
BEGIN

  IF   @Field2Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field2 LIKE ''%' +   @Field2 + '%'''
  END
  IF   @Field2Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field2 NOT LIKE ''%' +   @Field2 + '%'''
  END
  IF   @Field2Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field2 LIKE ''' +   @Field2 + '%'''
  END
  IF   @Field2Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field2 LIKE ''%' +   @Field2 + ''''
  END          
  IF   @Field2Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field2 =  ''' +  @Field2+ ''''
  END
  IF   @Field2Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field2 <>  ''' +  @Field2+ ''''
  END
END

IF   @Field3 !=''
BEGIN

  IF   @Field3Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field3 LIKE ''%' +   @Field3 + '%'''
  END
  IF   @Field3Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field3 NOT LIKE ''%' +   @Field3 + '%'''
  END
  IF   @Field3Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field3 LIKE ''' +   @Field3 + '%'''
  END
  IF   @Field3Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field3 LIKE ''%' +   @Field3 + ''''
  END          
  IF   @Field3Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field3 =  ''' +  @Field3+ ''''
  END
  IF   @Field3Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field3 <>  ''' +  @Field3+ ''''
  END
END

IF   @Field4 !=''
BEGIN

  IF   @Field4Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field4 LIKE ''%' +   @Field4 + '%'''
  END
  IF   @Field4Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field4 NOT LIKE ''%' +   @Field4 + '%'''
  END
  IF   @Field4Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field4 LIKE ''' +   @Field4 + '%'''
  END
  IF   @Field4Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field4 LIKE ''%' +   @Field4 + ''''
  END          
  IF   @Field4Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field4 =  ''' +  @Field4+ ''''
  END
  IF   @Field4Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field4 <>  ''' +  @Field4+ ''''
  END
END

IF   @Field5 !=''
BEGIN

  IF   @Field5Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field5 LIKE ''%' +   @Field5 + '%'''
  END
  IF   @Field5Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field5 NOT LIKE ''%' +   @Field5 + '%'''
  END
  IF   @Field5Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field5 LIKE ''' +   @Field5 + '%'''
  END
  IF   @Field5Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field5 LIKE ''%' +   @Field5 + ''''
  END          
  IF   @Field5Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field5 =  ''' +  @Field5+ ''''
  END
  IF   @Field5Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field5 <>  ''' +  @Field5+ ''''
  END
END

IF   @Field6 !=''
BEGIN

  IF   @Field6Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field6 LIKE ''%' +   @Field6 + '%'''
  END
  IF   @Field6Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field6 NOT LIKE ''%' +   @Field6 + '%'''
  END
  IF   @Field6Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field6 LIKE ''' +   @Field6 + '%'''
  END
  IF   @Field6Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field6 LIKE ''%' +   @Field6 + ''''
  END          
  IF   @Field6Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field6 =  ''' +  @Field6+ ''''
  END
  IF   @Field6Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field6 <>  ''' +  @Field6+ ''''
  END
END

IF   @Field7 !=''
BEGIN

  IF   @Field7Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field7 LIKE ''%' +   @Field7 + '%'''
  END
  IF   @Field7Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field7 NOT LIKE ''%' +   @Field7 + '%'''
  END
  IF   @Field7Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field7 LIKE ''' +   @Field7 + '%'''
  END
  IF   @Field7Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field7 LIKE ''%' +   @Field7 + ''''
  END          
  IF   @Field7Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field7 =  ''' +  @Field7+ ''''
  END
  IF   @Field7Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field7 <>  ''' +  @Field7+ ''''
  END
END

IF   @Field8 !=''
BEGIN

  IF   @Field8Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field8 LIKE ''%' +   @Field8 + '%'''
  END
  IF   @Field8Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field8 NOT LIKE ''%' +   @Field8 + '%'''
  END
  IF   @Field8Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field8 LIKE ''' +   @Field8 + '%'''
  END
  IF   @Field8Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field8 LIKE ''%' +   @Field8 + ''''
  END          
  IF   @Field8Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field8 =  ''' +  @Field8+ ''''
  END
  IF   @Field8Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field8 <>  ''' +  @Field8+ ''''
  END
END

IF   @Field9 !=''
BEGIN

  IF   @Field9Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field9 LIKE ''%' +   @Field9 + '%'''
  END
  IF   @Field9Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field9 NOT LIKE ''%' +   @Field9 + '%'''
  END
  IF   @Field9Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field9 LIKE ''' +   @Field9 + '%'''
  END
  IF   @Field9Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field9 LIKE ''%' +   @Field9 + ''''
  END          
  IF   @Field9Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field9 =  ''' +  @Field9+ ''''
  END
  IF   @Field9Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field9 <>  ''' +  @Field9+ ''''
  END
END

IF   @Field10 !=''
BEGIN

  IF   @Field10Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field10 LIKE ''%' +   @Field10 + '%'''
  END
  IF   @Field10Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field10 NOT LIKE ''%' +   @Field10 + '%'''
  END
  IF   @Field10Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field10 LIKE ''' +   @Field10 + '%'''
  END
  IF   @Field10Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field10 LIKE ''%' +   @Field10 + ''''
  END          
  IF   @Field10Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field10 =  ''' +  @Field10+ ''''
  END
  IF   @Field10Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field10 <>  ''' +  @Field10+ ''''
  END
END

IF   @CreditLimit !=''
BEGIN

  IF   @CreditLimitCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CreditLimit LIKE ''%' +   @CreditLimit + '%'''
  END
  IF   @CreditLimitCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CreditLimit NOT LIKE ''%' +   @CreditLimit + '%'''
  END
  IF   @CreditLimitCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CreditLimit LIKE ''' +   @CreditLimit + '%'''
  END
  IF   @CreditLimitCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CreditLimit LIKE ''%' +   @CreditLimit + ''''
  END          
  IF   @CreditLimitCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and CreditLimit =  ''' +  @CreditLimit+ ''''
  END
  IF   @CreditLimitCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and CreditLimit <>  ''' +  @CreditLimit+ ''''
  END
END

IF   @AvailableCreditLimit !=''
BEGIN

  IF   @AvailableCreditLimitCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AvailableCreditLimit LIKE ''%' +   @AvailableCreditLimit + '%'''
  END
  IF   @AvailableCreditLimitCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AvailableCreditLimit NOT LIKE ''%' +   @AvailableCreditLimit + '%'''
  END
  IF   @AvailableCreditLimitCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AvailableCreditLimit LIKE ''' +   @AvailableCreditLimit + '%'''
  END
  IF   @AvailableCreditLimitCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AvailableCreditLimit LIKE ''%' +   @AvailableCreditLimit + ''''
  END          
  IF   @AvailableCreditLimitCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and AvailableCreditLimit =  ''' +  @AvailableCreditLimit+ ''''
  END
  IF   @AvailableCreditLimitCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and AvailableCreditLimit <>  ''' +  @AvailableCreditLimit+ ''''
  END
END

IF   @EmptiesLimit !=''
BEGIN

  IF   @EmptiesLimitCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmptiesLimit LIKE ''%' +   @EmptiesLimit + '%'''
  END
  IF   @EmptiesLimitCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmptiesLimit NOT LIKE ''%' +   @EmptiesLimit + '%'''
  END
  IF   @EmptiesLimitCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmptiesLimit LIKE ''' +   @EmptiesLimit + '%'''
  END
  IF   @EmptiesLimitCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmptiesLimit LIKE ''%' +   @EmptiesLimit + ''''
  END          
  IF   @EmptiesLimitCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and EmptiesLimit =  ''' +  @EmptiesLimit+ ''''
  END
  IF   @EmptiesLimitCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and EmptiesLimit <>  ''' +  @EmptiesLimit+ ''''
  END
END

IF   @ActualEmpties !=''
BEGIN

  IF   @ActualEmptiesCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ActualEmpties LIKE ''%' +   @ActualEmpties + '%'''
  END
  IF   @ActualEmptiesCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ActualEmpties NOT LIKE ''%' +   @ActualEmpties + '%'''
  END
  IF   @ActualEmptiesCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ActualEmpties LIKE ''' +   @ActualEmpties + '%'''
  END
  IF   @ActualEmptiesCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ActualEmpties LIKE ''%' +   @ActualEmpties + ''''
  END          
  IF   @ActualEmptiesCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ActualEmpties =  ''' +  @ActualEmpties+ ''''
  END
  IF   @ActualEmptiesCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ActualEmpties <>  ''' +  @ActualEmpties+ ''''
  END
END

IF   @PaymentTermCode !=''
BEGIN

  IF   @PaymentTermCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PaymentTermCode LIKE ''%' +   @PaymentTermCode + '%'''
  END
  IF   @PaymentTermCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PaymentTermCode NOT LIKE ''%' +   @PaymentTermCode + '%'''
  END
  IF   @PaymentTermCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PaymentTermCode LIKE ''' +   @PaymentTermCode + '%'''
  END
  IF   @PaymentTermCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PaymentTermCode LIKE ''%' +   @PaymentTermCode + ''''
  END          
  IF   @PaymentTermCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and PaymentTermCode =  ''' +  @PaymentTermCode+ ''''
  END
  IF   @PaymentTermCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and PaymentTermCode <>  ''' +  @PaymentTermCode+ ''''
  END
END

IF   @CategoryType !=''
BEGIN

  IF   @CategoryTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryType LIKE ''%' +   @CategoryType + '%'''
  END
  IF   @CategoryTypeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryType NOT LIKE ''%' +   @CategoryType + '%'''
  END
  IF   @CategoryTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryType LIKE ''' +   @CategoryType + '%'''
  END
  IF   @CategoryTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CategoryType LIKE ''%' +   @CategoryType + ''''
  END          
  IF   @CategoryTypeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and CategoryType =  ''' +  @CategoryType+ ''''
  END
  IF   @CategoryTypeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and CategoryType <>  ''' +  @CategoryType+ ''''
  END
END

set @sql=			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			CompanyId,
			CompanyId as CompanyIdForEdit,
			CompanyId as CompanyIdForDelete,
			CompanyName,
			CompanyMnemonic,
			CompanyType,
			CompanyTypeName,
			ParentCompany,
			ParentCompanyName,
			AddressLine1,
			AddressLine2,
			AddressLine3,
			City,
			CityName,
			State,	
			StateName,
			CountryId,
			Country,
			Postcode,
			Region,
			RegionName,
			RouteCode,
			ZoneCode,	
			CategoryCode,
			BranchPlant,
			Email,
			TaxId,	
			SoldTo,	
			ShipTo,
			BillTo,
			SiteURL,	
			ContactPersonNumber,
			ContactPersonName,
			logo,
			header,
			footer,
			CreatedBy,
			CreatedDate,
			ModifiedBy,
			ModifiedDate,
			IsActive,
			SequenceNo,
			SubChannel,
			Field1,
			Field2,
			Field3,
			Field4,
			Field5,
			Field6,
			Field7,
			Field8,
			Field9,
			Field10,	
			CreditLimit,
			AvailableCreditLimit,
			EmptiesLimit,
			ActualEmpties,
			PaymentTermCode,
			CategoryType
						 from (
			SELECT  distinct ROW_NUMBER() OVER (ORDER BY   ISNULL(c.ModifiedDate,c.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
				c.CompanyId,
				c.CompanyName,
				c.CompanyMnemonic,
				(select top 1 Code from [lookup] where LookUpId=c.CompanyType) as CompanyTypeName,
				c.CompanyType,
				c.ParentCompany,
				(select top 1 comp.CompanyName  from [Company]comp where c.ParentCompany=comp.CompanyId)as ParentCompanyName,
				c.AddressLine1,
				c.AddressLine2,
				c.AddressLine3,
				c.City,
				c.City as CityName,
				--(select top 1 CityName from City where CityId =c.City)as CityName,
				c.State,
				c.State as StateName,
				--(select top 1 StateName from [State] where StateId=c.State)as StateName,	
				c.CountryId,
				c.Country,
				c.Postcode,
				c.Region,
				(select top 1 Code from [lookup] where LookUpId=c.Region)as RegionName,
				c.RouteCode,
				c.CategoryCode,
				c.BranchPlant,
				c.Email,
				c.TaxId,	
				c.SoldTo,	
				c.ShipTo,
				c.BillTo,
				c.SiteURL,'
set @sql1 =		' '''' as logo,
				c.header,
				c.footer,
				c.CreatedBy,
				c.CreatedDate,
				c.ModifiedBy,
				c.ModifiedDate,
				c.IsActive,
				c.SequenceNo,
				c.SubChannel,
				c.Field1,
				c.Field2,
				c.Field3,
				c.Field4,
				c.Field5,
				c.Field6,
				c.Field7,
				c.Field8,
				c.Field9,
				c.Field10,	
				c.CreditLimit,
				c.AvailableCreditLimit,
				c.EmptiesLimit,
				c.ActualEmpties,
								STUFF( (SELECT '', ''+  ZoneName  FROM ZoneCode op  where op.CompanyId = c.CompanyId and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') ZoneCode,
				STUFF( (SELECT '', ''+  LocationName  FROM CompanyBranchPlant op  where op.CompanyId = c.CompanyId and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') LocationName,
				STUFF( (SELECT '', ''+  ProductTypeName  FROM CompanyProductType op  where op.CompanyId = c.CompanyId and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') ProductTypeName,
				STUFF( (SELECT '', ''+  BankName  FROM TransporterAccountDetail op  where op.ObjectId = c.CompanyId and op.isactive=1 and ObjectType=''Company''  FOR XML PATH (''''))  , 1, 1, '''') BankName,
				STUFF( (SELECT '', ''+  AccountName  FROM TransporterAccountDetail op  where op.ObjectId = c.CompanyId and op.isactive=1 and ObjectType=''Company''  FOR XML PATH (''''))  , 1, 1, '''') AccountName,
				STUFF( (SELECT '', ''+  AccountNumber  FROM TransporterAccountDetail op  where op.ObjectId = c.CompanyId and op.isactive=1 and ObjectType=''Company'' FOR XML PATH (''''))  , 1, 1, '''') AccountNumber,
				STUFF( (SELECT '', ''+  AccountType  FROM TransporterAccountDetail op  where op.ObjectId = c.CompanyId and op.isactive=1 and ObjectType=''Company'' FOR XML PATH (''''))  , 1, 1, '''') AccountType,
				STUFF( (SELECT '', ''+  ContactPerson  FROM ContactInformation op  where op.ObjectId = c.CompanyId and ObjectType=''Company'' and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') ContactPersonName,
				STUFF( (SELECT '', ''+  Contacts  FROM ContactInformation op  where op.ObjectId = c.CompanyId and ObjectType=''Company'' and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') ContactPersonNumber,
				STUFF( (SELECT '', ''+  ContactType  FROM ContactInformation op  where op.ObjectId = c.CompanyId and ObjectType=''Company'' and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') ContactType,
				STUFF( (SELECT '', ''+  PaymentTermName  FROM PaymentTerm op  where op.PaymentTermId = c.PaymentTermCode and op.isactive=1  FOR XML PATH (''''))  , 1, 1, '''') PaymentTermCode,
				CategoryType from Company c			
  where c.IsActive=1
  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'
  FOR XML path(''AllCompanyDetailsList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql;
  PRINT @sql1;
  execute (@sql + @sql1)
END