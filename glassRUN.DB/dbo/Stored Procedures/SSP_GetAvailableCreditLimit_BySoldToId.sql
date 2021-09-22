
CREATE PROCEDURE [dbo].[SSP_GetAvailableCreditLimit_BySoldToId] --'<Json><CompanyId>592</CompanyId><EnquiryId>0</EnquiryId></Json>'

@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'


AS
BEGIN

DECLARE @intPointer INT;
declare @CompanyId bigint
declare @EnquiryId bigint=0
declare @ShipTo bigint
declare @ProposedDeliveryDate nvarchar(30)
declare @TaxPercentage  decimal(18,2)=0


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

select @TaxPercentage=CONVERT(decimal(18,0),SettingValue) from SettingMaster where SettingParameter='ItemTaxInPec'

SELECT @CompanyId = tmp.[CompanyId],
@EnquiryId=tmp.[EnquiryId]
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [EnquiryId] bigint,
    [CompanyId] bigint
   )tmp;


print  'print @EnquiryId' + convert(nvarchar(250),@EnquiryId) 

if(@EnquiryId is null)
begin
 set @EnquiryId =0
end


select  c.CompanyId , c.CompanyMnemonic ,c.ParentCompanyMnemonic, c.ActualEmpties,(ISNULL(c.AvailableCreditLimit,0) - (((ISNULL(c.TotalEnquiryCreated,0) * @TaxPercentage) / 100))) as AvailableCreditLimit,
ISNULL(c.CreditLimit,0) as CreditLimit ,ISNULL(c.EmptiesLimit,0) as EmptiesLimit
,(ISNULL(c.TotalEnquiryCreated,0) + ((( ISNULL(c.TotalEnquiryCreated,0) * @TaxPercentage) / 100))) as TotalEnquiryCreated
,ISNULL(c.EnquiryTotalDepositAmount,0) as EnquiryTotalDepositAmount,
((ISNULL(c.TotalEnquiryCreated,0) * @TaxPercentage) / 100) as TaxAmount from (Select isnull(c.CreditLimit,0) as CreditLimit,    

(Select isnull(c.AvailableCreditLimit,0) - (select isnull(sum(ep.ProductQuantity*isnull(ep.UnitPrice,0)) , 0)   from 
EnquiryProduct ep join Enquiry e on ep.EnquiryId=e.EnquiryId 
where e.EnquiryId!=@EnquiryId and 
 (e.CurrentState in (1) or (e.EnquiryId in (select o.EnquiryId from [Order] o where o.CurrentState=32)))
and e.IsActive=1 and ep.IsActive=1 and e.SoldTo=@CompanyId) from Company where CompanyId=@CompanyId) as AvailableCreditLimit ,

(Select isnull(c.EmptiesLimit,0)) as EmptiesLimit,   

(Select isnull(c.ActualEmpties,0)) as ActualEmpties   ,

(select isnull(sum(ep.ProductQuantity*isnull(ep.UnitPrice,0)) , 0)   from EnquiryProduct ep join Enquiry e on ep.EnquiryId=e.EnquiryId where e.EnquiryId!=@EnquiryId 
and (e.CurrentState in (1) or (e.EnquiryId in (select o.EnquiryId from [Order] o where o.CurrentState=32)))
and e.IsActive=1 and ep.IsActive=1 and e.SoldTo=@CompanyId) AS TotalEnquiryCreated,

(select isnull(sum(ep.ProductQuantity*isnull(ep.DepositeAmount,0)) , 0)   from EnquiryProduct ep join Enquiry e on ep.EnquiryId=e.EnquiryId where e.EnquiryId!=@EnquiryId and 
(e.CurrentState in (1) or (e.EnquiryId in (select o.EnquiryId from [Order] o where o.CurrentState=32)))
and e.IsActive=1 and ep.IsActive=1 and e.SoldTo=@CompanyId) AS EnquiryTotalDepositAmount,
c.CompanyMnemonic,
(select p.CompanyMnemonic  From  Company  p where p.CompanyId=c.ParentCompany)  as 'ParentCompanyMnemonic',
c.CompanyId

from Company c where c.CompanyId=@CompanyId) as c
FOR XML RAW('Json'),ELEMENTS      




END
