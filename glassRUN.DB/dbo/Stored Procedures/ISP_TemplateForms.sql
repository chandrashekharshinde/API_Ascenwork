CREATE PROCEDURE [dbo].[ISP_TemplateForms]  --''
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

        INSERT INTO	[TemplateForms]
        (
			TemplateName,
        	TemplateBody,
        	TemplateJson,
			IsAppTemplate,
        	[Version],
        	IsActive,
			CreatedBy,
        	CreatedDate
        )
        SELECT
			tmp.[TemplateName],
        	tmp.[TemplateBody],
        	tmp.[TemplateJson],
			tmp.[IsAppTemplate],
        	tmp.[Version],
			1,
			tmp.CreatedBy,
        	GETDATE()
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		[TemplateName] nvarchar(250),
            [TemplateBody] NVARCHAR(max),
			[TemplateJson] NVARCHAR(max),
			[IsAppTemplate] NVARCHAR(50),
			[Version] NVARCHAR(max),
			[CreatedBy] NVARCHAR(200)
        )tmp
        
        DECLARE @FormBuilderId BIGINT
	    SET @FormBuilderId = @@IDENTITY
        
        
    
		SELECT @FormBuilderId as FormBuilderId FOR XML RAW('Json'),ELEMENTS
  
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END