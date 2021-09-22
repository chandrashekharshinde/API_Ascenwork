
CREATE PROCEDURE [dbo].[SSP_LoadPickConfirmedOrder] --1

AS
BEGIN


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((SELECT 'true' AS [@json:Array], OrderId,SalesOrderNumber,ShipTo,SoldTo , ''  as BranchPlantCode , isnull(IsPrintPickSlip,0) as IsPrintPickSlip
 FROM [Order]
  WHERE CurrentState in (select LookUpId  from LookUp where Code='PickConfirmed') and   OrderId not in (select OrderId from OrderDocument where DocumentTypeId in (select LookUpId from LookUp where Code = 'PickSlip'))
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END
