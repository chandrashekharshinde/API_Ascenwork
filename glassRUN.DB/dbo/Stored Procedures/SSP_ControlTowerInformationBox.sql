CREATE PROCEDURE [dbo].[SSP_ControlTowerInformationBox] --'<Json><ServicesAction>LoadControlTowerInformationBox</ServicesAction><RoleId>4</RoleId><UserId>463</UserId></Json>'
@xmlDoc XML
AS
BEGIN


--DECLARE @intPointer INT;
--Declare @OrderId bigint


--EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


--SELECT @OrderId = tmp.[OrderId]
--FROM OPENXML(@intpointer,'Json',2)
--			WITH
--			(
--			[OrderId] bigint
--			)tmp ;


			
--WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
--SELECT CAST((SELECT  'true' AS [@json:Array] , COUNT(*) as [Count],ActivityName as StatusName 
--	from Activity
--	left join [Order] on CurrentState = StatusCode
--	where Header IN ('Order','Order Process')
--	group by CurrentState,ActivityName
--	FOR XML path('InformationBoxList'),ELEMENTS,ROOT('Json')) AS XML)

	 Select Cast((SELECT 
	 (select cast ((SELECT   COUNT(*) as [Count],ActivityName as StatusName ,StatusCode,'TotalOrders' as ControlName,'Total Orders' as Header
	from Activity
	left join [Order] on CurrentState = StatusCode
	where Header IN ('Order','Order Process') and StatusCode = 520
	group by CurrentState,ActivityName,StatusCode
 FOR XML path('InformationBoxList'),ELEMENTS) AS xml)),
	 (select cast ((SELECT   COUNT(*) as [Count],ActivityName as StatusName ,StatusCode,'AttentionNeeded' as ControlName,'Attention Needed' as Header
	from Activity
	left join [Order] on CurrentState = StatusCode
	where Header IN ('Order','Order Process') and StatusCode = 520
	group by CurrentState,ActivityName,StatusCode
 FOR XML path('InformationBoxList'),ELEMENTS) AS xml))
  
	 FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)
END
