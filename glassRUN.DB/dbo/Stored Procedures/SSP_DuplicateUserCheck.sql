Create PROCEDURE [dbo].[SSP_DuplicateUserCheck] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @LoginId bigint
Declare @UserName nvarchar(150)


Declare @IsValid bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @LoginId = tmp.[LoginId],
@UserName = tmp.[UserName]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[LoginId] bigint,
				[UserName] nvarchar(150)
           
			)tmp ;


			 if exists (select loginId from [Login] l where l.UserName = @UserName and l.LoginId <> @LoginId and l.IsActive = 1)
    BEGIN
     set @IsValid=0
    end
     else
     BEGIN
      set @IsValid=1
     end

 SELECT @IsValid as IsValid FOR XML RAW('Json'),ELEMENTS
END
