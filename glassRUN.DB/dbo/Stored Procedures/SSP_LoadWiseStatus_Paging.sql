CREATE PROCEDURE [dbo].[SSP_LoadWiseStatus_Paging] --'<Json><ServicesAction>LoadRoleWiseStatus</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerId>0</FinancerId><IsExportToExcel>0</IsExportToExcel><RoleMasterId>1</RoleMasterId><LoginId>409</LoginId><CultureId /><StatusCode></StatusCode><StatusCodeCriteria></StatusCodeCriteria><Header></Header><HeaderCriteria></HeaderCriteria><ActivityName></ActivityName><ActivityNameCriteria></ActivityNameCriteria></Json>'
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

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END







SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1);





Print '1'


Print @whereClause




set @sql=			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select top 3 ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			RoleWiseStatusId,
			RoleName,
			RoleId,
			StatusId,
			ResourceKey,
			Class,
			IsActive
						 from (
			SELECT  distinct ROW_NUMBER() OVER (ORDER BY  RoleWiseStatusId desc) as rownumber , COUNT(*) OVER () as TotalCount,
				[RoleWiseStatusId]
				,(Select RoleName from RoleMaster where RoleMasterId=RoleWiseStatus.RoleId) as RoleName
      ,[RoleId]
      ,[StatusId]
      ,[ResourceKey]
      ,[Class]
      ,[IsActive]  from RoleWiseStatus 		
  where IsActive=1
  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''RoleWiseStatusList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql;
  
  EXEC sp_executesql @sql
END