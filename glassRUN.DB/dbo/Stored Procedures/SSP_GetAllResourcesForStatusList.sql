CREATE PROC [dbo].[SSP_GetAllResourcesForStatusList] --'<Json><ServicesAction>GetAllResourceForStatus</ServicesAction><CultureId>1101</CultureId><CompanyId>0</CompanyId><RoleId>3</RoleId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @CompanyId bigint;
declare @RuleId bigint;
declare @CultureId bigint;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId],
	@RuleId = tmp.[RoleId],
	@CultureId = tmp.[CultureId]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
			[RoleId] bigint,
			[CultureId] bigint
			)tmp;


Declare @selectedStatus nvarchar(max)

if @RuleId=3  --- Customer Service
begin
set @selectedStatus='990,980,999,720'
end
else if @RuleId=4  ---Customer
begin
set @selectedStatus='8,990,980,999,720'
end
else if @RuleId=5 --Security
begin
set @selectedStatus='980,999,720'
end
else if @RuleId=6 --wharehouse
begin
set @selectedStatus='980,999,720'
end
else if @RuleId=7 --Transporter
begin
set @selectedStatus='980,999,720'
end;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((


SELECT distinct 'true' AS [@json:Array]  ,
ResourceValue, r.CultureId from Resources r left join RoleWiseStatus rws on r.ResourceKey = rws.ResourceKey
left join workflowstep ws on statuscode = rws.statusid
where RoleId = @RuleId and r.IsActive=1 and ws.IsActive=1 and rws.IsActive=1  and ws.WorkFlowCode = 'PSFMLMWF'
or rws.StatusId in (Select * from dbo.fnSplitValuesForNvarchar(@selectedStatus))




FOR XML path('StatusResourcesList'),ELEMENTS,ROOT('Json')) AS XML)

	
END
