CREATE PROCEDURE [dbo].[USP_CompanyVersionMapping]

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
            DECLARE @CompanyVersionMappingId bigint
            UPDATE dbo.CompanyVersionMapping SET
        	[CompanyId]=tmp.CompanyId ,
        	[ObjectId]=tmp.ObjectId ,
        	[ObjectName]=tmp.ObjectName ,
        	[VersionNumber]=tmp.VersionNumber ,
        	[IsActive]=tmp.IsActive ,        
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=tmp.ModifiedDate
            FROM OPENXML(@intpointer,'CompanyVersionMapping',2)
			WITH
			(
            [CompanyVersionMappingId] bigint,
           
            [CompanyId] bigint,
           
            [ObjectId] bigint,
           
            [ObjectName] nvarchar(150),
           
            [VersionNumber] nvarchar(50),
           
            [IsActive] bit,
           
            [ModifiedBy] bigint,
           
            [ModifiedDate] datetime
           
            )tmp WHERE CompanyVersionMapping.[CompanyVersionMappingId]=tmp.[CompanyVersionMappingId]
            SELECT  @CompanyVersionMappingId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
