
CREATE PROCEDURE [dbo].[SSP_DPAllData] --'<Json><ServicesAction>LoadDPAllData</ServicesAction><LoginId>10536</LoginId><UserId>10536</UserId><RoleMasterId>8</RoleMasterId><AppVersion></AppVersion><SupplierLOBId>0</SupplierLOBId><SettingVersion>0</SettingVersion><AttributeVersion>0</AttributeVersion></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

DECLARE @UserId BIGINT
DECLARE @SupplierLOBId BIGINT
DECLARE @AppVersion NVARCHAR(50)
DECLARE @SettingVersion NVARCHAR(50)
DECLARE @AttributeVersion NVARCHAR(50)


SELECT @UserId = tmp.[UserId],
		@SupplierLOBId = tmp.[SupplierLOBId],
		@AppVersion = tmp.[AppVersion],
		@SettingVersion = tmp.[SettingVersion],
	  @AttributeVersion = tmp.[AttributeVersion]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
		UserId BIGINT,
		SupplierLOBId BIGINT,
		AppVersion NVARCHAR(50),
		SettingVersion NVARCHAR(50),
		AttributeVersion NVARCHAR(50)
			)tmp;



DECLARE @dyanamicQuery nvarchar(max)=''
DECLARE @main nvarchar(max)=''
DECLARE @main1 nvarchar(max)=''
DECLARE @main2 nvarchar(max)=''

DECLARE @marineLOBDeliveryLocationOutput nvarchar(max)=''
Declare @OrderWorkflowJson nvarchar(max) = ''
DECLARE @unitOfMeasureOutput nvarchar(max)=''
DECLARE @orderMovementOutput nvarchar(max)=''
DECLARE @LoseAssetsInRunList nvarchar(max)=''
DECLARE @orderListOutput nvarchar(max)=''
DECLARE @orderProductListOutput nvarchar(max)=''
DECLARE @orderDocumentListOutput nvarchar(max)=''
DECLARE @orderStateConfirmationListOutput nvarchar(max)=''
DECLARE @orderProductMovementListOutput nvarchar(max)=''
--DECLARE @orderCompartmentListOutput nvarchar(max)=''
DECLARE @OrderProductMovementAttributeOutput nvarchar(max)=''

DECLARE @TankListOutput nvarchar(max)=''
DECLARE @SettingMasterListOutput nvarchar(max)=''
DECLARE @orderProductMovementAttributeConfigurationListOutput nvarchar(max)=''
DECLARE @appFormsListOutput nvarchar(max)=''
DECLARE @userAccessListOutput nvarchar(max)=''

--DECLARE @OrderProductSubLocationListOutput nvarchar(max)=''
DECLARE @pdcInformationListOutput nvarchar(max)=''

DECLARE @pdcAttributeValueListOutput nvarchar(max)=''

--DECLARE @ActivityLogEventOutput nvarchar(max)=''


--DECLARE @SirfCategoryMasterOutput nvarchar(max)=''

DECLARE @OrderLogisticsOutput nvarchar(max)=''

DECLARE @EventForm nvarchar(max)=''

DECLARE @EventRule nvarchar(max)=''

DECLARE @EventConfiguration nvarchar(max)=''


DECLARE @ProcessConfigurationOutput nvarchar(max)=''
DECLARE @SafeappFormsListOutput nvarchar(max)=''


Declare @Resources nvarchar(max)= ''

Declare @ItemOutput nvarchar(max)= ''

Declare @WorkFlowForApp nvarchar(max)= ''
Declare @WorkFlowActivity nvarchar(max)= ''

Declare @TemplateForms nvarchar(max)= ''

Declare @Checklist nvarchar(max)= ''

Declare @RemoveCollection nvarchar(max)= '1=1 and'
---om1.LocationType != 1 and
DECLARE @OrderLorryReceiptOutput nvarchar(max)=''
DECLARE @CurrentStatusCodeForDeliveryApp nvarchar(max)='525' ---Ship

Select @CurrentStatusCodeForDeliveryApp=SettingValue from SettingMaster where SettingParameter='CurrentStatusCodeForDeliveryApp'

set  @SupplierLOBId =3



--------------------Start-MarineLOBDeliveryLocation---------------------------

SET @dyanamicQuery = 'o.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +''')) and o.ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND GroupName in (select GroupName From OrderMovement where ActualTimeOfAction is  null))'

EXEC  [dbo].[SSP_MarineLOBDeliveryLocationList_SelectByCriteria] @dyanamicQuery,'',@marineLOBDeliveryLocationOutput OUTPUT


--------------------End-MarineLOBDeliveryLocation---------------------------


--------------------Start-OrderMovement---------------------------

SET @dyanamicQuery = 'om.OrderMovementId IN (SELECT om1.OrderMovementId FROM ORDERMOVEMENT om1 WHERE '+@RemoveCollection+' om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderMovementList_SelectByCriteria] @dyanamicQuery,'',@orderMovementOutput OUTPUT


--------------------End-OrderMovement---------------------------

--------------------Start-LoseAssetsInRun---------------------------

SET @dyanamicQuery = 'lr.PlanNumber IN (SELECT PlanNumber FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND ActualTimeOfAction is  null)  '

EXEC  [dbo].[SSP_LoseAssetsInRunList_SelectByCriteria] @dyanamicQuery,'',@LoseAssetsInRunList OUTPUT


--------------------End-LoseAssetsInRun---------------------------


 --------------------Start-Order---------------------------

SET @dyanamicQuery = 'o.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +''')) and o.ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND GroupName in (select GroupName From OrderMovement where ActualTimeOfAction is  null))'

EXEC  [dbo].[SSP_OrderList_SelectByCriteria] @dyanamicQuery,'',@orderListOutput OUTPUT


--------------------End-Order---------------------------


 --------------------Start-OrderPrdouct---------------------------

SET @dyanamicQuery = 'op.ORDERID IN (SELECT om1.ORDERID FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderProductList_SelectByCriteria] @dyanamicQuery,'',@orderProductListOutput OUTPUT


--------------------End-OrderPrdouct---------------------------


--------------------Start-Orderdocument---------------------------

SET @dyanamicQuery = 'od.ORDERID IN (SELECT om1.ORDERID FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction IS  NULL AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +''')))) and DocumentTypeId not in (81,82,83,84,85,86,87,88,60,14,15,337,338,339)'

EXEC  [dbo].[SSP_OrderDocumentList_SelectByCriteria] @dyanamicQuery,'',@orderDocumentListOutput OUTPUT

--------------------End-Orderdocument---------------------------


--------------------Start-OrderStateConfirmation---------------------------


SET @dyanamicQuery = 'OS.OrderMovementId IN (SELECT om1.OrderMovementId FROM ORDERMOVEMENT om1 WHERE '+@RemoveCollection+' om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderStateConfirmationList_SelectByCriteria] @dyanamicQuery,'',@orderStateConfirmationListOutput OUTPUT

--------------------End-OrderStateConfirmation---------------------------


--------------------Start-OrderProductMovement---------------------------


SET @dyanamicQuery = 'opm.OrderMovementId IN (SELECT om1.OrderMovementId FROM ORDERMOVEMENT om1 WHERE '+@RemoveCollection+' om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderProductMovementList_SelectByCriteria] @dyanamicQuery,'',@orderProductMovementListOutput OUTPUT

--------------------End-OrderProductMovement---------------------------


----------------------Start-OrderCompartment---------------------------

--SET @dyanamicQuery = 'oc.OrderMovementId IN (SELECT OrderMovementId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND ActualTimeOfAction IS  NULL)'

--EXEC  [dbo].[SSP_OrderCompartmentList_SelectByCriteria] @dyanamicQuery,'',@orderCompartmentListOutput OUTPUT



----------------------End-OrderCompartment---------------------------


----------------------Start-OrderProductMovementAttribute---------------------------

SET @dyanamicQuery = 'opma.OrderId IN (SELECT om1.OrderId FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderProductMovementAttributeList_SelectByCriteria] @dyanamicQuery,'',@OrderProductMovementAttributeOutput OUTPUT


----------------------End-OrderproductMovementAttribute---------------------------




--------------------Start-SettingMaster---------------------------

IF(@SettingVersion ='')
begin

SET @dyanamicQuery = ''
END
ELSE
begin 
SET @dyanamicQuery = ' Version <> '''+@SettingVersion +''''
end

SET @dyanamicQuery = ''

EXEC  [dbo].[SSP_SettingMasterList_SelectByCriteria] @dyanamicQuery,'',@SettingMasterListOutput OUTPUT


--------------------End-SettingMaster---------------------------


--------------------Start-OrderProductMovementAttributeConfiguration---------------------------

IF(@AttributeVersion ='')
begin

SET @dyanamicQuery = 'SupplierLOBId = '+ CONVERT(NVARCHAR(200),@SupplierLOBId) 
END
ELSE
begin 
SET @dyanamicQuery = 'SupplierLOBId = '+ CONVERT(NVARCHAR(200),@SupplierLOBId) +' AND  Version <> '''+ @AttributeVersion +''''
end

EXEC  [dbo].[SSP_OrderProductMovementAttributeConfigurationList_SelectByCriteria] @dyanamicQuery,'',@orderProductMovementAttributeConfigurationListOutput OUTPUT


--------------------End-OrderProductMovementAttributeConfiguration---------------------------



--------------------Start-AppForms---------------------------

--IF(@AppVersion ='')
--begin

--SET @dyanamicQuery = ' roleMasterid  IN (SELECT RoleMasterId FROM  dbo.login WHERE LoginId='+ CONVERT(NVARCHAR(200),@userId) +')  and apptype = 8'
--END
--ELSE
--begin 
--SET @dyanamicQuery = '  Version <> '''+ @AppVersion +''' AND roleMasterid  IN (SELECT RoleMasterId FROM  dbo.login WHERE LoginId='+ CONVERT(NVARCHAR(200),@userId) +') and apptype = 8'
--end

--EXEC  [dbo].[SSP_AppFormsList_SelectByCriteria] @dyanamicQuery,'',@appFormsListOutput OUTPUT




--------------------End-AppForms---------------------------


--------------------Start-UserAccess---------------------------

SET @dyanamicQuery = 'l.RoleMasterId not in (1 , 2 ,3 ,7)'

EXEC  [dbo].[SSP_UserAccessList_SelectByCriteria] @dyanamicQuery,'',@userAccessListOutput OUTPUT

--------------------End-UserAccess---------------------------




----------------------Start-OrderProductSubLocation---------------------------

--SET @dyanamicQuery = 'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] ='+ CONVERT(NVARCHAR(200),@userId) +' AND ActualTimeOfAction IS  NULL)'

--EXEC  [dbo].[SSP_OrderProductSubLocationList_SelectByCriteria] @dyanamicQuery,'',@OrderProductSubLocationListOutput OUTPUT

----------------------End-OrderProductSubLocation---------------------------






--------------------Start-PdcInformation---------------------------

SET @dyanamicQuery = 'ORDERID IN (SELECT om1.ORDERID FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@userId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_PdcInformationList_SelectByCriteria] @dyanamicQuery,'',@pdcInformationListOutput OUTPUT

--------------------End-PdcInformation---------------------------


--------------------Start-PdcAttributeValue---------------------------

SET @dyanamicQuery = 'PdcInformationId IN (SELECT PdcInformationId FROM  dbo.PdcInformation WHERE  ORDERID IN (SELECT om1.ORDERID FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@userId) +' AND om1.ActualTimeOfAction IS  NULL AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +''')))))'

EXEC  [dbo].[SSP_PdcAttributeValueList_SelectByCriteria] @dyanamicQuery,'',@pdcAttributeValueListOutput OUTPUT

--------------------End-PdcAttributeValue---------------------------


----------------------Start-ActivityLogEvent---------------------------

--SET @dyanamicQuery = 'IsApp = 1'

--EXEC  [dbo].[SSP_ActivityLogEventList_SelectByCriteria] @dyanamicQuery,'',@ActivityLogEventOutput OUTPUT

----------------------End-ActivityLogEvent---------------------------

----------------------Start-SirfCategoryMaster---------------------------

--SET @dyanamicQuery = ''

--EXEC  [dbo].[SSP_SirfCategoryMasterList_SelectByCriteria] @dyanamicQuery,'',@SirfCategoryMasterOutput OUTPUT

----------------------End-SirfCategoryMaster---------------------------



--------------------Start-OrderLogistics---------------------------

SET @dyanamicQuery = 'om.OrderMovementId IN (SELECT om1.OrderMovementId FROM ORDERMOVEMENT om1 WHERE '+@RemoveCollection+' om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderLogisticsList_SelectByCriteria] @dyanamicQuery,'',@OrderLogisticsOutput OUTPUT

--------------------End-OrderLogistics---------------------------





--------------------Start-EventForm---------------------------

SET @dyanamicQuery = 'SupplierLOBId = '+ CONVERT(NVARCHAR(200),@SupplierLOBId)

EXEC  [dbo].[SSP_EventFormList_SelectByCriteria] @dyanamicQuery,'',@EventForm OUTPUT


--------------------End-EventForm---------------------------




--------------------Start-EventRule---------------------------

SET @dyanamicQuery = 'SupplierLOBId = '+ CONVERT(NVARCHAR(200),@SupplierLOBId)

EXEC  [dbo].[SSP_EventRuleList_SelectByCriteria] @dyanamicQuery,'',@EventRule OUTPUT

--------------------End-EventRule---------------------------




--------------------Start-EventRule---------------------------

SET @dyanamicQuery = 'SupplierLOBId = '+ CONVERT(NVARCHAR(200),@SupplierLOBId) + 'AND TransportOperatorID IN ( select ReferenceId from Profile where ProfileId in (  select  ProfileId  From Login where LoginId = '+ CONVERT(NVARCHAR(200),@UserId) +'))'

EXEC  [dbo].[SSP_EventConfigurationList_SelectByCriteria] @dyanamicQuery,'',@EventConfiguration OUTPUT

--------------------End-EventRule---------------------------






--------------------Start-EventForm---------------------------

SET @dyanamicQuery = 'SupplierLOBId = '+ CONVERT(NVARCHAR(200),@SupplierLOBId)

EXEC  [dbo].[SSP_ProcessConfigurationList_SelectByCriteria] @dyanamicQuery,'',@ProcessConfigurationOutput OUTPUT

--------------------End-EventForm---------------------------



--------------------Start-AppForms---------------------------

IF(@AppVersion ='')
begin

SET @dyanamicQuery = '  roleMasterid  IN (SELECT RoleMasterId FROM  dbo.login WHERE LoginId='+ CONVERT(NVARCHAR(200),@userId) +') and apptype =6'
END
ELSE
begin 
SET @dyanamicQuery = ' Version <> '''+ @AppVersion +''' AND roleMasterid  IN (SELECT RoleMasterId FROM  dbo.login WHERE LoginId='+ CONVERT(NVARCHAR(200),@userId) +') and apptype = 6'
end

EXEC  [dbo].[SSP_SafeAppFormsList_SelectByCriteria] @dyanamicQuery,'',@SafeappFormsListOutput OUTPUT


SET @dyanamicQuery = 'ISAPP = 1'

EXEC  [dbo].[SSP_ResourceData] @dyanamicQuery,'',@Resources OUTPUT



SET @dyanamicQuery = 'IsActive = 1'

EXEC  [dbo].[SSP_UnitOfMeasure] @dyanamicQuery,'',@unitOfMeasureOutput OUTPUT


SET @dyanamicQuery = 'IsActive = 1'

EXEC  [dbo].[SSP_ItemList_SelectByCrireria] @dyanamicQuery,'',@ItemOutput OUTPUT


--------------------End-AppForms---------------------------

---------------------WorkFlow---------------------------------

EXEC  [dbo].[SSP_GetAllWorkFlowForApp] @WorkFlowForApp OUTPUT

EXEC  [dbo].[SSP_GetAppWorkFlowActivity] @WorkFlowActivity OUTPUT

EXEC  [dbo].[SSP_GetTemplateForms] @TemplateForms OUTPUT


SET @dyanamicQuery = 'ORDERID IN (SELECT om1.ORDERID FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

Exec [dbo].[SSP_GetOrderWorkflowJson]  @dyanamicQuery,'',@OrderWorkflowJson OUTPUT

---------------------EndWorkFlow------------------------------
---------------------Checklist--------------------------------
EXEC  [dbo].[SSP_GetAllChecklist] @Checklist OUTPUT
--------------------------------------------------------------




----------------------Start-OrderProductMovementAttribute---------------------------

SET @dyanamicQuery = 'OrderId IN (SELECT om1.OrderId FROM ORDERMOVEMENT om1 WHERE om1.[DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),@UserId) +' AND om1.ActualTimeOfAction is  null AND om1.OrderId in (select o1.OrderId From [Order] o1 where o1.CurrentState IN (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] ('''+CONVERT(NVARCHAR(500), @CurrentStatusCodeForDeliveryApp)  +'''))))  '

EXEC  [dbo].[SSP_OrderLorryReceiptList_SelectByCriteria] @dyanamicQuery,'',@OrderLorryReceiptOutput OUTPUT


----------------------End-OrderproductMovementAttribute---------------------------





--------------------- Start --main query execution---------------------------

 SET @main=';WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) select cast ((SELECT  ''true'' AS [@json:Array]  ,1 as data ,'+
 @marineLOBDeliveryLocationOutput+','+
 @orderMovementOutput+','+
 @LoseAssetsInRunList+','+
 @orderListOutput+','+
 @orderProductListOutput +','+
 @orderDocumentListOutput +','+
  --@orderStateConfirmationListOutput+','+
 @orderProductMovementListOutput+','+
@OrderProductMovementAttributeOutput +',' +
@SettingMasterListOutput+',' +
 --@orderProductMovementAttributeConfigurationListOutput+','+
--@appFormsListOutput+','+
@userAccessListOutput +',' +
@pdcInformationListOutput +','+
@pdcAttributeValueListOutput +','+
@EventForm +','+ 
@EventRule  +','+
@EventConfiguration  +','+
--@ProcessConfigurationOutput +','+
@OrderLogisticsOutput +','+
@SafeappFormsListOutput +  ','+
@Resources + ',' + 
@unitOfMeasureOutput + ',' +
@WorkFlowForApp +','+
@WorkFlowActivity +','+
@OrderWorkflowJson + ',' +
@TemplateForms + ','+
@Checklist+','+
@ItemOutput +','+
@OrderLorryReceiptOutput+
   ' FOR XML PATH(''Json''),ELEMENTS)AS XML)'

   
print 'glassrun'
--Print @WorkFlowForApp
--Print @WorkFlowActivity
--Print @marineLOBDeliveryLocationOutput
--Print @orderMovementOutput
--Print @LoseAssetsInRunList
--Print @orderListOutput
--Print @orderProductListOutput 
--Print @orderDocumentListOutput 
----Print @orderStateConfirmationListOutput    --Error  --notrequired
--Print @orderProductMovementListOutput
--Print @OrderProductMovementAttributeOutput 
--Print @SettingMasterListOutput
----Print @orderProductMovementAttributeConfigurationListOutput  --Error  --notrequired
--Print @appFormsListOutput
--Print @userAccessListOutput 
--Print @pdcInformationListOutput 
--Print @pdcAttributeValueListOutput 
--Print @EventForm  
--Print @EventRule  
--Print @EventConfiguration  
----Print @ProcessConfigurationOutput    --Error  --notrequired
--Print @OrderLogisticsOutput 
--Print @SafeappFormsListOutput 
--Print @Resources
--Print @unitOfMeasureOutput
--Print @ItemOutput 




 PRINT @main

 EXEC sp_executesql @main
 --Exec(@main1+@main2)

 --------------------- End --main query execution---------------------------

END
