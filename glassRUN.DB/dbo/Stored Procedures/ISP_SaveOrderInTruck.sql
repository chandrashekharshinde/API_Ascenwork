Create PROCEDURE [dbo].[ISP_SaveOrderInTruck]--'<Json><UserId>0</UserId><OrderId>0</OrderId><ServicesAction>CreateLog</ServicesAction><LogDescription>Empties Limit</LogDescription><LogDate>17/10/2017 13:41</LogDate></Json>'
@xmlDoc xml 
AS 
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
		Declare @PlateNumber nvarchar(50)
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	Select * into #tempTruckInDeatils FROM OPENXML(@intpointer,'Json/OrderList',2)
        WITH
        (
		 [PlateNumber] nvarchar(100) ,
		 [TruckInDeatilsId] bigint ,
		 [OrderNumber] nvarchar(100) 
        )


  INSERT INTO [dbo].[TruckInOrder]
           ([PlateNumber]
           ,[TruckInDeatilsId]
           ,[OrderNumber]
		   ,[TruckInDataTime]
           ,[CreatedDate])
	SELECT [PlateNumber]
           ,[TruckInDeatilsId]
           ,[OrderNumber]
		   ,(Select top 1 td.TruckInDataTime from TruckInDeatils td where td.TruckInDeatilsId=#tempTruckInDeatils.[TruckInDeatilsId])
           ,GETDATE()
  from  #tempTruckInDeatils
            
        
        DECLARE @TruckInDeatilsId BIGINT


	    SET @TruckInDeatilsId = @@IDENTITY
        
    SELECT @TruckInDeatilsId as TruckInDeatilsId FOR XML RAW('Json'),ELEMENTS
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END