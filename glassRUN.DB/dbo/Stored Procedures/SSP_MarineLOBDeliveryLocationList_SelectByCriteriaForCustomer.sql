CREATE PROCEDURE [dbo].[SSP_MarineLOBDeliveryLocationList_SelectByCriteriaForCustomer]--'o.ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 121 AND ActualTimeOfAction IS  NULL)','',hjk
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'mdl.MarineLOBDeliveryLocationId',
@Output NVARCHAR(max) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'DL.LocationId' END


-- ISSUE QUERY
DECLARE @sql NVARCHAR(max)


SET @sql = '

(SELECT CAST((SELECT ''true'' AS [@json:Array] ,
o.[OrderId] as IntOrderId
      ,3 as SupplierLOBId
	  ,c.CompanyId as  CustomerId
       ,8000 as VcOrderType
	  , 7001 as VcModeOfDelivery 
      ,o.[OrderNumber] as VcOrderNumber
      ,o.[PurchaseOrderNumber] as VcPurchaseOrderNumber
      ,o.[SalesOrderNumber] as VcSalesOrderNumber
      ,NULL as PartOfSalesOrder
	  ,o.ExpectedTimeOfDelivery as  DtRequestedDateOfDelivery
      , o.ExpectedTimeOfDelivery as  DtExpectedDateOfDelivery
	  
      ,NULL as DtActualDateOfDelivery
	   ,NULL as VcReceivedEmail
      ,o.[PreviousState] as VcPreviousState
      ,(SELECT [dbo].[fn_RoleWiseStatus] (4,o.CurrentState,1101)) AS VcCurrentState
	  ,(SELECT [dbo].[fn_RoleWiseClass] (4,o.CurrentState)) AS Class
      ,o.[NextState]
      ,NULL as EmailSentTimeForFulfilment
	  ,NULL as VcCustomerSignatureName
	  ,NULL as VcDriverSignatureName
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
      
	   ,c.CompanyName AS ''CustomerName''
	  ,	1 as IntIsTripSheetCreated
	  ,NULL as IntIsPartialDelivered
	   ,NULL as VcDrnRemark
	  
		, dl.LocationName as VcDeliveryLocation
		, dl.LocationName as VcVesselName
 ,NULL as VesselETA
 ,NULL as VesselETD
 ,NULL as  VcImoNumber
 ,dl.LocationId as IntMarineLobDeliveryLocationId
 ,NULL as IntIsVesselVerified
,NULL as IntIsNextPortSameCountry
 ,NULL as VcMooringStartTime
 , NULL as VcUnMooringStartTime
 , NULL as VcUnMooringEndTime
 ,NULL as VcStatus
,NULL as VcPortName
 ,NULL as VcPortCode
 ,1 as IntIsPdcRequired
,NULL as VcCountry
, NULL as VcBerthName
 ,NULL as VcRemarks
   ,NULL as VcVesselEmail
,''MLSGCA-MI'' as VcStockLocation
,(Select top 1 CreatedDate from Enquiry e where e.EnquiryId=o.EnquiryId) as EnquiryDate
,(Select top 1 sc.CompanyName from Company sc where sc.CompanyId=o.CompanyId) as SupplierName

 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
LEFt JOIN [Location] DL ON o.ShipTo = dl.LocationId

 WHERE  o.IsActive = 1   AND  o. OrderType=''SO'' and   c.IsActive = 1 and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
 FOR XML PATH(''AsnInfos''),ELEMENTS )AS XML))'
 


  SET @Output=@sql

  PRINT @Output

 PRINT 'Executed SSP_MarineLOBDeliveryLocationList_SelectByCriteria'