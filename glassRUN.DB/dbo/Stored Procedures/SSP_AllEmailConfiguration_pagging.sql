CREATE PROCEDURE [dbo].[SSP_AllEmailConfiguration_pagging] --'<Json><ServicesAction>LoadEmailConfiguration</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><SmtpHost></SmtpHost><SmtpHostCriteria></SmtpHostCriteria></Json>'
(@xmlDoc XML)
AS
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)

DECLARE @smtpHost nvarchar(150)
DECLARE @smtpHostCriteria nvarchar(50)
DECLARE @userName nvarchar(150)
DECLARE @userNameCriteria nvarchar(50)
DECLARE @password nvarchar(150)
DECLARE @passwordCriteria nvarchar(50)
DECLARE @fromEmail nvarchar(150)
DECLARE @fromEmailCriteria nvarchar(50)
DECLARE @portNumber nvarchar(150)
DECLARE @portNumberCriteria nvarchar(50)

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@smtpHost=tmp.[SmtpHost],
	@smtpHostCriteria=tmp.[SmtpHostCriteria],
	@userName=tmp.[UserName],
	@userNameCriteria=tmp.[UserNameCriteria],
	@password=tmp.[Password],
	@passwordCriteria=tmp.[PasswordCriteria],
	@fromEmail=tmp.[FromEmail],
	@fromEmailCriteria=tmp.[FromEmailCriteria],
	@portNumber=tmp.[PortNumber],
	@portNumberCriteria=tmp.[PortNumberCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [SmtpHost] nvarchar(150),
   [SmtpHostCriteria] nvarchar(50),
   [UserName] nvarchar(150),
   [UserNameCriteria] nvarchar(50),
   [Password] nvarchar(150),
   [PasswordCriteria] nvarchar(50),
   [FromEmail] nvarchar(150),
   [FromEmailCriteria] nvarchar(50),
   [PortNumber] nvarchar(150),
   [PortNumberCriteria] nvarchar(50),
   UserId bigint
           
   )tmp


   IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'EmailConfigurationId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @smtpHost !=''
BEGIN

  IF @smtpHostCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost NOT LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + ''''
  END          
  IF @smtpHostCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost =  ''' +@smtpHost+ ''''
  END
  IF @smtpHostCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost <>  ''' +@smtpHost+ ''''
  END
END

IF @smtpHost !=''
BEGIN

  IF @smtpHostCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost NOT LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + ''''
  END          
  IF @smtpHostCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost =  ''' +@smtpHost+ ''''
  END
  IF @smtpHostCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost <>  ''' +@smtpHost+ ''''
  END
END


IF @smtpHost !=''
BEGIN

  IF @smtpHostCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost NOT LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + ''''
  END          
  IF @smtpHostCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost =  ''' +@smtpHost+ ''''
  END
  IF @smtpHostCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost <>  ''' +@smtpHost+ ''''
  END
END

IF @smtpHost !=''
BEGIN

  IF @smtpHostCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost NOT LIKE ''%' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''' + @smtpHost + '%'''
  END
  IF @smtpHostCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SmtpHost LIKE ''%' + @smtpHost + ''''
  END          
  IF @smtpHostCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost =  ''' +@smtpHost+ ''''
  END
  IF @smtpHostCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and SmtpHost <>  ''' +@smtpHost+ ''''
  END
END

IF @userName !=''
BEGIN

  IF @userNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and UserName LIKE ''%' + @userName + '%'''
  END
  IF @userNameCriteria = 'doesnotcontain'
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
  IF @userNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and UserName =  ''' +@userName+ ''''
  END
  IF @userNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and UserName <>  ''' +@userName+ ''''
  END
END

IF @password !=''
BEGIN

  IF @passwordCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Password LIKE ''%' + @password + '%'''
  END
  IF @passwordCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Password NOT LIKE ''%' + @password + '%'''
  END
  IF @passwordCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Password LIKE ''' + @password + '%'''
  END
  IF @passwordCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Password LIKE ''%' + @password + ''''
  END          
  IF @passwordCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Password =  ''' +@password+ ''''
  END
  IF @passwordCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Password <>  ''' +@password+ ''''
  END
END

IF @fromEmail !=''
BEGIN

  IF @fromEmailCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromEmail LIKE ''%' + @fromEmail + '%'''
  END
  IF @fromEmailCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromEmail NOT LIKE ''%' + @fromEmail + '%'''
  END
  IF @fromEmailCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromEmail LIKE ''' + @fromEmail + '%'''
  END
  IF @fromEmailCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromEmail LIKE ''%' + @fromEmail + ''''
  END          
  IF @fromEmailCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and FromEmail =  ''' +@fromEmail+ ''''
  END
  IF @fromEmailCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and FromEmail <>  ''' +@fromEmail+ ''''
  END
END


IF @portNumber !=''
BEGIN

  IF @portNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PortNumber LIKE ''%' + @portNumber + '%'''
  END
  IF @portNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PortNumber NOT LIKE ''%' + @portNumber + '%'''
  END
  IF @portNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PortNumber LIKE ''' + @portNumber + '%'''
  END
  IF @portNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PortNumber LIKE ''%' + @portNumber + ''''
  END          
  IF @portNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and PortNumber =  ''' +@portNumber+ ''''
  END
  IF @portNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and PortNumber <>  ''' +@portNumber+ ''''
  END
END





set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
 [EmailConfigurationId]
      ,[SupplierId]
      ,[SmtpHost]
      ,[FromEmail]
      ,[UserName]
      ,[Password]
      ,[EmailBodyType]
      ,[PortNumber]
      ,[EnableSsl]
      ,[EmailSignature]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
 [EmailConfigurationId]
      ,[SupplierId]
      ,[SmtpHost]
      ,[FromEmail]
      ,[UserName]
      ,[Password]
      ,[EmailBodyType]
      ,[PortNumber]
      ,[EnableSsl]
      ,[EmailSignature]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
 FROM [EmailConfiguration]
	  WHERE IsActive = 1 and ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''EmailConfigurationList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
