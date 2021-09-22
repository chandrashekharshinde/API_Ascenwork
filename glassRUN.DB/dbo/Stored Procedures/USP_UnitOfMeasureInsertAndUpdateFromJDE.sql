CREATE  PROCEDURE [dbo].[USP_UnitOfMeasureInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpUnitOfMeasure
			FROM OPENXML(@intpointer,'Json/UnitOfMeasureList',2)
			 WITH
             (
		
			ItemLongCode nvarchar(500),
			UOM bigint,
			RelatedUOM  bigint,
			ConversionFactor float
				
			 ) tmp

			 

	 select * from  #tmpUnitOfMeasure


print N'delete UnitOfMeasure'
 

delete from UnitOfMeasure where ItemId not in (select ItemId From  Item  where ItemCode=55909001)
PRINT N'Insert UnitOfMeasure'

		INSERT INTO [dbo].[UnitOfMeasure]
           ([ItemId]
		     ,[UOM]
           ,[RelatedUOM]
		   ,[ConversionFactor]
		 ,IsActive
          )
    SELECT
			(select  ItemId  From Item where ItemCode collate DATABASE_DEFAULT=#tmpUnitOfMeasure.[ItemLongCode] collate DATABASE_DEFAULT   and IsActive=1 )
		     ,#tmpUnitOfMeasure.[UOM]
           ,#tmpUnitOfMeasure.[RelatedUOM]
		   ,#tmpUnitOfMeasure.[ConversionFactor]
		   ,1
     FROM #tmpUnitOfMeasure   where    #tmpUnitOfMeasure.[UOM] !=18


	 ----insert  for Unit Of Measure for 18 (Kg)  Interchange value of UOM and Related UOM)


	 	INSERT INTO [dbo].[UnitOfMeasure]
           ([ItemId]
		     ,[UOM]
           ,[RelatedUOM]
		   ,[ConversionFactor]
		 ,IsActive
          )
    SELECT
			(select  ItemId  From Item where ItemCode collate DATABASE_DEFAULT=#tmpUnitOfMeasure.[ItemLongCode] collate DATABASE_DEFAULT   and IsActive=1 )
		     ,#tmpUnitOfMeasure.[RelatedUOM]
			 ,#tmpUnitOfMeasure.[UOM]
          
		   ,#tmpUnitOfMeasure.[ConversionFactor]
		   ,1
     FROM #tmpUnitOfMeasure   where    #tmpUnitOfMeasure.[UOM] =18





	 drop table  #tmpUnitOfMeasure
	

           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_UnitOfMeasureInsertAndUpdateFromJDE'