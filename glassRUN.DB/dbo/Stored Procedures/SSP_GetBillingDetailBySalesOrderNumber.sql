
CREATE PROCEDURE [dbo].[SSP_GetBillingDetailBySalesOrderNumber]--'<Json><ServicesAction>GetAllOrderBySalesOrderNumber</ServicesAction><SalesOrderNumber>SO-029222</SalesOrderNumber></Json>'
(
@xmlDoc XML
)
AS



BEGIN

DECLARE @intPointer INT;


Declare @SalesOrderNumber NVARCHAR(250)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @SalesOrderNumber = tmp.[SalesOrderNumber]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [SalesOrderNumber] nvarchar(250)
  
   )tmp ;




 

  select cast ((select   SalesOrderNumber ,InvoiceAmount , 
  
  CONVERT(VARCHAR(10), BillingDate, 103) + ' '  + convert(VARCHAR(8), BillingDate, 14)  as  BillingDate ,

   InvoiceNumber  ,Remarks ,1 as 'IsBilled' From  SalesOrderBilling  where SalesOrderNumber=@SalesOrderNumber
	   FOR XML PATH(''),ELEMENTS,ROOT('Json')) AS XML)


	

END