CREATE PROCEDURE [dbo].[SSP_UserDetails_Paging] --'<Json><ServicesAction>LoadUserProfile</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><ReferenceId>0</ReferenceId><UserName></UserName><UserNameCriteria></UserNameCriteria><EmailId></EmailId><EmailIdCriteria></EmailIdCriteria><LicenseNumber></LicenseNumber><LicenseNumberCriteria></LicenseNumberCriteria><ContactNumber></ContactNumber><ContactNumberCriteria></ContactNumberCriteria><Name></Name><NameCriteria></NameCriteria><RoleName></RoleName><RoleNameCriteria></RoleNameCriteria><CompanyName></CompanyName><CompanyNameCriteria></CompanyNameCriteria><CarrierId>409</CarrierId></Json>'
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
DECLARE @roleId bigint

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)
Declare @CarrierId INT

DECLARE @userName nvarchar(150)
DECLARE @userNameCriteria nvarchar(50)
DECLARE @roleName nvarchar(150)
DECLARE @roleNameCriteria nvarchar(50)
DECLARE @Name nvarchar(150)
DECLARE @NameCriteria nvarchar(50)
DECLARE @CompanyName nvarchar(150)
DECLARE @CompanyNameCriteria nvarchar(50)
DECLARE @emailId nvarchar(150)
DECLARE @emailIdCriteria nvarchar(50)
DECLARE @licenseNumber nvarchar(150)
DECLARE @licenseNumberCriteria nvarchar(50)
DECLARE @contactNumber nvarchar(150)
DECLARE @contactNumberCriteria nvarchar(50)
declare @ReferenceId  bigint
--CompanyType
--CompanyTypeCriteria
--SKUCode
--SKUCodeCriteria
--Company
--CompanyCriteria






set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
@userName=tmp.[UserName],
	@userNameCriteria=tmp.[UserNameCriteria],
	@RoleName=tmp.[RoleName],
	@RoleNameCriteria=tmp.[RoleNameCriteria],
	@Name=tmp.[Name],
	@NameCriteria=tmp.[NameCriteria],
	@CompanyName=tmp.[CompanyName],
	@CompanyNameCriteria=tmp.[CompanyNameCriteria],
	@emailId=tmp.[EmailId],
	@emailIdCriteria=tmp.[EmailIdCriteria],
	@licenseNumber=tmp.[LicenseNumber],
	@licenseNumberCriteria=tmp.[LicenseNumberCriteria],
	@contactNumber=tmp.[ContactNumber],
	@contactNumberCriteria=tmp.[ContactNumberCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@CarrierId = tmp.[CarrierId],
	@ReferenceId =tmp.[ReferenceId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [UserName] nvarchar(150),
   [UserNameCriteria] nvarchar(50),
   [Name] nvarchar(150),
   [NameCriteria] nvarchar(50),
      [CompanyName] nvarchar(150),
   [CompanyNameCriteria] nvarchar(50),
   [RoleName] nvarchar(150),
   [RoleNameCriteria] nvarchar(50),
   [EmailId] nvarchar(150),
   [EmailIdCriteria] nvarchar(50),
   [LicenseNumber] nvarchar(150),
   [LicenseNumberCriteria] nvarchar(50),
   [ContactNumber] nvarchar(150),
   [ContactNumberCriteria] nvarchar(50),
   [CarrierId] int,
   [ReferenceId] int
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @userName !=''
BEGIN

  IF @userNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and UserName LIKE ''%' + @userName + '%'''
  END
  IF @userNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and UserName NOT LIKE ''%' + @userName + '%'''
  END
  IF @userNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and UserName LIKE ''' + @userName + '%'''
  END
  IF @userNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and UserName LIKE ''%' + @userName + ''''
  END          
  IF @userNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and UserName =  ''' +@userName+ ''''
  END
  IF @userNameCriteria =  '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and UserName <>  ''' +@userName+ ''''
  END
END




IF @roleName !=''
BEGIN

  IF @roleNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and rm.RoleName LIKE ''%' + @roleName + '%'''
  END
  IF @roleNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and rm.RoleName NOT LIKE ''%' + @roleName + '%'''
  END
  IF @roleNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and rm.RoleName LIKE ''' + @roleName + '%'''
  END
  IF @roleNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and rm.RoleName LIKE ''%' + @roleName + ''''
  END          
  IF @roleNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and rm.RoleName =  ''' +@roleName+ ''''
  END
  IF @roleNameCriteria =  '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and rm.RoleName <>  ''' +@roleName+ ''''
  END
END




IF @Name !=''
BEGIN

  IF @NameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and l.Name LIKE ''%' + @Name + '%'''
  END
  IF @NameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and l.Name NOT LIKE ''%' + @Name + '%'''
  END
  IF @NameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and l.Name LIKE ''' + @Name + '%'''
  END
  IF @NameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and l.Name LIKE ''%' + @Name + ''''
  END          
  IF @NameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and l.Name =  ''' +@Name+ ''''
  END
  IF @NameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and l.Name <>  ''' +@Name+ ''''
  END
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


IF @emailId !=''
BEGIN

  IF @emailIdCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailId LIKE ''%' + @emailId + '%'''
  END
  IF @emailIdCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailId NOT LIKE ''%' + @emailId + '%'''
  END
  IF @emailIdCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailId LIKE ''' + @emailId + '%'''
  END
  IF @emailIdCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailId LIKE ''%' + @emailId + ''''
  END          
  IF @emailIdCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and EmailId =  ''' +@emailId+ ''''
  END
  IF @emailIdCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and EmailId <>  ''' +@emailId+ ''''
  END
END


IF @licenseNumber !=''
BEGIN

  IF @licenseNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LicenseNumber LIKE ''%' + @licenseNumber + '%'''
  END
  IF @licenseNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LicenseNumber NOT LIKE ''%' + @licenseNumber + '%'''
  END
  IF @licenseNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LicenseNumber LIKE ''' + @licenseNumber + '%'''
  END
  IF @licenseNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LicenseNumber LIKE ''%' + @licenseNumber + ''''
  END          
  IF @licenseNumberCriteria = '=='
 BEGIN

 SET @whereClause = @whereClause + ' and LicenseNumber =  ''' +@licenseNumber+ ''''
  END
  IF @licenseNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and LicenseNumber <>  ''' +@licenseNumber+ ''''
  END
END


IF @contactNumber !=''
BEGIN

  IF @contactNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactNumber LIKE ''%' + @contactNumber + '%'''
  END
  IF @contactNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactNumber NOT LIKE ''%' + @contactNumber + '%'''
  END
  IF @contactNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactNumber LIKE ''' + @contactNumber + '%'''
  END
  IF @contactNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ContactNumber LIKE ''%' + @contactNumber + ''''
  END          
  IF @contactNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ContactNumber =  ''' +@contactNumber+ ''''
  END
  IF @contactNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ContactNumber <>  ''' +@contactNumber+ ''''
  END
END


IF @ReferenceId !='0'  and   @ReferenceId is not null
BEGIN

 SET @whereClause = @whereClause + ' and l.ReferenceId =  ''' +Convert(nvarchar(250),@ReferenceId)   + ''''
END



set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
LoginId,
[Name],
        	UserProfilePicture,
        	    	ReferenceId,
        	ReferenceType,
			[RoleMasterId],
			[UserName],
			RoleName,
			CompanyType,
			CompanyName,
			IsActive

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(l.UpdatedDate,l.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
l.[LoginId],
l.[Name],
        	
        	l.UserProfilePicture,
        
        	l.ReferenceId,
        	l.ReferenceType,
			l.[RoleMasterId],
			[UserName],
			rm.RoleName ,
			lu.Name  as ''CompanyType'',
			c.CompanyName,
			l.IsActive  

			
 from login l 
 left join RoleMaster rm on rm.RoleMasterId = l.RoleMasterId
 left join LookUp  lu on lu.LookUpId = l.ReferenceType
 left join Company  c on c.CompanyId  = l.ReferenceId
 where  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''ProfileList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END
