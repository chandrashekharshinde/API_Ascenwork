CREATE PROCEDURE [dbo].[SSP_EnquiryProductList_SelectByCriteria]--'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 19 AND ActualTimeOfAction IS  NULL)','',dfdf
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'EnquiryProductId',
@Output nvarchar(max) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EnquiryProductId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql ='(select cast ((SELECT  ''true'' AS [@json:Array]  ,
		op.EnquiryProductId as IntOrderProductId
      ,op.EnquiryId as IntOrderId
	  ,o.EnquiryAutoNumber as OrderNumber
	  ,ProductType as VcProductType
      ,(select ItemName from item where ItemCode=op.ProductCode) as VcProductName
	  ,(select ImageUrl from item where ItemCode=op.ProductCode) as VcImageUrl
	  ,(select ItemName from item where ItemCode=op.ProductCode) as Name
	  ,(select ImageUrl from item where ItemCode=op.ProductCode) as ImageUrl
	  ,(select Isnull(Barcode,'''') from item where ItemCode=op.ProductCode) as Barcode
	  ,(op.ProductCode) AS VcItemCode
	    ,(op.ProductCode) AS ItemCode
	  ,ItemType as IntItemType
	   ,ItemType 
	  ,NULL AS VcCustomerCrossReferenceCode
	  	  ,NULL AS CustomerCrossReferenceCode
      ,(select (SELECT [dbo].[fn_LookupValueById] (I.PrimaryUnitOfMeasure)) from Item I where I.ItemCode=op.ProductCode) as [VcUnitOfMeasure],
	  (select PrimaryUnitOfMeasure from Item I where I.ItemCode=op.ProductCode) as PrimaryUnitOfMeasure
      ,NULL as [VcUnitSize]
      ,op.ProductQuantity as [IntNumberOfUnits]
      , op.ProductQuantity as  [VcQuantity]
	     ,NULL as [UnitSize]
      ,op.ProductQuantity as [NumberOfUnits]
      , op.ProductQuantity as  [Quantity]
	  ,(select CompanyName from Company where CompanyId = o.SoldTo) as CustomerName
	  ,(select CompanyMnemonic from Company where CompanyId = o.SoldTo) as CompanyMnemonic
      ,NULL AS VcSubLocationAddress
	   ,NULL AS SubLocationAddress
      ,op.[IsActive]
      ,op.[CreatedBy]
      ,op.[CreatedDate]
      , NULL as [UpdateBy]
      , NULL as [UpdatedDate]
	  ,isnull(op.UnitPrice,0) as UnitPrice
	  ,case when isnull(op.UnitPrice,0)=0 then 0 else (Select SettingValue from SettingMaster where SettingParameter=''ItemTaxInPec'') * isnull(op.UnitPrice,0)  / 100 end as TaxAmount
 FROM [EnquiryProduct] op join Enquiry o on op.EnquiryId=o.EnquiryId
   WHERE   op.IsActive = 1  and op.ProductCode !=''55909001'' and op.ItemType != 40 and ' + @WhereExpression + '
ORDER BY ' + @SortExpression  + '
 FOR XML PATH(''OrderProductInfos''),ELEMENTS)AS XML))'

  
 


 
 SET @Output=@sql
 PRINT @sql
 PRINT 'Executed SSP_OrderProductList_SelectByCriteria'
 --PRINT @Output
 -- Execute the SQL query
--EXEC sp_executesql @sql

 
 ----[dbo].[SSP_OrderProductList_SelectByCriteria] 'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 41 AND ActualTimeOfAction IS  NULL)','',dfd
