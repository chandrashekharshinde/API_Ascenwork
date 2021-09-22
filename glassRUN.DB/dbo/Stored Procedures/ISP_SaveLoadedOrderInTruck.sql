
CREATE PROCEDURE [dbo].[ISP_SaveLoadedOrderInTruck] --'<Json><ServicesAction>SaveLoadedOrderInTruck</ServicesAction><OrderList><TruckInDeatilsId>1</TruckInDeatilsId><OrderNumber>026516/01</OrderNumber><PlateNumber>NIM0003</PlateNumber><StockLocationCode>749</StockLocationCode><IsLoadedInTruck>true</IsLoadedInTruck></OrderList></Json>'
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
		 [OrderNumber] nvarchar(100) ,
		 [CurrentState]  bigint 
        )


Delete from TruckInOrder where PlateNumber = (select top 1 #tempTruckInDeatils.[PlateNumber] from  #tempTruckInDeatils) 
and TruckInDeatilsId = (select top 1 #tempTruckInDeatils.[TruckInDeatilsId] from  #tempTruckInDeatils) 
and TruckInDataTime = (Select top 1 td.TruckInDataTime from TruckInDeatils td where td.TruckInDeatilsId=(select top 1 #tempTruckInDeatils.[TruckInDeatilsId] from  #tempTruckInDeatils))
and TruckOutDataTime is null
--Update TruckInOrder set IsLoadedInTruck=1,[TruckInDeatilsId]=tmp.[TruckInDeatilsId],[PlateNumber]=tmp.[PlateNumber],[TruckInDataTime]=(Select top 1 td.TruckInDataTime from TruckInDeatils td where td.TruckInDeatilsId=tmp.[TruckInDeatilsId])   from  #tempTruckInDeatils tmp where tmp.OrderNumber=TruckInOrder.OrderNumber

  INSERT INTO [dbo].[TruckInOrder]
           ([PlateNumber]
           ,[TruckInDeatilsId]
           ,[OrderNumber]
		   ,[TruckInDataTime]
		   ,[IsLoadedInTruck]
           ,[CreatedDate])
	SELECT tmp.[PlateNumber]
           ,tmp.[TruckInDeatilsId]
           ,tmp.[OrderNumber]
		   ,(Select top 1 td.TruckInDataTime from TruckInDeatils td where td.TruckInDeatilsId=tmp.[TruckInDeatilsId])
		   ,1
           ,GETDATE()
  from  #tempTruckInDeatils tmp where tmp.OrderNumber not in (Select tio.[OrderNumber] from  [dbo].[TruckInOrder] tio)


  --update [order]  set CurrentState=#tempTruckInDeatils.CurrentState 
  
  --from    #tempTruckInDeatils   join  [order]  o  on o.OrderNumber = #tempTruckInDeatils.[OrderNumber]
  
    
        
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
