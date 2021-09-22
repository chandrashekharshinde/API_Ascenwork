-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailEvent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_ResourcesKey] --'<Resource><ResourceId>19590</ResourceId><CultureId>1101</CultureId><PageName>CreateInquiryPage</PageName><ResourceType>Total Credit Limit</ResourceType><ResourceKey>res_CreateInquiryPage_TotalCreditLimit</ResourceKey><ResourceValue>Tổng hạn mức tín dụng</ResourceValue><VersionNo>1.0</VersionNo><IsActive>true</IsActive></Resource>'

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
            DECLARE @ResourceId bigint
           UPDATE [dbo].[Resources]
		SET  
		     @ResourceId=tmp.[ResourceId],
		     [CultureId] = tmp.[CultureId]
			,[PageName] = tmp.[PageName]
			,[ResourceType] = tmp.[ResourceType]
			,[ResourceKey] = tmp.[ResourceKey]
			,[ResourceValue] = tmp.[ResourceValue]
			,[VersionNo] = tmp.[VersionNo]
			,[IsActive] = tmp.[IsActive]
            FROM OPENXML(@intpointer,'Resource',2)
			WITH
			(
			[ResourceId] bigint,
			[CultureId] int,
			[PageName] nvarchar(max),
			[ResourceType] nvarchar(max),
			[ResourceKey] nvarchar(max) ,
			[ResourceValue] nvarchar(max) ,
			[VersionNo] nvarchar(max) ,
			[IsActive] bit
            )tmp WHERE 
			--[Resources].ResourceId=tmp.[ResourceId]
			[Resources].ResourceKey=tmp.[ResourceKey]
			and [Resources].CultureId=tmp.[CultureId]
            --SELECT  @ResourceId
			  SELECT @ResourceId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailEvent'
