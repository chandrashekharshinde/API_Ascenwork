CREATE PROCEDURE [dbo].[SSP_LoadRule_ByRuleId] --'<Json><ServicesAction>LoadEnquiryByEnquiryId</ServicesAction><EnquiryId>247</EnquiryId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @RuleId BIGINT



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @RuleId = tmp.[RuleId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[RuleId] bigint
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT
	   [RuleId]
	  ,[RuleType]
	  --,(select top 1 l.[Name] from LookUp l where l.LookupCategory=16 and l.Code=[RuleType]) RuleTypeName
	  ,(Select top 1 ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = lo.ResourceKey and CultureId = '1101'),lo.Name)   
	  from LookUp lo where lo.Code=convert(nvarchar,[RuleType]) and lo.Lookupcategory = 16) as RuleTypeName
	  ,[RuleText]
	  ,isnull([RuleName],'') as [RuleName]
	  ,[Remarks]
	  ,[SequenceNumber]
 ,CONVERT(varchar(11),FromDate,103) as FromDate
 ,CONVERT(varchar(11),ToDate,103) as ToDate	
	  ,isnull([IsResponseRequired],0) as [IsResponseRequired]
	  ,[ResponseProperty]
	  ,isnull([Enable],0) as [Enable]
	  ,[CreatedBy]
	  ,[CreatedDate]
	  ,[ModifiedBy]
	  ,[ModifiedDate]
	  ,[IsActive]

	FROM [dbo].Rules
	 WHERE (RuleId=@RuleId OR @RuleId=0) AND IsActive=1
	FOR XML path('RuleList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
