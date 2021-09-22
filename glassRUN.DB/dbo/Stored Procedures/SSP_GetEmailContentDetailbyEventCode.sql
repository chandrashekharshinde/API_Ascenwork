CREATE PROCEDURE [dbo].[SSP_GetEmailContentDetailbyEventCode]-- '<Json><EventCode>MRN</EventCode></Json>'
(
	@xmlDoc XML
)
AS
BEGIN
	
	DECLARE @intPointer INT;
	Declare @EventCode nvarchar(250);

	EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
	SELECT 
		@EventCode = tmp.[EventCode]
	FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
		[EventCode] nvarchar(250)
	)tmp ;

			
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((
		SELECT  
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
		and EmailEventId in (select EmailEventId from EmailEvent where EventCode=@EventCode)
	FOR XML path('EmailContent'),ELEMENTS,ROOT('Json')) AS XML)
END
