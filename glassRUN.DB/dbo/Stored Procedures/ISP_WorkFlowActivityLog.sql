

CREATE PROCEDURE [dbo].[ISP_WorkFlowActivityLog] 
@xmlDoc xml 
AS 
BEGIN 
SET ARITHABORT ON 
DECLARE @TranName NVARCHAR(max) 
DECLARE @ErrMsg NVARCHAR(max) 
DECLARE @ErrSeverity INT; 
DECLARE @intPointer INT; 
DECLARE @EmailEventId bigint;
SET @ErrSeverity = 15; 

BEGIN TRY
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

Select * Into #tmpWorkFlowActivityLogList
FROM OPENXML(@intpointer,'Json/WorkFlowActivityLogList',2)
WITH
(
[WorkFlowActivityLogId] bigint,
[LoginId] bigint ,
[RoleId] bigint ,
[EnquiryId] bigint ,
[EnquiryNumber] nvarchar(200) ,
[OrderId] bigint ,
[OrderNumber] nvarchar(200) ,
[WorkFlowCode] nvarchar(200) ,
[WorkFlowCurrentStatusCode] bigint ,
[WorkFlowCurrentActivityName] nvarchar(200) ,
[WorkFlowPreviousStatusCode] bigint ,
[WorkFlowPreviousActivityName] nvarchar(200) ,
[IsIsAutomated] bit,
[ProcessOutputResponse] nvarchar(max),
[Username] nvarchar(max),
[RawData] nvarchar(max) ,
[ActivityStartTime] nvarchar(max) ,
[ActivityEndTime] nvarchar(max) ,
[CreatedDate] nvarchar(max) ,
[CreatedBy] bigint 
)tmp


--If not exists (Select count(wal.WorkFlowActivityLogId) from WorkFlowActivityLog wal join  #tmpWorkFlowActivityLogList tmp on wal.WorkFlowCode=tmp.WorkFlowCode where  wal.[LoginId]  = tmp.[LoginId] and wal.[EnquiryId]  = tmp.[EnquiryId] and wal.[EnquiryNumber]  = tmp.[EnquiryNumber] and wal.[OrderId]   = tmp.[OrderId] and wal.[OrderNumber]  = tmp.[OrderNumber] and wal.[WorkFlowCurrentStatusCode]   = tmp.[WorkFlowCurrentStatusCode] and tmp.[WorkFlowCurrentActivityName]  = wal.[WorkFlowCurrentActivityName])
-- BEGIN

INSERT INTO [dbo].[WorkFlowActivityLog]
([LoginId]
,[RoleId]
,[EnquiryId]
,[EnquiryNumber]
,[OrderId]
,[OrderNumber]
,[WorkFlowCode]
,[WorkFlowCurrentStatusCode]
,[WorkFlowCurrentActivityName]
,[WorkFlowPreviousStatusCode]
,[WorkFlowPreviousActivityName]
,[RawData]
,[IsIsAutomated] 
,[ProcessOutputResponse] 
,[Username] 
,[CreatedBy]
,[ActivityStartTime] 
,[ActivityEndTime] 
,[CreatedDate])

SELECT
tmp.[LoginId]
,(select top 1 l.Rolemasterid from [Login] l where l.LoginId=tmp.[LoginId]) as [RoleId]
,tmp.[EnquiryId]
,tmp.[EnquiryNumber]
,tmp.[OrderId]
,tmp.[OrderNumber]
,tmp.[WorkFlowCode]
,tmp.[WorkFlowCurrentStatusCode]
,tmp.[WorkFlowCurrentActivityName]
,tmp.[WorkFlowPreviousStatusCode]
,tmp.[WorkFlowPreviousActivityName]
,tmp.[RawData]
,tmp.[IsIsAutomated] 
,tmp.[ProcessOutputResponse] 
,case when tmp.[LoginId] =0 then 'Automated Rule Engine' else (select top 1 l.UserName from [Login] l where l.LoginId=tmp.[LoginId]) end as [Username] 
,tmp.[CreatedBy]
,Case when tmp.[RawData] ='App' then tmp.[ActivityStartTime] else convert(datetime,tmp.[ActivityStartTime] ,103) end
,Case when tmp.[RawData] ='App' then tmp.[ActivityEndTime] else convert(datetime,tmp.[ActivityEndTime] ,103)  end
,Case when tmp.[RawData] ='App' then tmp.[CreatedDate]  else GETDATE() end
From #tmpWorkFlowActivityLogList tmp
--End


DECLARE @WorkFlowActivityLogId bigint=0
SET @WorkFlowActivityLogId = @@IDENTITY
SELECT @WorkFlowActivityLogId as WorkFlowActivityLogId FOR XML RAW('Json'),ELEMENTS



exec sp_xml_removedocument @intPointer 
END TRY
BEGIN CATCH
SELECT @ErrMsg = ERROR_MESSAGE(); 
RAISERROR(@ErrMsg, @ErrSeverity, 1); 
RETURN; 
END CATCH
END