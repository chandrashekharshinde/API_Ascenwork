CREATE PROCEDURE [dbo].[SSP_GetAllEnquiryDetailsByEnquiryNumber] --N'<Json><ServicesAction>GetAllEnquiryDetailsByEnquiryNumber</ServicesAction><soNumber>011403</soNumber></Json>'
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
Declare @enquiryNumber nvarchar(max)=''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @enquiryNumber = tmp.[soNumber]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			soNumber nvarchar(max)

			)tmp;


DECLARE @dyanamicQuery NVARCHAR(max)
DECLARE @main NVARCHAR(max)
DECLARE @main1 NVARCHAR(max)
DECLARE @main2 NVARCHAR(max)

DECLARE @marineLOBDeliveryLocationOutput nvarchar(max)

DECLARE @orderProductListOutput nvarchar(max)






--------------------Start-MarineLOBDeliveryLocation---------------------------

SET @dyanamicQuery = 'o.EnquiryAutoNumber='''+ @enquiryNumber +'''' 

EXEC  [dbo].[SSP_EnquiryList_SelectByCriteriaForCustomer] @dyanamicQuery,'',@marineLOBDeliveryLocationOutput OUTPUT


--------------------End-MarineLOBDeliveryLocation---------------------------




 --------------------Start-OrderPrdouct---------------------------

SET @dyanamicQuery = 'o.EnquiryAutoNumber='''+ @enquiryNumber +'''' 

EXEC  [dbo].[SSP_EnquiryProducttList_SelectByCriteria] @dyanamicQuery,'',@orderProductListOutput OUTPUT


--------------------End-OrderPrdouct---------------------------



--------------------- Start --main query execution---------------------------

  SET @main=';WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) select cast ((SELECT  ''true'' AS [@json:Array]  ,1 as data ,'

 Set @main1=@marineLOBDeliveryLocationOutput+ ','

Set @main2= @orderProductListOutput +' FOR XML PATH(''MarineAllDetail''),ELEMENTS)AS XML)'

  PRINT '@main'
  PRINT @marineLOBDeliveryLocationOutput
    PRINT @orderProductListOutput
 --EXEC sp_executesql @main
 execute(@main+@main1+@main2)

 --------------------- End --main query execution---------------------------

END
