-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.SecurityQuestion table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_SecurityQuestion]

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
            DECLARE @SecurityQuestionId bigint
            UPDATE dbo.SecurityQuestion SET
        	[Question]=tmp.Question ,
        	[IsUpperCaseAllowed]=tmp.IsUpperCaseAllowed ,
        	[IsLowerCaseAllowed]=tmp.IsLowerCaseAllowed ,
        	[IsNumberAllowed]=tmp.IsNumberAllowed ,
        	[IsSpecialCharacterAllowed]=tmp.IsSpecialCharacterAllowed ,
        	[SpecialCharactersToBeExcluded]=tmp.SpecialCharactersToBeExcluded ,
        	[MinimumUppercaseCharactersRequired]=tmp.MinimumUppercaseCharactersRequired ,
        	[MinimumLowercaseCharactersRequired]=tmp.MinimumLowercaseCharactersRequired ,
        	[MinimumSpecialCharactersRequired]=tmp.MinimumSpecialCharactersRequired ,
        	[MinimumNumericsRequired]=tmp.MinimumNumericsRequired ,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedDate]=GETDATE(),
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'SecurityQuestion',2)
			WITH
			(
            [SecurityQuestionId] bigint,
           
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
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE SecurityQuestion.[SecurityQuestionId]=tmp.[SecurityQuestionId]
            --SELECT  @SecurityQuestionId
			Select @@ROWCount
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_SecurityQuestion'
