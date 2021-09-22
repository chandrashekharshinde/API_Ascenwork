
Create FUNCTION [dbo].[fngetComapnyParentChild]
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
AS(
SELECT CompanyId,CompanyName, 1 RecursiveCallNumber  FROM Company  WHERE CompanyId=@IDs
UNION ALL
SELECT  E.CompanyId,E.CompanyName,RecursiveCallNumber+1 RecursiveCallNumber  FROM Company E
INNER JOIN  CTE ON E.ParentCompany=CTE.CompanyId)
INSERT INTO @SplitValues SELECT CTE.CompanyId FROM CTE

	RETURN
END
