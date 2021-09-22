



CREATE PROCEDURE [dbo].[SSP_CustomerApp_GetAllArea] --'<Json><ServicesAction>GetOutletList</ServicesAction><pageIndex>0</pageIndex><pageSize>15</pageSize><customerId>536</customerId><searchValue></searchValue></Json>'

@xmlDoc XML
AS

BEGIN

declare @PageIndex INT
declare @PageSize INT
declare @searchValue nvarchar(500)
DECLARE @OutletCount int;

DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT distinct 'true' AS [@json:Array],
b.Region as Id,
b.Region as Area  
from Company b where b.IsActive=1 and (isnull(b.Region,'0')!='0' and b.Region!='')
FOR XML PATH('RegionTypeList'),ELEMENTS,ROOT('Json')) AS XML)

END



