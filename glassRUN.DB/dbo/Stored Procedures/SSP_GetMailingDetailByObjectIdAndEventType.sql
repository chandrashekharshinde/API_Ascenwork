CREATE PROCEDURE [dbo].[SSP_GetMailingDetailByObjectIdAndEventType]  --'<Json><EventNotificationId>15788</EventNotificationId><EventCode>TruckOut</EventCode><EventMasterId>26</EventMasterId><ObjectId>13361</ObjectId><ObjectType>Order</ObjectType><IsCreated>0</IsCreated><IsActive>1</IsActive><CreatedBy>1</CreatedBy><CreatedDate>2019-07-26T14:08:13.4</CreatedDate><Message>jhj bkk</Message></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @EventCode nvarchar(250);
Declare @ObjectId NVARCHAR(250);
Declare @ObjectType NVARCHAR(250);

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventCode = tmp.[EventCode],
@ObjectId = tmp.[ObjectId],
@ObjectType = tmp.[ObjectType]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			ObjectId bigint,
           EventCode NVARCHAR(250),
		   ObjectType NVARCHAR(250)
			)tmp ;

IF(@ObjectType='Enquiry')
BEGIN

		
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select   (select cast ((SELECT  EnquiryId,  EnquiryAutoNumber , EnquiryType  ,  SoldToCode  , SoldToName   , ShipToCode   ,ShipToName  , PickDateTime  , EnquiryDate , RequestDate ,  PONumber  
       From  Enquiry    where  EnquiryId=  @ObjectId
 FOR XML path('Enquiry'),ELEMENTS) AS xml)) ,
  (select cast ((SELECT    'true' AS [@json:Array]  , ProductCode  ,ProductName ,ProductType ,ProductQuantity    
    from   EnquiryProduct  where  EnquiryId=  @ObjectId
 FOR XML path('EnquiryProduct'),ELEMENTS) AS xml)) ,
 (select cast ((SELECT    VehicleType  , TruckSize  , TruckCapacityPalettes ,TruckCapacityWeight    from   TruckSize  where TruckSizeId in (select TruckSizeId From  [Enquiry] where  EnquiryId=  @ObjectId) 
   
 FOR XML path('TruckSize'),ELEMENTS) AS xml)) 
 
	FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)



END
else IF(@ObjectType='Order')
BEGIN

		
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select   (select cast ((SELECT  OrderId,  OrderNumber , OrderType  ,  SoldToCode ,(Select top 1 EnquiryAutoNumber from Enquiry where EnquiryId=o.EnquiryId) as EnquiryAutoNumber , SoldToName   , ShipToCode   ,ShipToName  , PickDateTime  ,ExpectedTimeOfDelivery  , CONVERT(VARCHAR(20),  o.OrderDate, 103)  as   OrderDate   ,  CONVERT(VARCHAR(5), o.OrderDate,108)   as   OrderTime , PurchaseOrderNumber , SalesOrderNumber ,
Stock.LocationCode  as 'CollectionCode'  , stock.LocationName  as 'CollectionName',stock.Pincode  as 'CollectionPinCode' , (select    top 1  StateName From State  where StateId=stock.State)  as 'CollectionStateName',
shipTo.LocationCode  as 'DeliveryCode'  , shipTo.LocationName  as 'DeliveryName',shipTo.Pincode  as 'DeliveryPinCode' , (select    top 1  StateName From State  where StateId=shipTo.State)  as 'DeliveryStateName',
 CurrentState    , carrier.CompanyMnemonic  as 'CarrierCode'  , carrier.CompanyName  as 'CarrierName'  ,(select top 1 CompanyName  from Company where CompanyId=o.CarrierNumber) as Carrier
       From  [order]   o   left join  location stock  on o.StockLocationId = stock.LocationCode 
	   left join  Location shipTo  on shipTo.LocationId =o.ShipTo  
	   left join Company  carrier on carrier.CompanyId=o.CompanyId  where  OrderId=  @ObjectId
 FOR XML path('Order'),ELEMENTS) AS xml)) ,
  (select cast ((SELECT    'true' AS [@json:Array]  , ProductCode  ,(Select top 1 ItemName from Item where ItemCode=OrderProduct.ProductCode) as  ProductName ,ProductType ,ProductQuantity  ,ShippableQuantity  , BackOrderQuantity  , CancelledQuantity ,ReturnQuantity   ,
  (SELECT [dbo].[fn_LookupValueById] ((Select top 1 i.PrimaryUnitOfMeasure from Item i where i.ItemCode=OrderProduct.ProductCode))) as UOM,ISNULL((OrderProduct.UnitPrice),0) as ItemPricesPerUnit,ISNULL((OrderProduct.UnitPrice * OrderProduct.ProductQuantity),0) as ItemPrices,
	 (select top 1 SettingValue from SettingMaster where SettingParameter = 'ItemTaxInPec') as ItemTax,ISNULL((ISNULL(OrderProduct.DepositeAmount,0) * OrderProduct.ProductQuantity),0) as ItemTotalDepositeAmount
    from   OrderProduct  where OrderId=@ObjectId
 FOR XML path('OrderProduct'),ELEMENTS) AS xml)) ,
 (select cast ((SELECT    VehicleType  , TruckSize  , TruckCapacityPalettes ,TruckCapacityWeight   ,  (select top 1 name from  LookUp  where LookUpId=VehicleType)   as VehicleTypeName  from   TruckSize 
  where TruckSizeId in (select TruckSizeId From  [order] where  orderid=  @ObjectId) 
   
 FOR XML path('TruckSize'),ELEMENTS) AS xml)) ,
 (select cast ((SELECT   l.UserName  as 'CollectionDriverUserName'    , l.Name  as 'CollectionDriverName' ,
  om.ExpectedTimeOfAction  as 'CollectionExpectedTimeOfAction'  , om.ActualTimeOfAction  as   'CollectionActualTimeOfAction'   , 
   GroupName as 'CollectionGroupName'    , ol.TruckPlateNumber  as 'CollectionTruckNumber'  , 
   (select top 1 Contacts From ContactInformation  where   ContactType='MobileNo'  and   ObjectType='Login'  and ObjectId=l.LoginId )  as 'CollectionDriverMobileNo'
    from  OrderMovement   om   
 left join  Login  l on  om.DeliveryPersonnelId=l.LoginId 
 left join OrderLogistics  ol  on ol.OrderMovementId  =om.OrderMovementId
 
  where OrderId=@ObjectId  and LocationType=1
   
 FOR XML path('CollectionOrderMovement'),ELEMENTS) AS xml)) ,
 (select cast ((SELECT   l.UserName  as 'DeliveryDriverUserName'    , l.Name  as 'DeliveryDriverName' ,
  om.ExpectedTimeOfAction  as 'DeliveryExpectedTimeOfAction'  , om.ActualTimeOfAction  as   'DeliveryActualTimeOfAction'   ,  GroupName as 'DeliveryGroupName' ,
   ol.TruckPlateNumber  as 'DeliveryTruckNumber' ,
     (select top 1 Contacts From ContactInformation  where   ContactType='MobileNo'  and   ObjectType='Login'  and ObjectId=l.LoginId )  as 'DeliveryDriverMobileNo' 
	  from  OrderMovement   om   
 left join  Login  l on  om.DeliveryPersonnelId=l.LoginId 
 left join OrderLogistics  ol  on ol.OrderMovementId  =om.OrderMovementId
 
  where OrderId=@ObjectId  and LocationType=2
   
 FOR XML path('DeliveryOrderMovement'),ELEMENTS) AS xml)) 
 
	FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)


	


END
else  IF(@ObjectType='PaymentRequest')
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select   (select cast ((select o.OrderNumber  ,SlabName  ,SlabReason , AmountUnit  , Amount , PaidAmount , ISNULL(Remark,'-') as Remark   From PaymentRequest  pr  join [order]  o  on o.OrderId  =pr.OrderId

   where  pr.PaymentRequestId=@ObjectId
 FOR XML path('PaymentRequest'),ELEMENTS) AS xml)) ,
  (select cast ((SELECT   c.CompanyName as 'CarrierName'  ,  c.CompanyMnemonic  as 'CarrierCode'  , tac.AccountName  , BankName , AccountNumber  , AccountType  from TransporterAccountDetail TAC  join Company c  on  c.CompanyId = TAC.ObjectId  and ObjectType='Company' 
      where  TransporterAccountDetailId  in (select TransporterAccountDetailId From  PaymentRequest  where PaymentRequestId=@ObjectId)
 FOR XML path('TransporterAccountDetail'),ELEMENTS) AS xml))
 
	FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)

END


else  IF(@ObjectType='Login')
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT l.LoginId As [ProfileId]
      ,c.ContactPerson As [Name]
      ,c.Contacts AS [EmailId]
      --,[ContactNumber]
      ,l.[IsActive]
      ,l.[CreatedDate]
      ,l.[CreatedBy]
	  ,l.UserName
	  ,l.[GUID]
	  ,'<a href =''' + (select SettingValue from SettingMaster where SettingParameter = 'PasswordResetURL') + l.[GUID]+'''>Click</a>'  as UrlLink
 FROM dbo.[Login] l inner join ContactInformation c on c.ObjectId=l.LoginId and c.ObjectType = 'Login' and c.ContactType = 'Email' 
 WHERE l.IsActive = 1 and l.LoginId=@ObjectId
 
	FOR XML path('Login'),ELEMENTS,ROOT('Json')) AS XML)

	

END



else  IF(@ObjectType='Company')
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT CompanyName as SoldToName from Company where CompanyId=@ObjectId
	FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)

	

END


else  IF(@ObjectType='TruckIn')
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select top 1 PlateNumber from TruckInDeatils where PlateNumber in (select VehicleName from TransportVehicle where TransportVehicleId=@ObjectId)
	FOR XML path('TruckList'),ELEMENTS,ROOT('Json')) AS XML)

	

END


else  IF(@ObjectType='TruckOut')
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select top 1 PlateNumber from TruckInDeatils where PlateNumber in (select VehicleName from TransportVehicle where TransportVehicleId=@ObjectId)
	FOR XML path('TruckList'),ELEMENTS,ROOT('Json')) AS XML)

	

END




END
