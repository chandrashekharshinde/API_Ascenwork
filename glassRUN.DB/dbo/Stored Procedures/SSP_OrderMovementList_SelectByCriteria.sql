

CREATE PROCEDURE [dbo].[SSP_OrderMovementList_SelectByCriteria] --'OrderMovementId IN (SELECT OrderMovementId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 117 AND ActualTimeOfAction IS  NULL) and om.OrderId in (select OrderId from [order] where IsCancelled !=1)	','',gg
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' OrderMovementId',
@Output nvarchar(max) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderMovementId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  ,
 om. [OrderMovementId] as IntOrderMovementId
      ,om.[OrderId] as IntOrderId
	   ,om. [OrderMovementId]
      ,om.[OrderId]
	   ,(select od.OrderNumber from [Order] od where od.OrderId=om.[OrderId]) as VcOrderNumber
	    ,(select od.OrderNumber from [Order] od where od.OrderId=om.[OrderId]) as OrderNumber
      ,om.[TransportOperatorId]
      ,om.[DeliveryPersonnelId]
      ,om.[Location] as IntDeliveryLocationId
	   ,om.[Location]
      ,om.[LocationType]
	  ,case when om.LocationType=1 then 21 else 27 end as  VcLocationType
	  ,(select case when om.LocationType=1 then ''Pick Up'' else ''Delivery'' end ) as LocationTypeValue 
      ,om.[Action] as VcAction
	   ,om.[Action]
      ,om.[State]
	  ,om.[StartTime]
	        ,om.[ExpectedTimeOfAction]
      ,om.[ActualTimeOfAction]
      ,om.[Latitude]
	   ,om.[Longitude]
	    ,om.[GroupName]
      ,om.[ExpectedTimeOfAction] as DtExpectedTimeOfAction
      ,isnull(om.[ActualTimeOfAction],''1900'') as DtActualTimeOfAction
      ,om.[Latitude] as VcLatitude
	   ,om.[Longitude] as VcLongitude
	    ,om.[GroupName] as VcGroupName
		,ISNULL(om.[PlanNumber],'''') as PlanNumber
		 ,om.[IsActive]
      ,om.[CreatedBy]
      ,om.[CreatedDate]
      ,om.[UpdateBy]
      ,om.[UpdatedDate]
	  ,(select top 1 ol.TruckPlateNumber from OrderLogistics ol where ol.OrderMovementId=om. [OrderMovementId]) as TruckPlateNumber
	  ,(select top 1 l.Name from [Login] l where l.LoginId=om.[DeliveryPersonnelId]) as [DeliveryPersonnelName]
	  ,ISNULL((select top 1 l.LicenseNumber from [Login] l where l.LoginId=om.[DeliveryPersonnelId]),'''') as [LicenseNumber]
	  ,(select top 1 l.Name from [Login] l where l.LoginId=om.[TransportOperatorId]) as [CarrierName]
	  ,(select top 1  ISNULL(p.Contacts,'''') from [Login] l join [ContactInformation] p on l.ProfileId=p.ObjectId and p.ContactType=''MobileNo'' and p.ObjectType=''User'' where l.LoginId=om.[DeliveryPersonnelId]) as [DeliveryConactNumber]
	   ,NULL as LocationStatusValue  
 ,(select LocationName From Location where LocationId=om.Location) AS  LocationAddress
 ,(SELECT Stuff( Coalesce('' '' + NULLIF(AddressLine1, ''''), '''') + Coalesce('', '' + NULLIF(AddressLine2, ''''), '''') + Coalesce('', '' + NULLIF(AddressLine3, ''''), '''') + Coalesce(''-'' + NULLIF(Pincode, ''''), '''') , 1, 1, '''') AS [Address] from Location where  LocationId = om.Location) as OrderLocationName 
 --,(select ISNULL(AddressLine1,'''') + ISNULL(AddressLine2,'''') + ISNULL(AddressLine3,'''')  from Location where LocationId = om.Location) as OrderLocationName
 FROM [ORDERMOVEMENT] om
 WHERE   IsActive = 1 and ' + @WhereExpression + '
 ORDER BY om.ExpectedTimeOfAction 
 FOR XML PATH(''OrderMovementInfos''),ELEMENTS)AS XML))'
 


 SET @Output=@sql

 PRINT @Output

 PRINT 'Executed SSP_OrderMovementList_SelectByCriteria'