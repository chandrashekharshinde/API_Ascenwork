CREATE PROCEDURE [dbo].[SSP_AllResourcesListForCache] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'


AS
BEGIN


DECLARE @intPointer INT;
Declare @CultureId bigint;




--SELECT @CultureId = tmp.[CultureId]
	   
--FROM OPENXML(@intpointer,'Json',2)
--			WITH
--			(
--			[CultureId] bigint
           
--			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array],CultureId,ResourceKey,ResourceValue from Resources where IsActive=1
	FOR XML path('ResourcesList'),ELEMENTS,ROOT('Resources')) AS XML)
END