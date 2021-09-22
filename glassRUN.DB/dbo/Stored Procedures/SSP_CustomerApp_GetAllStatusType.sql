



CREATE PROCEDURE [dbo].[SSP_CustomerApp_GetAllStatusType] --'<Json><ServicesAction>GetOutletList</ServicesAction><pageIndex>0</pageIndex><pageSize>15</pageSize><customerId>536</customerId><searchValue></searchValue></Json>'

@xmlDoc XML
AS

BEGIN

declare @PageIndex INT
declare @PageSize INT
declare @searchValue nvarchar(500)
DECLARE @OutletCount int;
Declare @CultureId bigint
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @roleId bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

SELECT        @roleId = tmp.[RoleId],       @CultureId = tmp.[CultureId] FROM OPENXML(@intpointer,'Json',2)   WITH   (        [RoleId] bigint,    [CultureId] bigint   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT distinct 'true' AS [@json:Array],
ResourceValue as Id,
ResourceValue as StatusType  
from RoleWiseStatus rws join Resources r on rws.ResourceKey = r.ResourceKey
join WorkFlowStep wfs on rws.StatusId = wfs.StatusCode
where RoleId=@roleId and rws.IsActive=1 and CultureId =  1101
FOR XML PATH('StatusTypeList'),ELEMENTS,ROOT('Json')) AS XML)

END



