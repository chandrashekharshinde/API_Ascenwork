-- Server : BITPL-PC7 -- 

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetUserProfileByByOrderNumber]-- '18016751','CNE'
	-- Add the parameters for the stored procedure here
	@SONumber nvarchar(50)
	,@EventType nvarchar(150)
AS
BEGIN


SELECT CAST((SELECT  
c.CompanyName as DistributorName,
c.CompanyMnemonic
,en.[Password] as 'Password'
,ISNUll(c.AddressLine1,'') + ISNUll(c.City,'') + ISNUll(c.[State],'') + ISNUll(c.Postcode,'') as DistributorAddress,
p.ContactNumber as DistributorPhone,
o.SalesOrderNumber as SaleOrderNumber,
o.CarrierNumber as Carrier,
CONVERT(varchar(19),ol.TruckOutTime,120) as TruckOutDateTime,
o.InvoiceNumber,
ol.TruckPlateNumber as PlateNumber
  FROM [order] o Left join Company c on o.SoldTo =c.CompanyId
  left join Profile p on p.ReferenceId = c.CompanyId
  left join OrderMovement om on  o.OrderId = om.OrderId
  left join OrderLogistics ol on om.OrderMovementId = ol.OrderMovementId
  LEFT JOIN EmailNotification en ON o.SalesOrderNumber = en.ObjectId WHERE o.IsActive = 1 and o.SalesOrderNumber=@SONumber AND en.IsSent=0 And EventType=@EventType
	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

		END
