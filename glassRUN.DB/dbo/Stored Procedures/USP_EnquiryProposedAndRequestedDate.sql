Create PROCEDURE [dbo].[USP_EnquiryProposedAndRequestedDate] --'<Json><OrderGUID>a2f30f6a-7409-4bef-a714-5c6964df6bf8</OrderGUID><EnquiryId>8410</EnquiryId><RequestDate>12/03/2018</RequestDate><ShipTo>647</ShipTo><SoldTo>592</SoldTo><TruckSizeId>16</TruckSizeId><IsActive>true</IsActive><IsRecievingLocationCapacityExceed>false</IsRecievingLocationCapacityExceed><NumberOfPalettes>28</NumberOfPalettes><PalletSpace>27.777777777777779</PalletSpace><TruckWeight>34.007506</TruckWeight><OrderProposedETD>13/03/2018</OrderProposedETD><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CreatedBy>8</CreatedBy><OrderProductList><OrderGUID>a2f30f6a-7409-4bef-a714-5c6964df6bf8</OrderGUID><EnquiryProductId>25888</EnquiryProductId><ItemId>73</ItemId><AssociatedOrder>0</AssociatedOrder><ItemName>Heineken 330x24B Ctn Alu</ItemName><ItemPricesPerUnit>0.0000</ItemPricesPerUnit><ProductCode>65201011</ProductCode><PrimaryUnitOfMeasure>Carton</PrimaryUnitOfMeasure><ProductQuantity>1999</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>1.649400000000000e+001</WeightPerUnit><IsActive>1</IsActive><ItemType>32</ItemType><DepositeAmountPerUnit>0.0000</DepositeAmountPerUnit></OrderProductList></Json>'

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

            DECLARE @EnquiryId bigint

            UPDATE dbo.Enquiry SET
			@EnquiryId=tmp.EnquiryId,
			[RequestDate] = convert(datetime, tmp.RequestDate , 103) ,
			[EnquiryDate] = GETDATE(),
        	[OrderProposedETD] = convert(datetime, tmp.OrderProposedETD , 103) 
        	
        	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] bigint,     
            [RequestDate] nvarchar(500),
			[OrderProposedETD] nvarchar(500)

            )tmp WHERE Enquiry.[EnquiryId]=tmp.[EnquiryId]


        	
           SELECT @EnquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Enquiry'
