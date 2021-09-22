
CREATE FUNCTION [dbo].[fngetHierarchyParent]
(
	@IDs bigint
)
RETURNS 
@SplitValues TABLE 
(
	ID bigint
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

	;WITH CTE
As
(
 
    SELECT
        CompanyId, isnull(ParentCompanyId,0) As ParentCompanyId, 1 AS CodePosition
    FROM
        Hierarchy WHERE CompanyId = @IDs
    UNION All
    SELECT
        ic.CompanyId, ic.ParentCompanyId, CodePosition + 1
    FROM Hierarchy ic
    INNER JOIN CTE cte ON ic.CompanyId = cte.ParentCompanyId
)
INSERT INTO @SplitValues SELECT top 1 CTE.CompanyId FROM CTE 
ORDER BY CodePosition DESC

--;WITH CTE 
--AS(
--SELECT CompanyId, 1 RecursiveCallNumber,isnull(ParentCompanyId,0) ParentCompanyId  FROM Hierarchy  WHERE CompanyId=@IDs
--UNION ALL
--SELECT  E.CompanyId,RecursiveCallNumber+1 RecursiveCallNumber,isnull(e.ParentCompanyId,0) ParentCompanyId  FROM Hierarchy E
--INNER JOIN  CTE ON E.CompanyId=isnull(CTE.ParentCompanyId,0))
--INSERT INTO @SplitValues SELECT top 1 CTE.CompanyId FROM CTE 
--ORDER BY RecursiveCallNumber DESC
	
--	;WITH CTE 
--AS(
--SELECT CompanyId,CompanyName, 1 RecursiveCallNumber  FROM Company  WHERE CompanyId=@IDs
--UNION ALL
--SELECT  E.CompanyId,E.CompanyName,RecursiveCallNumber+1 RecursiveCallNumber  FROM Company E
--INNER JOIN  CTE ON E.ParentCompany=CTE.CompanyId)
--INSERT INTO @SplitValues SELECT CTE.CompanyId FROM CTE

	RETURN
END
