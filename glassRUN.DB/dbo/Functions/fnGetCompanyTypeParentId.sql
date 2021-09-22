CREATE FUNCTION [dbo].[fnGetCompanyTypeParentId]
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

;WITH CTE 
AS(
SELECT LookUpId,Name,ParentId, 1 RecursiveCallNumber  FROM LookUp  WHERE LookUpId=@IDs
UNION ALL
SELECT  E.LookUpId,E.Name,E.ParentId,RecursiveCallNumber+1 RecursiveCallNumber  FROM LookUp E
INNER JOIN  CTE ON E.LookUpId=CTE.ParentId)
INSERT INTO @SplitValues SELECT CTE.LookUpId FROM CTE Where RecursiveCallNumber!=1

RETURN
END
