
CREATE PROCEDURE [dbo].[SSP_GridColumnConfiguration_Paging]-- '<Json><ServicesAction>LoadGridColumnPagingList</ServicesAction><PageIndex>0</PageIndex><PageSize>1000</PageSize><OrderBy></OrderBy><RoleId>3</RoleId><PageId>9</PageId><LoginId>0</LoginId><CultureId>1101</CultureId><ObjectId>15</ObjectId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)=''
Declare @RoleId Nvarchar(100)='0'
Declare @PageId Nvarchar(100)=''
Declare @LoginId Nvarchar(100)='0'
Declare @CultureId Nvarchar(100)=''
Declare @ObjectId  Nvarchar(100)=''

set  @whereClause =''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT  @PageSize = tmp.[PageSize],
        @PageIndex = tmp.[PageIndex],
        @OrderBy = tmp.[OrderBy],
		@RoleId = tmp.[RoleId],
		@PageId = tmp.[PageId],
		@LoginId = tmp.[LoginId],
		@CultureId = tmp.[CultureId],
		@ObjectId = tmp.[ObjectId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [RoleId] bigint,
   [PageId] bigint,
   [LoginId] bigint,
   [CultureId] bigint,
   [ObjectId] bigint
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'GridColumnId  desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


 --SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  ,
 -- rownumber,TotalCount,
 -- GridColumnId,ObjectId,PropertyName,PropertyType,IsControlField,ResourceKey,OnScreenDisplay,
 -- SelectedVisible,SelectedDefault,SelectedMandatory,SelectedSystemMandatory,GridColumnConfigurationId,ResourceValue,
 --   IsActive
 -- from 
 
 --(SELECT  ROW_NUMBER() OVER (ORDER BY GridColumnId asc) as rownumber , COUNT(*) OVER () as TotalCount,GridColumnId,
 --   ObjectId,PropertyName,PropertyType,ISNULL(IsControlField,0) as IsControlField,ResourceKey,OnScreenDisplay,
	--ISNULL((Select top 1  IsVisible from GridColumnConfiguration where GridColumnId = gc.GridColumnId and Isactive = 1 and RoleId = '+@RoleId+' and PageId = '+@PageId+'),0) as SelectedVisible,
	--ISNULL((Select top 1  IsDefault from GridColumnConfiguration where GridColumnId = gc.GridColumnId and Isactive = 1 and RoleId = '+@RoleId+' and PageId = '+@PageId+'),0) as SelectedDefault,
	--ISNULL((Select top 1 IsMandatory from GridColumnConfiguration where GridColumnId = gc.GridColumnId and Isactive = 1 and RoleId = '+@RoleId+' and PageId = '+@PageId+'),0) as SelectedMandatory,
 --   ISNULL((Select top 1 IsSystemMandatory from GridColumnConfiguration where GridColumnId = gc.GridColumnId and Isactive = 1 and RoleId = '+@RoleId+' and PageId = '+@PageId+'),0) as SelectedSystemMandatory,
	--ISNULL((Select top 1 GridColumnConfigurationId from GridColumnConfiguration where GridColumnId = gc.GridColumnId and Isactive = 1 and RoleId = '+@RoleId+' and PageId = '+@PageId+'),0) as GridColumnConfigurationId,
	--ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = gc.ResourceKey and CultureId = '+@CultureId+'),'''') as ResourceValue,
 --   IsActive from GridColumn gc
 --   where Isactive = 1 and ObjectId = '+ @ObjectId +' and GridColumnId not in (Select GridColumnId from GridColumnConfiguration where IsSystemMandatory = 1) and ' + @whereClause +'  ) as tmp where 
 --'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
	--FOR XML PATH(''GridColumnList''),ELEMENTS,ROOT(''Json'')) AS XML)'

	 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  
select cast ((SELECT  ''true'' AS [@json:Array]  ,
rownumber,TotalCount,GridColumnId,ObjectId,PropertyName,PropertyType,IsControlField,ResourceKey
,isnull(ResourceValue,PropertyName) as ResourceValue,OnScreenDisplay,GridColumnConfigurationId,RoleId,LoginId,ResourceId,IsAvailable
,PageId,IsDefault,IsGrouped,IsMandatory,IsSystemMandatory,SequenceNumber,IsPinned
,Description,IsDetailsViewAvailable,IsDetailsView,IsExportAvailable,GroupSequence
from  (select ROW_NUMBER() OVER (ORDER BY gc.GridColumnId asc) as rownumber 
,COUNT(*) OVER () as TotalCount
,gc.GridColumnId
,gc.ObjectId
,gc.PropertyName
,gc.PropertyType
,ISNULL(gc.IsControlField,0) as IsControlField
,isnull(gc.ResourceKey,gc.PropertyName) as ResourceKey
,ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = gc.ResourceKey and CultureId = '+@CultureId+'),null) as ResourceValue
,gc.OnScreenDisplay
,Isnull(gc.[IsDetailsViewAvailable],0) as [IsDetailsView]
,Isnull(gcc.[GridColumnConfigurationId],0) as [GridColumnConfigurationId]
,Isnull(gcc.[RoleId],0) as [RoleId]
,Isnull(gcc.[LoginId],0) as [LoginId]
,Isnull(gcc.[ResourceId],0) as [ResourceId]
,Isnull(gcc.[PageId],0) as [PageId]
,Isnull(gcc.[IsPinned],0) as [IsPinned]
,Isnull(gcc.[IsAvailable],0) as [IsAvailable]
,Isnull(gcc.[IsDefault],0) as [IsDefault]
,Isnull(gcc.[IsGrouped],0) as [IsGrouped]
,Isnull(gcc.[IsMandatory],0) as [IsMandatory]
,Isnull(gc.[IsSystemMandatory],0) as [IsSystemMandatory]
,Isnull(gcc.[SequenceNumber],0) as [SequenceNumber]
,Isnull(gcc.[Description],''-'') as [Description]
,Isnull(gcc.[IsDetailsViewAvailable],0) as [IsDetailsViewAvailable]
,Isnull(gcc.[IsExportAvailable],0) as [IsExportAvailable]
,gcc.GroupSequence
 from GridColumn gc left join GridColumnConfiguration gcc on gc.GridColumnId=gcc.GridColumnId 
 and gcc.PageId='+@PageId+' 
 and (Isnull(gcc.RoleId,0)='+@RoleId+')
 and (Isnull(gcc.LoginId,0)='+@LoginId+')
 and Isnull(gcc.[PageId],0)='+@PageId+'
 and gcc.IsActive=1
 where gc.ObjectId='+ @ObjectId +' and gc.IsActive=1
 --and gc.GridColumnId not in (Select GridColumnId from GridColumnConfiguration where IsSystemMandatory = 1) 
 and 1=1  ) 
 as tmp order by isnull(tmp.ResourceValue,tmp.PropertyName)
 --where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
FOR XML PATH(''GridColumnList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  
   PRINT @sql
EXEC sp_executesql @sql

END