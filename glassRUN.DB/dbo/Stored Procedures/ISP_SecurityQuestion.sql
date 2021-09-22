-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.SecurityQuestion table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_SecurityQuestion]
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

        INSERT INTO	[SecurityQuestion]
        (
        	[Question],
        	[IsUpperCaseAllowed],
        	[IsLowerCaseAllowed],
        	[IsNumberAllowed],
        	[IsSpecialCharacterAllowed],
        	[SpecialCharactersToBeExcluded],
        	[MinimumUppercaseCharactersRequired],
        	[MinimumLowercaseCharactersRequired],
        	[MinimumSpecialCharactersRequired],
        	[MinimumNumericsRequired],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress]
        )

        SELECT
        	tmp.[Question],
        	tmp.[IsUpperCaseAllowed],
        	tmp.[IsLowerCaseAllowed],
        	tmp.[IsNumberAllowed],
        	tmp.[IsSpecialCharacterAllowed],
        	tmp.[SpecialCharactersToBeExcluded],
        	tmp.[MinimumUppercaseCharactersRequired],
        	tmp.[MinimumLowercaseCharactersRequired],
        	tmp.[MinimumSpecialCharactersRequired],
        	tmp.[MinimumNumericsRequired],
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress]
            FROM OPENXML(@intpointer,'SecurityQuestion',2)
        WITH
        (
            [Question] nvarchar(250),
            [IsUpperCaseAllowed] bit,
            [IsLowerCaseAllowed] bit,
            [IsNumberAllowed] bit,
            [IsSpecialCharacterAllowed] bit,
            [SpecialCharactersToBeExcluded] nvarchar(50),
            [MinimumUppercaseCharactersRequired] int,
            [MinimumLowercaseCharactersRequired] int,
            [MinimumSpecialCharactersRequired] int,
            [MinimumNumericsRequired] int,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20)
        )tmp
        
        DECLARE @SecurityQuestion bigint
	    SET @SecurityQuestion = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @SecurityQuestion
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
