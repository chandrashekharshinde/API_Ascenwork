Create PROCEDURE [dbo].[SSP_PdcInformationList_SelectByCriteria]--'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 39 AND ActualTimeOfAction IS  NULL)'
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' PdcInformationId',
@Output nvarchar(2000) output


AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'PdcInformationId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , 
 PdcInformationId,
 PdcInformationGuid,
 SupplierLOBId,
 SupplierId,
 LOBId,
 ModeOfPdcDocumentTypeId,
  OrderId,
   (select od.OrderNumber from [Order] od where od.OrderId=PdcInformation.[OrderId]) as OrderNumber,
  OrderProductId,
  LocationId,
  SubLocationId,
  IsGenerated,
  IsCompleted
    FROM dbo.PdcInformation
 WHERE   ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
FOR XML PATH(''PdcInformationInfos''),ELEMENTS)AS XML))'
  SET @Output = @sql


 PRINT 'Executed SSP_PdcInformationList_SelectByCriteria'
