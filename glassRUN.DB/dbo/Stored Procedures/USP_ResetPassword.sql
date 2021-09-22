Create PROCEDURE [dbo].[USP_ResetPassword] --'<Json><ServicesAction>UpdateSchedulingDate</ServicesAction><EnquiryDetailList><SchedulingDate>15/12/2017</SchedulingDate><EnquiryId>236</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @profileId bigint
Declare @hashedPassword nvarchar(500)
Declare @saltPassword int
Declare @password nvarchar(200)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @profileId = tmp.[ProfileId],
    @hashedPassword = tmp.HashedPassword,
	@saltPassword=tmp.PasswordSalt,
	@password=tmp.[Password]
   
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   HashedPassword nvarchar(500),
   PasswordSalt int,
   [ProfileId] bigint,
   [Password] nvarchar(200)
           
   )tmp
  

  




   update Login set HashedPassword  = @hashedPassword,PasswordSalt=@saltPassword where ProfileId = @profileId
   
   
   
   SELECT @profileId as OrderId,@password as UserPassword FOR XML RAW('Json'),ELEMENTS

END
