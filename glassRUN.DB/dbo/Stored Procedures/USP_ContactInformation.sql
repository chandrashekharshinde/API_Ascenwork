CREATE PROCEDURE [dbo].[USP_ContactInformation] --''

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @ContactInformationId bigint
            UPDATE dbo.[ContactInformation] SET
			@ContactInformationId=tmp.[ContactInformationId],
			[ObjectType]=tmp.[ObjectType] ,
			[ContactType]=tmp.[ContactType] ,
        	[ContactPerson]=tmp.[ContactPerson],
			[Contacts]=tmp.[Contacts],
			[Purpose]=tmp.[Purpose] ,
        	[IsActive]=tmp.IsActive 
            FROM OPENXML(@intpointer,'Json/ContactInformationList',2)
			WITH
			(
            [ContactInformationId] bigint,  
			[ObjectType] nvarchar(50),      
            [ContactType] nvarchar(50),           
            [ContactPerson] nvarchar(50),
			[Contacts] nvarchar(50),
			[Purpose] nvarchar(50),
            [IsActive] bit
           
            )tmp WHERE [ContactInformation].[ContactInformationId]=tmp.[ContactInformationId]

				SELECT * INTO #tmContactInfoDetails 
			FROM OPENXML(@intpointer,'Json/ContactInformationList',2)
			 WITH
             (
			 [ContactInformationId] bigint,	
			 [ObjectId] bigint,	
			 	[ObjectType] nvarchar(50)	,
           [ContactType] nvarchar(50),           
            [ContactPerson] nvarchar(50),
			[Contacts] nvarchar(50),
			[Purpose] nvarchar(50),
			[IsActive] bit
			 ) tmp

			
			INSERT INTO [dbo].[ContactInformation]  ([ObjectId],[ObjectType],[ContactType],[ContactPerson],[Contacts],[IsActive],CreatedBy,CreatedDate)
			SELECT  #tmContactInfoDetails.[ObjectId],#tmContactInfoDetails.[ObjectType],#tmContactInfoDetails.[ContactType], #tmContactInfoDetails.[ContactPerson],#tmContactInfoDetails.[Contacts],
			#tmContactInfoDetails.[IsActive],1,GETDATE()
            FROM #tmContactInfoDetails WHERE #tmContactInfoDetails.ContactInformationId=0


            SELECT @ContactInformationId as ContactInformationId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
