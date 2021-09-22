CREATE PROCEDURE [dbo].[SSP_GetEmailContentDetailsByEmailContentId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'
(
	@xmlDoc XML
)
AS
BEGIN

	DECLARE @intPointer INT;
	Declare @emailContentId bigint
	
	EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	SELECT 
		@emailContentId = tmp.[EmailContentId]
	FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
		[EmailContentId] bigint
    )tmp ;

	
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((
		SELECT  
			'true' AS [@json:Array],
			[EmailContentId],
			[SupplierId],
			[CompanyId],
			[EmailEventId],
			[Subject],
			[EmailHeader],
			[EmailBody],
			[EmailFooter],
			[CcEmailAddress],
			[UserProfileId],
			[OtherEmailAdresses],
			[IsActive],
			[CreatedBy],
			[CreatedDate],
			[UpdatedBy],
			[UpdatedDate],
			(SELECT cast ((
				SELECT   
					'true' AS [@json:Array], 
					[EmailRecepientId],
					[RecipientType],
					--[ObjectId],
					--[ObjectType],
					[EmailEventId],
					[EmailContentId],
					[EmailAddress] as Email,
					[ToCC] as EmailType,
					[RoleId],
					[UserName],
					[EmailDynamicTableId],
					[EmailDynamicColumnId],
					[IsSendMailToAll],
					[IsActive]
				FROM [EmailRecepient] er		
				WHERE er.IsActive = 1 
				AND er.EmailEventId= [EmailContent].EmailEventId  
			FOR XML path('EmailRecepientList'),ELEMENTS) AS xml))
		FROM [EmailContent]  
		WHERE IsActive = 1 
		and [EmailContentId]=@emailContentId
	FOR XML path('EmailContentList'),ELEMENTS,ROOT('Json')) AS XML)
END
