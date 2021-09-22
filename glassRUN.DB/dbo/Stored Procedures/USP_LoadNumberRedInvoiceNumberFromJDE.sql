CREATE PROCEDURE [dbo].[USP_LoadNumberRedInvoiceNumberFromJDE] --'<Json><OrderList><SONumber>Order0001</SONumber><LoadNumber>Lod00011</LoadNumber><RedInvoiceNumber>RedIn00011</RedInvoiceNumber></OrderList><OrderList><SONumber>Order0002</SONumber><LoadNumber>Lod00012</LoadNumber><RedInvoiceNumber>RedIn00012</RedInvoiceNumber></OrderList></Json>'

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

SELECT * INTO #tmpOrder
FROM OPENXML(@intpointer,'Json/OrderList',2)
WITH
(

SONumber nvarchar(200), 
LoadNumber nvarchar(200),
RedInvoiceNumber nvarchar(200)


) tmp






PRINT N'Update Order'





UPDATE dbo.[Order]

SET LoadNumber =#tmpOrder.[LoadNumber],
RedInvoiceNumber =#tmpOrder.[RedInvoiceNumber]

FROM #tmpOrder
Left Join [Order] o on #tmpOrder.SONumber=o.SalesOrderNumber where (o.LoadNumber is null or (o.redinvoicenumber is null or o.redinvoicenumber ='')) 


SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
exec sp_xml_removedocument @intPointer
END TRY
BEGIN CATCH
SELECT @ErrMsg = ERROR_MESSAGE();
RAISERROR(@ErrMsg, @ErrSeverity, 1);
RETURN; 
END CATCH
END

PRINT 'Successfully created procedure dbo.USP_ItemStock'
