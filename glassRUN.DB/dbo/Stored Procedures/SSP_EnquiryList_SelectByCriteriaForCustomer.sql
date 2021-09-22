CREATE PROCEDURE [dbo].[SSP_EnquiryList_SelectByCriteriaForCustomer]--'o.ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 121 AND ActualTimeOfAction IS  NULL)','',hjk
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
     o.EnquiryId as  [OrderId]
	 ,o.EnquiryId as  [IntOrderId]
      ,3 as SupplierLOBId
	  ,c.CompanyId as  CustomerId
       ,8000 as OrderType
	  , 7001 as ModeOfDelivery 
      ,  o.EnquiryAutoNumber as  [OrderNumber]
      ,'''' as [PurchaseOrderNumber]
      ,o.EnquiryAutoNumber as [SalesOrderNumber]
	  ,o.EnquiryAutoNumber as  VcSalesOrderNumber
      ,NULL as PartOfSalesOrder
	  ,o.RequestDate as  RequestedDateOfDelivery
	  ,o.RequestDate as DtRequestedDateOfDelivery
      , o.RequestDate as  ExpectedDateOfDelivery
	  ,isnull((SELECT [dbo].[fn_RoleWiseStatus] (4,o.CurrentState,1101)),''-'') AS VcCurrentState
	  ,(SELECT [dbo].[fn_RoleWiseClass] (4,o.CurrentState)) AS Class
      ,NULL as ActualDateOfDelivery
	   ,NULL as ReceivedEmail
      ,o.[PreviousState]
      ,[CurrentState]
      , 0  as [NextState]
      ,NULL as EmailSentTimeForFulfilment
	  ,NULL as CustomerSignatureName
	  ,NULL as DriverSignatureName
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
       ,o.[CreatedDate] as EnquiryDate
	   ,c.CompanyName AS ''CustomerName''
	  ,	1 as IsTripSheetCreated
	  ,NULL as IsPartialDelivered
	   ,NULL as DrnRemark
	  
		, dl.LocationName as DeliveryLocation
		, dl.LocationName as VcDeliveryLocation
		, dl.LocationName as VesselName
 ,NULL as VesselETA
 ,NULL as VesselETD
 ,NULL as  IMONumber
 ,dl.LocationId as MarineLobDeliveryLocationId
 ,NULL as IsVesselVerified
,NULL as IsNextPortSameCountry
 ,NULL as MooringStartTime
 , NULL as UnMooringStartTime
 , NULL as UnMooringEndTime
 ,NULL as Status
,NULL as PortName
 ,NULL as PortCode
 ,1 as IsPDCRequired
,NULL as Country
, NULL as BerthName
 ,NULL as Remarks
   ,NULL as VesselEmail
,''MLSGCA-MI'' as StockLocation
,(Select top 1 sc.CompanyName from Company sc where sc.CompanyId=o.CompanyId) as SupplierName
 FROM enquiry o left JOIN Company c ON c.CompanyId = o.SoldTo
LEFt JOIN Location DL ON o.ShipTo = dl.LocationId

 WHERE  o.IsActive = 1   AND c.IsActive = 1 and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
  FOR XML PATH(''AsnInfos''),ELEMENTS )AS XML))'



  SET @Output=@sql

  PRINT @Output

 PRINT 'Executed SSP_EnquiryList_SelectByCriteriaForCustomer'

 








