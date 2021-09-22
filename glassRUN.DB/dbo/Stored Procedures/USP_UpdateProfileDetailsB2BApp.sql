CREATE PROCEDURE [dbo].[USP_UpdateProfileDetailsB2BApp] --'<Json><ServicesAction>UpdateProfileDetailsForSubDApp</ServicesAction><UserDetails><Name>Red Apron - Sub D</Name><Code>98888771</Code><EmailId>dyanl@disrptiv.com</EmailId><AddressLine1>35 Hai Bà Trưng</AddressLine1><AddressLine2>Bến Nghé, Quận 1</AddressLine2><AddressLine3 /><Pincode>234</Pincode><State>Hanoi</State><City>2763</City><createdby>10630</createdby></UserDetails></Json>'
@xmlDoc XML 
AS 
BEGIN 
SET arithabort ON 

DECLARE @ErrMsg NVARCHAR(2048) 
DECLARE @ErrSeverity INT; 
DECLARE @intPointer INT; 
 

DECLARE @PhoneNo nvarchar(250) 

SET @ErrSeverity = 15; 

BEGIN try 
EXEC Sp_xml_preparedocument 
@intpointer output, 
@xmlDoc 
--select Row_Number() Over(order by tmp.[Code]) as rownum,* into #UserDetails
--FROM OPENXML(@intpointer,'Json/UserProfileList',2)
--WITH
--(
--[FirstName] nvarchar(2000),
--[LastName] nvarchar(2000),
--[Code] nvarchar(200),
--[Phone] nvarchar(250),
--[EmailId] nvarchar(250),
--[Createdby] bigint,
--[Photo] nvarchar(max)
--)tmp

select * into #UserDetails
FROM OPENXML(@intpointer,'Json/UserProfileList',2)
WITH
(
[FirstName] nvarchar(2000),
[LastName] nvarchar(2000),
[Code] nvarchar(200),
[Phone] nvarchar(250),
[EmailId] nvarchar(250),
[Createdby] bigint,
[Photo] nvarchar(max),
[CountryCode] nvarchar(250)
)tmp	

	--declare @rownum bigint
	--set @rownum=1
	--declare @rowCount bigint

	--set @rowCount=(select Count(*) from #UserDetails)
	--while(@rownum<=@rowCount)
	--begin
		
		DECLARE @CompanyId BIGINT 
		DECLARE @EmailId NVARCHAR(500) 
		DECLARE @ContactName NVARCHAR(500)
		DECLARE @CreatedBy BIGINT
		DECLARE @photo NVARCHAR(max)

		--select top 1 @CompanyId= company.CompanyId from company ,#UserDetails where #UserDetails.rownum=@rownum and company.CompanyMnemonic= #UserDetails.[Code]
		select top 1 @CompanyId= company.CompanyId from company ,#UserDetails where company.CompanyMnemonic= #UserDetails.[Code]

		select top 1 @ContactName= #UserDetails.[FirstName] + ' ' + #UserDetails.[LastName],
		@EmailId=#UserDetails.[EmailId],
		@PhoneNo=#UserDetails.[CountryCode] + '-' + #UserDetails.[Phone],
		@CreatedBy = #UserDetails.[Createdby],
		@photo = #UserDetails.[Photo]
		FROM company ,#UserDetails where company.CompanyMnemonic= #UserDetails.[Code]
		--FROM company ,#UserDetails where #UserDetails.rownum=@rownum and company.CompanyMnemonic= #UserDetails.[Code]

		Update [Login] set [Name] = @ContactName, UpdatedBy = @CreatedBy, UpdatedDate = GETDATE() where ReferenceId = @CompanyId
		
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
					   ,@CreatedBy
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
					   ,@CreatedBy
					   ,getdate()
					   ,1)

			End;
		End;

		if(@photo != '')
		Begin
			if((select count(*) from ContactInformation where ObjectId = @CompanyId and ContactType='Photo') > 0)
			Begin
				update [contactinformation] set contacts=@photo,ContactPerson=@ContactName,ModifiedBy=@CreatedBy,modifiedDate=GetDate()
				where objectid=@CompanyId and ContactType='Photo';
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
						,'Photo'
						,@ContactName
						,@photo
						,null
						,@CreatedBy
						,getdate()
						,1)

			End;
		End;
		
	--	set @rownum=@rownum+1
	--end;

	drop table #UserDetails;
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array],
1 AS CompanyId ,'Success' as Status
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