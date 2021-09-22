-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.LicenceMapping table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_LicenceMapping]

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
            DECLARE @LicenceMappingId bigint
            UPDATE dbo.LicenceMapping SET
        	[ProfileId]=tmp.ProfileId ,
        	[LicenceKey]=tmp.LicenceKey ,
        	[LicenceIssueDate]=tmp.LicenceIssueDate ,
        	[LicenceExpiryDate]=tmp.LicenceExpiryDate ,
        	[IsActive]=tmp.IsActive ,
        	[CreatedDate]=tmp.CreatedDate ,
        	[CreatedBy]=tmp.CreatedBy ,
        	[CreatedFromIPAddress]=tmp.CreatedFromIPAddress ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'LicenceMapping',2)
			WITH
			(
            [LicenceMappingId] bigint,
           
            [ProfileId] bigint,
           
            [LicenceKey] nvarchar(250),
           
            [LicenceIssueDate] datetime,
           
            [LicenceExpiryDate] datetime,
           
            [IsActive] bit,
           
            [CreatedDate] datetime,
           
            [CreatedBy] bigint,
           
            [CreatedFromIPAddress] nvarchar(20),
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE LicenceMapping.[LicenceMappingId]=tmp.[LicenceMappingId]
            SELECT  @LicenceMappingId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_LicenceMapping'
