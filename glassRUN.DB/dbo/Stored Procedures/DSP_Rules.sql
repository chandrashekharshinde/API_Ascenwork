Create PROCEDURE [dbo].[DSP_Rules] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @ruleId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ruleId = tmp.[RuleId]
    
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [RuleId] bigint
           
   )tmp ;


   
Update Rules SET IsActive=0 where RuleId=@ruleId

 SELECT @ruleId as RuleId FOR XML RAW('Json'),ELEMENTS
END
