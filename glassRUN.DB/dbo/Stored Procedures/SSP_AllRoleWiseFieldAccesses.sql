CREATE PROC [dbo].[SSP_AllRoleWiseFieldAccesses]
AS
BEGIN
	
	SELECT CAST((
	
            SELECT 
			   rfa.[RoleWiseFieldAccessId]
		      ,rfa.[RoleId]
			  ,rm.[RoleName]
		      ,rfa.[PageId]
			  ,p.[PageName]
		      ,rfa.[ResourceId]
			  ,res.[ResourceKey]
			  ,res.[ResourceValue]
		      ,rfa.[IsMandatory]
		      ,rfa.[IsVisible]
		      --,rfa.[IsAlphaNumeric]
		      --,rfa.[IsNumberOnly]
		      --,rfa.[SpecialCharacters]
		      ,rfa.[ValidationExpression]
		      ,rfa.[Description]
		      --,rfa.[Remark]
		      ,rfa.[IsActive]
		      ,rfa.[CreatedBy]
		      ,rfa.[CreatedDate]
		      ,rfa.[UpdatedBy]
		      ,rfa.[UpdatedDate]
		      ,rfa.[IPAddress] 
		FROM dbo.RoleWiseFieldAccess rfa JOIN dbo.RoleMaster rm ON rfa.RoleId=rm.RoleMasterId
		JOIN dbo.Pages p ON rfa.PageId=p.PageId 
		JOIN dbo.Resources res ON rfa.ResourceId=res.ResourceId
	FOR XML RAW('RoleWiseFieldAccessList'), ELEMENTS, ROOT('RoleWiseFieldAccess')) AS XML)
    

END
