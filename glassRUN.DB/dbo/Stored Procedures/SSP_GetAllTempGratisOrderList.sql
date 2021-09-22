CREATE PROCEDURE [dbo].[SSP_GetAllTempGratisOrderList] --'<Json><GratisOrderList><ItemCode>65105011</ItemCode><ItemDesc>HNK</ItemDesc><UnitOfMeasure>carton</UnitOfMeasure><Quantity>3000</Quantity><PONumber>PO312312</PONumber><ShipToCode>40783</ShipToCode><TruckSize>H14</TruckSize><Column7 /><Column8 /><Column9 /><Column10 /><Column11 /><Column12 /><Column13 /><Column14 /><Column15 /><Column16 /><Column17 /><Column18 /><Column19 /><Column20 /><Column21 /><Column22 /><Column23 /><Column24 /><Column25 /><Column26 /><Column27 /><Column28 /><Column29 /><Column30 /><Column31 /><Column32 /><Column33 /><Column34 /><Column35 /><Column36 /><Column37 /><Column38 /><Column39 /><Column40 /><Column41 /><Column42 /><Column43 /><Column44 /><Column45 /><Column46 /><Column47 /><Column48 /><Column49 /><Column50 /><Column51 /><Column52 /><Column53 /><Column54 /><Column55 /><Column56 /><Column57 /><Column58 /><Column59 /><Column60 /><Column61 /><Column62 /><Column63 /><Column64 /><Column65 /><Column66 /><Column67 /><Column68 /><Column69 /><Column70 /><Column71 /><Column72 /><Column73 /><Column74 /><Column75 /><Column76 /><Column77 /><Column78 /><Column79 /><Column80 /><Column81 /><Column82 /><Column83 /><Column84 /><Column85 /><Column86 /><Column87 /><Column88 /><Column89 /><Column90 /><Column91 /><Column92 /><Column93 /><Column94 /><Column95 /><Column96 /><Column97 /><Column98 /><Column99 /><Column100 /><Column101 /><Column102 /><Column103 /><Column104 /><Column105 /><Column106 /><Column107 /><Column108 /><Column109 /><Column110 /><Column111 /><Column112 /><Column113 /><Column114 /><Column115 /><Column116 /><Column117 /><Column118 /><Column119 /><Column120 /><Column121 /><Column122 /><Column123 /><Column124 /><Column125 /><Column126 /><Column127 /><Column128 /><Column129 /><Column130 /><Column131 /><Column132 /><Column133 /><Column134 /><Column135 /><Column136 /><Column137 /><Column138 /><Column139 /><Column140 /><Column141 /><Column142 /><Column143 /><Column144 /><Column145 /><Column146 /><Column147 /><Column148 /><Column149 /><Column150 /><Column151 /><Column152 /><Column153 /><Column154 /><Column155 /><Column156 /><Column157 /><Column158 /><Column159 /><Column160 /><Column161 /><Column162 /><Column163 /><Column164 /><Column165 /><Column166 /><Column167 /><Column168 /><Column169 /><Column170 /><Column171 /><Column172 /><Column173 /><Column174 /><Column175 /><Column176 /><Column177 /><Column178 /><Column179 /><Column180 /><Column181 /><Column182 /><Column183 /><Column184 /><Column185 /><Column186 /><Column187 /><Column188 /><Column189 /><Column190 /><Column191 /><Column192 /><Column193 /><Column194 /><Column195 /><Column196 /><Column197 /><Column198 /><Column199 /><Column200 /><Column201 /><Column202 /><Column203 /><Column204 /><Column205 /><Column206 /><Column207 /><Column208 /><Column209 /><Column210 /><Column211 /><Column212 /><Column213 /><Column214 /><Column215 /><Column216 /><Column217 /><Column218 /><Column219 /><Column220 /><Column221 /><Column222 /><Column223 /><Column224 /><Column225 /><Column226 /><Column227 /><Column228 /><Column229 /><Column230 /><Column231 /><Column232 /><Column233 /><Column234 /><Column235 /><Column236 /><Column237 /><Column238 /><Column239 /><Column240 /><Column241 /><Column242 /><Column243 /><Column244 /><Column245 /><Column246 /><Column247 /><Column248 /><Column249 /><Column250 /><Column251 /><Column252 /><Column253 /><Column254 /><Column255 /><SequenceNumber>0</SequenceNumber></GratisOrderList><GratisOrderList><ItemCode /><ItemDesc /><UnitOfMeasure /><Quantity /><PONumber /><ShipToCode /><TruckSize /><Column7 /><Column8 /><Column9 /><Column10 /><Column11 /><Column12 /><Column13 /><Column14 /><Column15 /><Column16 /><Column17 /><Column18 /><Column19 /><Column20 /><Column21 /><Column22 /><Column23 /><Column24 /><Column25 /><Column26 /><Column27 /><Column28 /><Column29 /><Column30 /><Column31 /><Column32 /><Column33 /><Column34 /><Column35 /><Column36 /><Column37 /><Column38 /><Column39 /><Column40 /><Column41 /><Column42 /><Column43 /><Column44 /><Column45 /><Column46 /><Column47 /><Column48 /><Column49 /><Column50 /><Column51 /><Column52 /><Column53 /><Column54 /><Column55 /><Column56 /><Column57 /><Column58 /><Column59 /><Column60 /><Column61 /><Column62 /><Column63 /><Column64 /><Column65 /><Column66 /><Column67 /><Column68 /><Column69 /><Column70 /><Column71 /><Column72 /><Column73 /><Column74 /><Column75 /><Column76 /><Column77 /><Column78 /><Column79 /><Column80 /><Column81 /><Column82 /><Column83 /><Column84 /><Column85 /><Column86 /><Column87 /><Column88 /><Column89 /><Column90 /><Column91 /><Column92 /><Column93 /><Column94 /><Column95 /><Column96 /><Column97 /><Column98 /><Column99 /><Column100 /><Column101 /><Column102 /><Column103 /><Column104 /><Column105 /><Column106 /><Column107 /><Column108 /><Column109 /><Column110 /><Column111 /><Column112 /><Column113 /><Column114 /><Column115 /><Column116 /><Column117 /><Column118 /><Column119 /><Column120 /><Column121 /><Column122 /><Column123 /><Column124 /><Column125 /><Column126 /><Column127 /><Column128 /><Column129 /><Column130 /><Column131 /><Column132 /><Column133 /><Column134 /><Column135 /><Column136 /><Column137 /><Column138 /><Column139 /><Column140 /><Column141 /><Column142 /><Column143 /><Column144 /><Column145 /><Column146 /><Column147 /><Column148 /><Column149 /><Column150 /><Column151 /><Column152 /><Column153 /><Column154 /><Column155 /><Column156 /><Column157 /><Column158 /><Column159 /><Column160 /><Column161 /><Column162 /><Column163 /><Column164 /><Column165 /><Column166 /><Column167 /><Column168 /><Column169 /><Column170 /><Column171 /><Column172 /><Column173 /><Column174 /><Column175 /><Column176 /><Column177 /><Column178 /><Column179 /><Column180 /><Column181 /><Column182 /><Column183 /><Column184 /><Column185 /><Column186 /><Column187 /><Column188 /><Column189 /><Column190 /><Column191 /><Column192 /><Column193 /><Column194 /><Column195 /><Column196 /><Column197 /><Column198 /><Column199 /><Column200 /><Column201 /><Column202 /><Column203 /><Column204 /><Column205 /><Column206 /><Column207 /><Column208 /><Column209 /><Column210 /><Column211 /><Column212 /><Column213 /><Column214 /><Column215 /><Column216 /><Column217 /><Column218 /><Column219 /><Column220 /><Column221 /><Column222 /><Column223 /><Column224 /><Column225 /><Column226 /><Column227 /><Column228 /><Column229 /><Column230 /><Column231 /><Column232 /><Column233 /><Column234 /><Column235 /><Column236 /><Column237 /><Column238 /><Column239 /><Column240 /><Column241 /><Column242 /><Column243 /><Column244 /><Column245 /><Column246 /><Column247 /><Column248 /><Column249 /><Column250 /><Column251 /><Column252 /><Column253 /><Column254 /><Column255 /><SequenceNumber>1</SequenceNumber></GratisOrderList><GratisOrderList><ItemCode /><ItemDesc /><UnitOfMeasure /><Quantity /><PONumber /><ShipToCode /><TruckSize /><Column7 /><Column8 /><Column9 /><Column10 /><Column11 /><Column12 /><Column13 /><Column14 /><Column15 /><Column16 /><Column17 /><Column18 /><Column19 /><Column20 /><Column21 /><Column22 /><Column23 /><Column24 /><Column25 /><Column26 /><Column27 /><Column28 /><Column29 /><Column30 /><Column31 /><Column32 /><Column33 /><Column34 /><Column35 /><Column36 /><Column37 /><Column38 /><Column39 /><Column40 /><Column41 /><Column42 /><Column43 /><Column44 /><Column45 /><Column46 /><Column47 /><Column48 /><Column49 /><Column50 /><Column51 /><Column52 /><Column53 /><Column54 /><Column55 /><Column56 /><Column57 /><Column58 /><Column59 /><Column60 /><Column61 /><Column62 /><Column63 /><Column64 /><Column65 /><Column66 /><Column67 /><Column68 /><Column69 /><Column70 /><Column71 /><Column72 /><Column73 /><Column74 /><Column75 /><Column76 /><Column77 /><Column78 /><Column79 /><Column80 /><Column81 /><Column82 /><Column83 /><Column84 /><Column85 /><Column86 /><Column87 /><Column88 /><Column89 /><Column90 /><Column91 /><Column92 /><Column93 /><Column94 /><Column95 /><Column96 /><Column97 /><Column98 /><Column99 /><Column100 /><Column101 /><Column102 /><Column103 /><Column104 /><Column105 /><Column106 /><Column107 /><Column108 /><Column109 /><Column110 /><Column111 /><Column112 /><Column113 /><Column114 /><Column115 /><Column116 /><Column117 /><Column118 /><Column119 /><Column120 /><Column121 /><Column122 /><Column123 /><Column124 /><Column125 /><Column126 /><Column127 /><Column128 /><Column129 /><Column130 /><Column131 /><Column132 /><Column133 /><Column134 /><Column135 /><Column136 /><Column137 /><Column138 /><Column139 /><Column140 /><Column141 /><Column142 /><Column143 /><Column144 /><Column145 /><Column146 /><Column147 /><Column148 /><Column149 /><Column150 /><Column151 /><Column152 /><Column153 /><Column154 /><Column155 /><Column156 /><Column157 /><Column158 /><Column159 /><Column160 /><Column161 /><Column162 /><Column163 /><Column164 /><Column165 /><Column166 /><Column167 /><Column168 /><Column169 /><Column170 /><Column171 /><Column172 /><Column173 /><Column174 /><Column175 /><Column176 /><Column177 /><Column178 /><Column179 /><Column180 /><Column181 /><Column182 /><Column183 /><Column184 /><Column185 /><Column186 /><Column187 /><Column188 /><Column189 /><Column190 /><Column191 /><Column192 /><Column193 /><Column194 /><Column195 /><Column196 /><Column197 /><Column198 /><Column199 /><Column200 /><Column201 /><Column202 /><Column203 /><Column204 /><Column205 /><Column206 /><Column207 /><Column208 /><Column209 /><Column210 /><Column211 /><Column212 /><Column213 /><Column214 /><Column215 /><Column216 /><Column217 /><Column218 /><Column219 /><Column220 /><Column221 /><Column222 /><Column223 /><Column224 /><Column225 /><Column226 /><Column227 /><Column228 /><Column229 /><Column230 /><Column231 /><Column232 /><Column233 /><Column234 /><Column235 /><Column236 /><Column237 /><Column238 /><Column239 /><Column240 /><Column241 /><Column242 /><Column243 /><Column244 /><Column245 /><Column246 /><Column247 /><Column248 /><Column249 /><Column250 /><Column251 /><Column252 /><Column253 /><Column254 /><Column255 /><SequenceNumber>2</SequenceNumber></GratisOrderList><GratisOrderList><ItemCode /><ItemDesc /><UnitOfMeasure /><Quantity /><PONumber /><ShipToCode /><TruckSize /><Column7 /><Column8 /><Column9 /><Column10 /><Column11 /><Column12 /><Column13 /><Column14 /><Column15 /><Column16 /><Column17 /><Column18 /><Column19 /><Column20 /><Column21 /><Column22 /><Column23 /><Column24 /><Column25 /><Column26 /><Column27 /><Column28 /><Column29 /><Column30 /><Column31 /><Column32 /><Column33 /><Column34 /><Column35 /><Column36 /><Column37 /><Column38 /><Column39 /><Column40 /><Column41 /><Column42 /><Column43 /><Column44 /><Column45 /><Column46 /><Column47 /><Column48 /><Column49 /><Column50 /><Column51 /><Column52 /><Column53 /><Column54 /><Column55 /><Column56 /><Column57 /><Column58 /><Column59 /><Column60 /><Column61 /><Column62 /><Column63 /><Column64 /><Column65 /><Column66 /><Column67 /><Column68 /><Column69 /><Column70 /><Column71 /><Column72 /><Column73 /><Column74 /><Column75 /><Column76 /><Column77 /><Column78 /><Column79 /><Column80 /><Column81 /><Column82 /><Column83 /><Column84 /><Column85 /><Column86 /><Column87 /><Column88 /><Column89 /><Column90 /><Column91 /><Column92 /><Column93 /><Column94 /><Column95 /><Column96 /><Column97 /><Column98 /><Column99 /><Column100 /><Column101 /><Column102 /><Column103 /><Column104 /><Column105 /><Column106 /><Column107 /><Column108 /><Column109 /><Column110 /><Column111 /><Column112 /><Column113 /><Column114 /><Column115 /><Column116 /><Column117 /><Column118 /><Column119 /><Column120 /><Column121 /><Column122 /><Column123 /><Column124 /><Column125 /><Column126 /><Column127 /><Column128 /><Column129 /><Column130 /><Column131 /><Column132 /><Column133 /><Column134 /><Column135 /><Column136 /><Column137 /><Column138 /><Column139 /><Column140 /><Column141 /><Column142 /><Column143 /><Column144 /><Column145 /><Column146 /><Column147 /><Column148 /><Column149 /><Column150 /><Column151 /><Column152 /><Column153 /><Column154 /><Column155 /><Column156 /><Column157 /><Column158 /><Column159 /><Column160 /><Column161 /><Column162 /><Column163 /><Column164 /><Column165 /><Column166 /><Column167 /><Column168 /><Column169 /><Column170 /><Column171 /><Column172 /><Column173 /><Column174 /><Column175 /><Column176 /><Column177 /><Column178 /><Column179 /><Column180 /><Column181 /><Column182 /><Column183 /><Column184 /><Column185 /><Column186 /><Column187 /><Column188 /><Column189 /><Column190 /><Column191 /><Column192 /><Column193 /><Column194 /><Column195 /><Column196 /><Column197 /><Column198 /><Column199 /><Column200 /><Column201 /><Column202 /><Column203 /><Column204 /><Column205 /><Column206 /><Column207 /><Column208 /><Column209 /><Column210 /><Column211 /><Column212 /><Column213 /><Column214 /><Column215 /><Column216 /><Column217 /><Column218 /><Column219 /><Column220 /><Column221 /><Column222 /><Column223 /><Column224 /><Column225 /><Column226 /><Column227 /><Column228 /><Column229 /><Column230 /><Column231 /><Column232 /><Column233 /><Column234 /><Column235 /><Column236 /><Column237 /><Column238 /><Column239 /><Column240 /><Column241 /><Column242 /><Column243 /><Column244 /><Column245 /><Column246 /><Column247 /><Column248 /><Column249 /><Column250 /><Column251 /><Column252 /><Column253 /><Column254 /><Column255 /><SequenceNumber>3</SequenceNumber></GratisOrderList></Json>'
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
    FROM OPENXML(@intpointer,'Json/GratisOrderList',2)
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
			[SequenceNumber]	bigint
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
	(select CompanyId from Location where LocationCode =tmp.[ShipToCode]) as CompanyId,
	(select CompanyName from Company where CompanyId in (select CompanyId from Location where LocationCode =tmp.[ShipToCode])) as CustomerName,	
	(select CompanyMnemonic from Company where CompanyId in (select CompanyId from Location where LocationCode =tmp.[ShipToCode])) as CompanyMnemonic,
	isnull(t.TruckSizeId,0) as TruckSizeId,
	d.Area,

t.TruckCapacityWeight,
t.TruckCapacityPalettes,

	
	(select top 1 ISNULL(Convert(decimal(18,2),s.SettingValue),0) from SettingMaster s where s.SettingParameter='TruckBufferWeight' ) as TruckBufferWeight,
	(select top 1 ISNULL(Convert(decimal(18,2),s.SettingValue),0) from SettingMaster s where s.SettingParameter='PalettesWeight' ) as PalettesWeight,
	tmp.TruckSize,
	isnull(i.ItemId,0)as ItemId,
	tmp.ItemCode,
	i.ItemName,
	i.ItemShortCode,
	(case when tmp.Quantity is null or ltrim(RTRIM(tmp.Quantity))  =''  then 0 else tmp.Quantity end) as Quantity ,
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
	'0' as ItemDeposit,
	'0' as ExtraNumberOfPalletes,
	'0' as NoPalettesRequired,
	'0' as IsItemLayer,
	 '0' as AllocatedExcited ,
	 '0' as AllocationQuantity,
	 tmp.SequenceNumber

	 ,(SELECT [dbo].[fn_GetPriceOfItem] (I.[ItemId],(select CompanyId from Company where CompanyMnemonic =tmp.[ShipToCode]))) as Amount
    from 
	 #tmpGratisOrderList tmp
		left join TruckSize t on t.TruckSize=tmp.TruckSize  and t.IsActive=1
		left join Item i on i.ItemCode=tmp.ItemCode and i.IsActive=1
		left join Location d on d.LocationCode=tmp.[ShipToCode] and d.IsActive=1 and d.LocationType=27 --distributer or ship to
		left join Company com on com.CompanyMnemonic=tmp.[SoldToCode] and com.IsActive=1 --Sold to
	    left join [LookUp] l on l.Code=tmp.[UnitOfMeasure] and l.IsActive=1
		left join UnitOfMeasure umo on I.ItemId=umo.ItemId  and umo.UOM=I.PrimaryUnitOfMeasure  and  I.IsActive =1 
		and I.PrimaryUnitOfMeasure=Convert(nvarchar(20),umo.UOM) 
		
		and umo.RelatedUOM=16 
		 where tmp.[OrderGroupCode]  !=''
		 order by tmp.SequenceNumber asc




	


    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END