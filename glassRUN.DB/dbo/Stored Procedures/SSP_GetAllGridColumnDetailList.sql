
CREATE PROCEDURE [dbo].[SSP_GetAllGridColumnDetailList] --'<Json><ServicesAction>LoadGridConfiguration</ServicesAction><RoleId>3</RoleId><UserId>8</UserId><PageName>Approve Enquiries</PageName><ControllerName>SalesAdminApproval</ControllerName></Json>'

AS
 BEGIN 



 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select Cast((select  'true' AS [@json:Array]  ,
 GC.GridColumnId,
 GC.ObjectId,
 GC.PropertyName,
 ISNULL(res.ResourceValue,GC.PropertyName) as ResourceValue,
 GC.ResourceKey,
 ISNULL(GCC.RoleId,'0') as RoleId,
 ISNULL(GCC.LoginId,'0') as LoginId,
  ISNULL(p.PageName,'') as PageName,
 ISNULL(p.ControllerName,'') as ControllerName,
 GCC.ResourceId,
 GCC.PageId,
 ISNULL(GCC.IsPinned,'0') as IsPinned,
 ISNULL(GCC.IsExportAvailable,'0') as IsExportAvailable,
 ISNULL(GCC.IsAvailable,'0') as IsAvailable,
 ISNULL(GCC.IsMandatory,'0') as IsMandatory,
 ISNULL(GCC.IsDefault,'0') as IsDefault,
 ISNULL(GCC.IsSystemMandatory,'0') as IsSystemMandatory,
 ISNULL(GCC.SequenceNumber,'0') as SequenceNumber,
 ISNULL(GCC.IsDetailsViewAvailable,'0') as IsDetailsViewAvailable,
 ISNULL(GCC.IsGrouped,'0') as IsGrouped,
 ISNULL(GCC.GroupSequence,'0') as GroupSequence From   GridColumn  GC  left join GridColumnConfiguration   GCC  on GC.GridColumnId  = GCC.GridColumnId   and  GCC.IsActive = 1
 left join Pages  p   on  p.PageId = GCC.PageId   and p.IsActive=1
 left join  Resources  res  on GC.ResourceKey = res.ResourceKey and res.IsActive = 1   

left join RoleWisePageMapping  rwpm on p.PageId = rwpm.PageId   and rwpm.RoleMasterId = GCC.RoleId 

 FOR XML PATH('GridColumnList'),ELEMENTS,ROOT('Json')) AS XML)
 
END