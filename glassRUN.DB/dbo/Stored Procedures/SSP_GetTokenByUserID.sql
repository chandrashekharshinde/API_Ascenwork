


Create PROCEDURE [dbo].[SSP_GetTokenByUserID]
@UserId bigint
AS
BEGIN



select isnull(AccessKey,'')  From Login  where LoginId = @UserId



END
