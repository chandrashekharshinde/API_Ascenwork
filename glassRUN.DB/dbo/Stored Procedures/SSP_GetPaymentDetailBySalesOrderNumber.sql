
CREATE PROCEDURE [dbo].[SSP_GetPaymentDetailBySalesOrderNumber]--'<Json><ServicesAction>GetAllOrderBySalesOrderNumber</ServicesAction><SalesOrderNumber>SO-029222</SalesOrderNumber></Json>'
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




 
 WITH  XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
  select cast ((select  'true' AS [@json:Array]  ,SalesOrderPaymentId, SalesOrderNumber , 
  	CONVERT(VARCHAR(10), PaymentDate, 103) + ' '  + convert(VARCHAR(8), PaymentDate, 14)  as  PaymentDate ,
 
	 ModeOfPaymentType ,(select top 1 Name from LookUp where LookUpId=ModeOfPaymentType) as 'ModeOfPaymentTypeText',
   ReferenceNumber,  PaymentAmount  ,Remarks ,BankName, (select InvoiceNumber   From  SalesOrderBilling sob  where sob.SalesOrderNumber=SalesOrderPayment.SalesOrderNumber)   as InvoiceNumber
   
   
    From  SalesOrderPayment  where SalesOrderNumber=@SalesOrderNumber
	   FOR XML PATH('SalesOrderPaymentList'),ELEMENTS,ROOT('Json')) AS XML)


	

END