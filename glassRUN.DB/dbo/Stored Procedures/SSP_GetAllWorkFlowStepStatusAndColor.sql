
CREATE PROCEDURE [dbo].[SSP_GetAllWorkFlowStepStatusAndColor]
@xmlDoc XML
AS
BEGIN

DECLARE @intPointer INT;Declare @RoleId bigint;
Declare @CultureId bigint;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @RoleId = tmp.[RoleId],	  @CultureId = tmp.[CultureId]	   FROM OPENXML(@intpointer,'Json',2)			WITH			(			[RoleId] bigint,			[CultureId] bigint			)tmp ;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((SELECT 'true' AS [@json:Array] ,
 wfs.WorkFlowCode,wfs.ActivityName,wfs.StatusCode,rws.ResourceKey,res.ResourceValue,rws.Class,res.CultureId,a.ObjectId,
CASE
    WHEN a.ObjectId = 1 THEN (select COUNT(*) from Enquiry where currentstate = wfs.StatusCode and isactive = 1)
    else (select COUNT(*) from [Order] where currentstate = wfs.StatusCode and isactive = 1)
END as TotalCount
from WorkFlowStep wfs join RoleWiseStatus rws on wfs.StatusCode = rws.StatusId
join Resources res on rws.ResourceKey = res.ResourceKey
join Activity a on wfs.StatusCode = a.StatusCode
where wfs.IsActive = 1 and rws.IsActive =1 and rws.RoleId = 3 and res.CultureId = 1101
order by wfs.SequenceNo asc

	FOR XML path('WorkFlowStepList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
