-- Stored Procedure

CREATE PROCEDURE [dbo].[SSP_NewCustomerAllDataBySalesOrderNumber]  --'<Json><ServicesAction>LoadAllDriverList</ServicesAction><soNumber>1320620330</soNumber></Json>'
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
Declare @sonumber nvarchar(max)=''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @sonumber = tmp.[soNumber]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			soNumber nvarchar(max)

			)tmp;



print @sonumber
DECLARE @dyanamicQuery NVARCHAR(max)=''
DECLARE @main NVARCHAR(max)=''
DECLARE @main1 NVARCHAR(max)=''

DECLARE @marineLOBDeliveryLocationOutput nvarchar(max)=''
DECLARE @orderMovementOutput nvarchar(max)=''
DECLARE @orderProductListOutput nvarchar(max)=''
DECLARE @orderProductMovementListOutput nvarchar(max)=''
DECLARE @orderDocumentListOutput nvarchar(max)=''
DECLARE @surveyListOutput nvarchar(max)=''
DECLARE @FeedbackListOutput nvarchar(max)=''
--DECLARE @orderConfirmationListOutput nvarchar(max)
DECLARE @pushNotificationListOutput nvarchar(max)=''





--------------------Start-MarineLOBDeliveryLocation---------------------------

SET @dyanamicQuery = 'o.SalesOrderNumber='''+ @sonumber +'''' 

EXEC  [dbo].[SSP_MarineLOBDeliveryLocationList_SelectByCriteriaForCustomer] @dyanamicQuery,'',@marineLOBDeliveryLocationOutput OUTPUT


--------------------End-MarineLOBDeliveryLocation---------------------------


--------------------Start-OrderMovement---------------------------

SET @dyanamicQuery = 'om.OrderId in (select OrderId From [order] where SalesOrderNumber='''+ @sonumber +''')'

EXEC  [dbo].[SSP_OrderMovementList_SelectByCriteria] @dyanamicQuery,'',@orderMovementOutput OUTPUT


--------------------End-OrderMovement---------------------------


 --------------------Start-OrderPrdouct---------------------------

SET @dyanamicQuery = 'op.OrderId in (select OrderId From [order] where SalesOrderNumber='''+ @sonumber +''')'

EXEC  [dbo].[SSP_OrderProductList_SelectByCriteria] @dyanamicQuery,'',@orderProductListOutput OUTPUT


--------------------End-OrderPrdouct---------------------------


------------------Start-Orderdocument---------------------------

SET @dyanamicQuery = 'od.OrderId in (select OrderId From [order] where SalesOrderNumber='''+ @sonumber +''')'

EXEC  [dbo].[SSP_CustomerOrderDocuments_SelectByCriteriaPaging] @dyanamicQuery,'',@orderDocumentListOutput OUTPUT

------------------End-Orderdocument---------------------------



--------------------Start-OrderProductMovement---------------------------


SET @dyanamicQuery = 'opm.OrderId in (select OrderId From [order] where SalesOrderNumber='''+ @sonumber +''')'



EXEC  [dbo].[SSP_OrderProductMovementList_SelectByCriteria] @dyanamicQuery,'',@orderProductMovementListOutput OUTPUT

--------------------End-OrderProductMovement---------------------------



--------------------Start-Survey---------------------------


SET @dyanamicQuery = 'OrderId in (select OrderId From [order] where SalesOrderNumber='''+ @sonumber +''')'



EXEC  [dbo].[SSP_SurveyList_SelectByCriteria] @dyanamicQuery,'',@surveyListOutput OUTPUT

--------------------End-Survey---------------------------


--------------------Start-FeedBack---------------------------


SET @dyanamicQuery = ' ofb.OrderId in (select OrderId From [order] where SalesOrderNumber='''+ @sonumber +''')'



EXEC  [dbo].[SSP_FeedBackList_SelectByCriteria] @dyanamicQuery,'',@FeedbackListOutput OUTPUT

--------------------End-FeedBack---------------------------


--------------------Start-OrderConfirmation---------------------------


EXEC  [dbo].[SSP_EventNotificationListByCriteria] 'ObjectType=''ASN''','',@pushNotificationListOutput OUTPUT

--------------------End-OrderConfirmation---------------------------






--------------------- Start --main query execution---------------------------

 SET @main=';WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) select cast ((SELECT  ''true'' AS [@json:Array]  ,1 as data ,'+
  @marineLOBDeliveryLocationOutput+ ','+
 @orderMovementOutput+ ','+
 @orderProductListOutput + ','+
 @orderDocumentListOutput + ','+
 @orderProductMovementListOutput + ',' +
 @surveyListOutput + ',' 

  Set @main1= +
  @FeedbackListOutput+','+@pushNotificationListOutput +
' FOR XML PATH(''MarineAllDetail''),ELEMENTS)AS XML)'

 PRINT '@main'
 PRINT @main
  PRINT @main1
 --EXEC sp_executesql @main
 execute (@main+@main1)

 --------------------- End --main query execution---------------------------

END
