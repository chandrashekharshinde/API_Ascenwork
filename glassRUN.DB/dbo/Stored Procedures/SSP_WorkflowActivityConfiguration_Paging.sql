CREATE PROCEDURE [dbo].[SSP_WorkflowActivityConfiguration_Paging]-- '<Json><ServicesAction>LoadGridColumnPagingList</ServicesAction><PageIndex>0</PageIndex><PageSize>1000</PageSize><OrderBy></OrderBy><RoleId>3</RoleId><PageId>9</PageId><LoginId>0</LoginId><CultureId>1101</CultureId><ObjectId>15</ObjectId></Json>'
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
Declare @WorkFlowCode Nvarchar(200)=''
Declare @LoginId Nvarchar(100)='0'
Declare @CultureId Nvarchar(100)=''
Declare @ObjectId  Nvarchar(100)=''

set  @whereClause =''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT  @PageSize = tmp.[PageSize],
        @PageIndex = tmp.[PageIndex],
        @OrderBy = tmp.[OrderBy],
		@RoleId = tmp.[RoleId],
		@WorkFlowCode = tmp.[WorkFlowCode],
		@LoginId = tmp.[LoginId],
		@CultureId = tmp.[CultureId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [RoleId] bigint,
   [WorkFlowCode] nvarchar(200),
   [LoginId] bigint,
   [CultureId] bigint
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'GridColumnId  desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


Select * from (
select 
gc.WorkFlowStepId
,gc.WorkFlowCode
,isnull (gc.ActivityName,ac.ActivityName) as ActivityName
,isnull (gc.StatusCode,ac.StatusCode) as StatusCode
,Isnull(gcc.IsAvailable,0) as IsAvailable
,Isnull(gcc.IsNotificationLogAvailable,0) as IsNotificationLogAvailable
,Isnull(gcc.IsActivityLogAvailable,0) as IsActivityLogAvailable
,Isnull(gcc.[LoginId],0) as [LoginId]
,Isnull(gcc.RoleId,0) as [RoleId]
,gc.SequenceNo
,ac.ParentId
 from WorkFlowStep gc left join WorkflowActivityConfiguration gcc 
 on gc.WorkFlowCode=gcc.WorkFlowCode 
 and gc.StatusCode=gcc.StatusCode
 and (Isnull(gcc.RoleId,0)=@RoleId)
 and (Isnull(gcc.LoginId,0)=@LoginId)
 and gcc.IsActive=1
 left join Activity ac on ac.StatusCode=gcc.StatusCode
 where gc.WorkFlowCode=@WorkFlowCode and gc.IsActive=1
 and 1=1  
 Union all
 select
0 as WorkFlowStepId
,@WorkFlowCode as WorkFlowCode
,isnull (ac.ActivityName,ac.ActivityName) as ActivityName
,isnull (ac.StatusCode,ac.StatusCode) as StatusCode
,Isnull(gcc.IsAvailable,0) as IsAvailable
,Isnull(gcc.IsNotificationLogAvailable,0) as IsNotificationLogAvailable
,Isnull(gcc.IsActivityLogAvailable,0) as IsActivityLogAvailable
,Isnull(gcc.[LoginId],0) as [LoginId]
,Isnull(gcc.RoleId,0) as [RoleId]
,ac.Sequence as SequenceNo
,ac.ParentId
 from WorkflowActivityConfiguration gcc  left join Activity ac on ac.StatusCode=gcc.StatusCode 
 where ac.ParentId=0
 and (Isnull(gcc.RoleId,0)=@RoleId)
 and (Isnull(gcc.LoginId,0)=@LoginId)
 and gcc.IsActive=1 and
gcc.WorkFlowCode=@WorkFlowCode and gcc.IsActive=1) as tmp
ORDER BY
    CASE WHEN ParentId = 0 THEN StatusCode ELSE ParentId END
    ,ParentId



END