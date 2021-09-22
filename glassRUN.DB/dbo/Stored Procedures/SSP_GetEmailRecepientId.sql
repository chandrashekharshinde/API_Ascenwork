CREATE PROCEDURE [dbo].[SSP_GetEmailRecepientId] --25
@emailContentId BIGINT
AS
BEGIN
	SELECT CAST((
		SELECT 
			[EmailRecepientId],
			[RecipientType],
			--[ObjectId],
			--[ObjectType],
			[EmailEventId],
			[EmailContentId],
			[EmailAddress],
			[ToCC],
			[RoleId],
			[UserName],
			[EmailDynamicTableId],
			[EmailDynamicColumnId],
			[IsSendMailToAll],
			[IsActive]
		FROM [dbo].[EmailRecepient] 
		WHERE EmailContentId=@emailContentId
		AND IsActive=1
	FOR XML RAW('EmailRecepientList'),ELEMENTS,ROOT('EmailRecepient')) AS XML)
END
