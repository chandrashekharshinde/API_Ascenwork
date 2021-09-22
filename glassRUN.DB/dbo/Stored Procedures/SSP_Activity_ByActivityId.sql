CREATE PROCEDURE [dbo].[SSP_Activity_ByActivityId] --'<Json><ServicesAction>LoadEnquiryByEnquiryId</ServicesAction><EnquiryId>1625</EnquiryId><RoleId>3</RoleId><CultureId>1101</CultureId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @ActivityId BIGINT


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ActivityId = tmp.[ActivityId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ActivityId] bigint
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT 
	ActivityId,
	StatusCode,
	Header,
	ActivityName,
	[Sequence],
	ServiceAction,
	IsResponseRequired,
	ResponsePropertyName,
	RejectedStatus,
	IsApp,
	ParentId,
	IconName,
	IsSystemDefined,

	   (select cast ((SELECT  'true' AS [@json:Array]  ,  ActivityPossibleStepId,CurrentStatusCode,PossibleStatusCode
		from ActivityPossibleSteps where CurrentStatusCode = a.StatusCode
 FOR XML path('ActivityPossibleSteps'),ELEMENTS) AS xml)),

 (select cast ((SELECT  'true' AS [@json:Array]  ,  ActivityPreviousStepId,CurrentStatusCode,PreviousStatusCode
		from ActivityPreviousSteps where CurrentStatusCode = a.StatusCode
 FOR XML path('ActivityPreviousSteps'),ELEMENTS) AS xml)),

 (select cast ((SELECT  'true' AS [@json:Array]  ,  ActivityPrerequisiteStepId,CurrentStatusCode,PrerequisiteStatusCode
		from ActivityPrerequisiteSteps where CurrentStatusCode = a.StatusCode
 FOR XML path('ActivityPrerequisiteSteps'),ELEMENTS) AS xml)),

 (select cast ((SELECT  'true' AS [@json:Array]  ,  ActivityFormMappingId,StatusCode,FormName,FormURL,FormType
		from ActivityFormMapping where StatusCode = a.StatusCode
 FOR XML path('ActivityFormMapping'),ELEMENTS) AS xml))

	FROM [dbo].Activity a
	 WHERE (a.ActivityId=@ActivityId OR @ActivityId=0) 
	FOR XML path('Activity'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END