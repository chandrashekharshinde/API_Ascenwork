
--Change By : Arun Dubey 
--Change Date : 18/09/2019
--added columns in select clause to fetch customer region (Column Name : CompanyZone).


CREATE PROCEDURE [dbo].[SSP_GetAllTempMOTOrderList] --'<Json><GratisOrderList><ItemCode>66201106</ItemCode><ItemDesc>HNK</ItemDesc><UOM>carton</UOM><Quantity>11</Quantity><PONumber>PO312312</PONumber><ShipToCode>1110005</ShipToCode><TruckSize>14T</TruckSize></GratisOrderList><GratisOrderList><ItemCode>67001031</ItemCode><ItemDesc>tiger</ItemDesc><UOM>carton</UOM><Quantity>15</Quantity><PONumber>PO1231232131</PONumber><ShipToCode>1110142</ShipToCode><TruckSize>10T</TruckSize></GratisOrderList></Json>'
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


   select *   into #tmpGratisOrderList
    FROM OPENXML(@intpointer,'Json/MOTOrderList',2)
        WITH
        (	[OrderGroupCode] nvarchar(200),
			[OrderId]	bigint,
			[JDEOrderNumber]	bigint,
			[AssociatedOrderNumber]	bigint,
			----[ShipTo]	bigint,
			[ShipToCode]	nvarchar(50),
			[SoldToCode] nvarchar(50),
			[BranchPlantCode] nvarchar(50),
			[OrderedBy] nvarchar(50),
			[OrderType] nvarchar(50),
			[GratisCode] nvarchar(50),
			PONumber nvarchar(50),
			[TruckSize]	nvarchar(50),
			[ItemCode] nvarchar(50),
			[Quantity]	nvarchar(250),
			[UnitOfMeasure] nvarchar(100),
			[IsConsumed]	bit,
			[IsActive]	bit,
			[CreatedBy]	bigint,
			[UpdatedBy]	bigint,
			[IPAddress]	nvarchar(20),
			[Description1] nvarchar(500),
			[Description2] nvarchar(500),
			Province nvarchar(50),
			[SequenceNumber]	bigint,
			Promotion nvarchar(250)
        )tmp
		
		

   select    
	tmp.OrderGroupCode,
	tmp.OrderId,
	tmp.JDEOrderNumber,
	tmp.AssociatedOrderNumber,
	isnull(d.LocationId,0) as ShipTo,
	tmp.BranchPlantCode,
	tmp.ShipToCode,
	tmp.OrderedBy,
	tmp.GratisCode,
	tmp.PONumber,
	tmp.OrderType,
	isnull((select top 1 branch.LocationId from Location branch where branch.LocationCode=tmp.[BranchPlantCode] and branch.IsActive=1 and branch.LocationType=21),0) as BranchPlantId,
	
	tmp.[SoldToCode],
	(select LocationName from Location where LocationCode =tmp.[ShipToCode]) as DeliveryLocationName,
	isnull(com.CompanyID ,0)as SoldTo,
	isnull(com.CompanyID ,0) as CompanyId,
	isnull(com.Field9, '') as CompanyZone,
	isnull(com.Field9, '') as Field9,
	com.CompanyName as CustomerName,	
	com.CompanyMnemonic as CompanyMnemonic,
	isnull(t.TruckSizeId,0) as TruckSizeId,
	d.Area,

t.TruckCapacityWeight,
t.TruckCapacityPalettes,

	--isnull([dbo].[fn_GetWeightPerUnitOfItem](I.ItemId),0) as ItemWeightPerUnit,
	isnull((ConversionFactor),0) as ConversionFactor,
	----CEILING((case isnull(ConversionFactor,0) when 0 then 0 else (isnull(tmp.Quantity,0)/isnull(ConversionFactor,1)) end)) as TotalRequiredPalettes,
	--(case isnull(ConversionFactor,0) when 0 then 0 else (isnull(tmp.Quantity,0)/isnull(ConversionFactor,1)) end) as TotalRequiredPalettes,
	--(isnull(tmp.Quantity,0)*isnull([dbo].[fn_GetWeightPerUnitOfItem](I.ItemId),0)) TotalRequiredWeight,
	(select top 1 ISNULL(Convert(decimal(18,2),s.SettingValue),0) from SettingMaster s where s.SettingParameter='TruckBufferWeight' ) as TruckBufferWeight,
	(select top 1 ISNULL(Convert(decimal(18,2),s.SettingValue),0) from SettingMaster s where s.SettingParameter='PalettesWeight' ) as PalettesWeight,
	tmp.TruckSize,
	isnull(i.ItemId,0)as ItemId,
	tmp.ItemCode,
	i.ItemName,
	i.ItemShortCode,
	tmp.Quantity ,
	l.LookUpId as UOM,
	 isnull((select top 1 ul.[ConversionFactor] from UnitOfMeasure ul where ul.UOM= i.PrimaryUnitOfMeasure and ul.RelatedUOM=17 and ul.ItemId= i.ItemId),0) as QtyPerLayer,
	l.Name as UnitOfMeasureName,
	
	tmp.IsConsumed,
	tmp.IsActive,
	tmp.CreatedBy,
	tmp.UpdatedBy,
	tmp.IPAddress,
	tmp.Description1,
	tmp.Description2,
	tmp.Province,
	'' as Remark,
	 isnull((SELECT [dbo].[fn_GetCurrentDepositOfItem] (I.ItemId,com.CompanyId)),0)as ItemDeposit,
	'0' as ExtraNumberOfPalletes,
	'0' as NoPalettesRequired,
	'0' as IsItemLayer,
	 '0' as AllocatedExcited ,
	 '0' as AllocationQuantity,
	 '0' as IsValidItem,
	 tmp.SequenceNumber

	 ,(SELECT [dbo].[fn_GetPriceOfItem] (I.[ItemId],(select CompanyId from Company where CompanyMnemonic =tmp.[ShipToCode]))) as Amount
   , tmp.Promotion
   
    from 
	 #tmpGratisOrderList tmp
		left join TruckSize t on t.TruckSize=tmp.TruckSize  and t.IsActive=1
		left join Item i on i.ItemCode=tmp.ItemCode and i.IsActive=1
		left join Location d on d.LocationCode=tmp.[ShipToCode] and d.IsActive=1 and d.LocationType=27 --distributer or ship to
		left join Company com on com.CompanyId=d.CompanyID and com.IsActive=1 --Sold to
	    left join [LookUp] l on l.Code=tmp.[UnitOfMeasure] and l.IsActive=1
		left join UnitOfMeasure umo on I.ItemId=umo.ItemId  and umo.UOM=I.PrimaryUnitOfMeasure  and  I.IsActive =1 
		and I.PrimaryUnitOfMeasure=Convert(nvarchar(20),umo.UOM) 
		
		and umo.RelatedUOM=16 
	
		 order by tmp.SequenceNumber asc




	


    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
