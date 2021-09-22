CREATE PROCEDURE [dbo].[SSP_GetAllocationValueByItemId] --'<Json><ServicesAction>GetItemAllocation</ServicesAction><DeliveryLocation><LocationId>40785</LocationId><DeliveryLocationCode>40785</DeliveryLocationCode></DeliveryLocation><CompanyId>1484</CompanyId><CompanyMnemonic>200079</CompanyMnemonic><Company><CompanyId>1484</CompanyId><CompanyMnemonic>200079</CompanyMnemonic></Company><RuleType>2</RuleType><Item><ItemId>249</ItemId><SKUCode>65206012</SKUCode></Item><EnquiryId>0</EnquiryId><ItemList>65206012</ItemList><RuleAllocationValue>800</RuleAllocationValue><RuleId>37046</RuleId></Json>'
(
@xmlDoc XML
)
AS

DECLARE @intPointer INT
Declare @LocationId INT
Declare @CompanyId INT
Declare @RuleId bigint
Declare @ItemId bigint
Declare @EnquiryId bigint
Declare @fromDate datetime
Declare @toDate datetime
Declare @RuleAllocationValue decimal(18,0)=0
Declare @AllocationValue decimal(18,0)=0
Declare @ProductCode nvarchar(max)
Declare @ItemList nvarchar(max)
BEGIN

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @ItemId=tmp.[ItemId],
    @ItemList=tmp.[ItemList],
    @CompanyId = tmp.[CompanyId],
    @RuleId=tmp.[RuleId],
    @EnquiryId=tmp.[EnquiryId],
    @RuleAllocationValue=tmp.[RuleAllocationValue]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [RuleId] bigint,
   [CompanyId] int,
   [ItemId] bigint,
   [ItemList] nvarchar(max),
   [EnquiryId] bigint,
   [RuleAllocationValue] decimal(18,0)
   )tmp;




select @ProductCode=I.ItemCode from Item I where I.ItemId=@ItemId
select @fromDate=isnull(FromDate,convert(datetime,'')),@toDate= isnull(ToDate,DATEADD(Y,2,getdate())) from Rules where RuleId=@RuleId

if @fromDate is null
begin
set @fromDate=isnull(@fromDate,convert(datetime,''))
end

if @toDate is null
begin
set @toDate= isnull(@toDate,DATEADD(YEAR,2,getdate()))
end

print @fromDate
print @toDate

Select @AllocationValue=Sum(ep.ProductQuantity) from Enquiry e join EnquiryProduct ep on e.EnquiryId=ep.EnquiryId 
left join [Order] o on e.EnquiryId = o.EnquiryId
where ep.IsActive =1 and e.CurrentState not in  (8,7,33,34,999) and ISNULL(o.CurrentState,0) not in (34) and  ep.ItemType = 32 and e.EnquiryId != @EnquiryId and e.SoldTo=@CompanyId
 and Isnull(ep.AssociatedOrder,0) =0 and ep.ProductCode in  (SELECT * FROM [dbo].[fnSplitValuesForNvarchar](@ItemList))
 and CONVERT(date,e.CreatedDate) between CONVERT(date,@fromDate) and CONVERT(date,@toDate) 
 

 select  @RuleAllocationValue-Isnull(@AllocationValue,0) FOR XML RAW('AllocationValue'),ELEMENTS    
  

END


