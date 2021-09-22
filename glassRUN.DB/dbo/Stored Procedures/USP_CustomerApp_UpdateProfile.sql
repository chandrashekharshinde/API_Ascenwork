


CREATE PROCEDURE [dbo].[USP_CustomerApp_UpdateProfile] --'<Json><ServicesAction>UpdateProfileDetailsForSubDApp</ServicesAction><UserDetails><Name>Red Apron - Sub D</Name><Code>98888771</Code><EmailId>dyanl@disrptiv.com</EmailId><AddressLine1>35 Hai Bà Trưng</AddressLine1><AddressLine2>Bến Nghé, Quận 1</AddressLine2><AddressLine3 /><Pincode>234</Pincode><State>Hanoi</State><City>2763</City><createdby>10630</createdby></UserDetails></Json>'
@xmlDoc XML 
AS 
BEGIN 
SET arithabort ON 

DECLARE @ErrMsg NVARCHAR(2048) 
DECLARE @ErrSeverity INT; 
DECLARE @intPointer INT; 
DECLARE @CompanyId BIGINT 
DECLARE @EmailId NVARCHAR(500) 
DECLARE @ContactName NVARCHAR(500) 

DECLARE @PhoneNo BIGINT 

SET @ErrSeverity = 15; 

BEGIN try 
EXEC Sp_xml_preparedocument 
@intpointer output, 
@xmlDoc 
select * into #UserDetails
FROM OPENXML(@intpointer,'Json/UserDetails',2)
WITH
(
[Name] nvarchar(2000),
[Code] nvarchar(200),
[Phone] nvarchar(250),
[ContactName] nvarchar(250),
[EmailId] nvarchar(250),
[createdby] bigint,
[ObjectType] nvarchar(250),
[AddressLine1] nvarchar(MAX),
[AddressLine2] nvarchar(MAX),
[AddressLine3] nvarchar(MAX)
)tmp	

select top 1 @CompanyId= CompanyId from company ,#UserDetails where company.CompanyMnemonic= #UserDetails.[Code]


UPDATE [dbo].[company] 
SET @ContactName= tmp.[ContactName],
@EmailId=tmp.[EmailId],
@PhoneNo=tmp.[Phone],
--[companyname] = tmp.[Name], 
--[companymnemonic] = tmp.[Code], 
[AddressLine1] = tmp.[AddressLine1],
[AddressLine2] = tmp.[AddressLine2],
[AddressLine3] = tmp.[AddressLine3],
[modifiedby] = tmp.[createdby], 
[State]= tmp.[State],
[City]=tmp.[City],
[Country]=tmp.[Country],
[postCode]=tmp.[Pincode],
[modifieddate] = Getdate()

FROM OPENXML(@intpointer, 'Json/UserDetails', 2) 
WITH ( [CompanyId] BIGINT, 
[Name] nvarchar(2000),
[Code] nvarchar(200),
[Phone] nvarchar(250),
[ContactName] nvarchar(250),
[EmailId] nvarchar(250),
[createdby] bigint,
[AddressLine1] nvarchar(MAX),
[AddressLine2] nvarchar(MAX),
[AddressLine3] nvarchar(MAX),
[Country] nvarchar(500),
[State] nvarchar(500),
[City] nvarchar(500),
[Pincode]nvarchar(500)
)tmp WHERE company.[CompanyMnemonic]=tmp.[Code]
print @PhoneNo
print @ContactName
print @EmailId
print @CompanyId

if(@PhoneNo != '')
Begin
if((select count(*) from ContactInformation where ObjectId = @CompanyId and ContactType='MobileNo') > 0)
Begin
	update [contactinformation] set contacts=@PhoneNo,ContactPerson=@ContactName,modifiedDate=GetDate()
	where objectid=@CompanyId and ContactType='MobileNo';
End;
Else
Begin
	
	INSERT INTO [dbo].[ContactInformation]
           ([ObjectId]
           ,[ObjectType]
           ,[ContactType]
           ,[ContactPerson]
           ,[Contacts]
           ,[Purpose]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive])
     VALUES
           (@CompanyId
           ,'Company'
           ,'MobileNo'
           ,@ContactName
           ,@PhoneNo
           ,null
           ,(select top 1 #UserDetails.createdby from #UserDetails)
           ,getdate()
           ,1)

End;
End;

if(@EmailId != '')
Begin
if((select count(*) from ContactInformation where ObjectId = @CompanyId and ContactType='Email') > 0)
Begin
	update [contactinformation] set contacts=@EmailId,ContactPerson=@ContactName,modifiedDate=GetDate()
	where objectid=@CompanyId and ContactType='Email';
End;
Else
Begin
	
	INSERT INTO [dbo].[ContactInformation]
           ([ObjectId]
           ,[ObjectType]
           ,[ContactType]
           ,[ContactPerson]
           ,[Contacts]
           ,[Purpose]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive])
     VALUES
           (@CompanyId
           ,'Company'
           ,'Email'
           ,@ContactName
           ,@EmailId
           ,null
           ,(select top 1 #UserDetails.createdby from #UserDetails)
           ,getdate()
           ,1)

End;
End;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array],
@CompanyId AS CompanyId ,'Success' as Status
FOR XML path('ServicesAction'),ELEMENTS,ROOT('Json')) AS XML)

EXEC Sp_xml_removedocument 
@intPointer 
END try 

BEGIN catch 
SELECT @ErrMsg = Error_message(); 
RAISERROR(@ErrMsg,@ErrSeverity,1); 

RETURN; 
END catch 
END
