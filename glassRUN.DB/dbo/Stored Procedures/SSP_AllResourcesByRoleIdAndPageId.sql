CREATE PROC [dbo].[SSP_AllResourcesByRoleIdAndPageId]
(
@RoleId BIGINT,
@PageId BIGINT
)
AS
BEGIN
	
	--DECLARE @RoleId BIGINT
    DECLARE @RoleName NVARCHAR(100)
	
	--SET @RoleId=(SELECT TOP 1 RoleId FROM dbo.RoleWiseFieldAccess WHERE PageId=@PageId)  
	SET @RoleName=(SELECT RoleName FROM dbo.RoleMaster WHERE RoleMasterId=@RoleId)

	SELECT CAST((
		--SELECT prm.PageResourceMappingId, prm.PageId, p.PageName, prm.ResourceId, res.ResourceValue 
		--FROM dbo.Resources res, dbo.Pages p, dbo.PageResourceMappingMaster prm
		--WHERE prm.PageId=p.PageId
		--AND prm.ResourceId=res.ResourceId
		--AND prm.PageId=@PageId

		SELECT prm.PageResourceMappingId,@RoleId AS RoleId, @RoleName AS RoleName, p.PageId, p.PageName, res.ResourceId, res.ResourceKey, res.ResourceValue, abc.RoleId, abc.RoleName, abc.RoleWiseFieldAccessId, abc.IsMandatory, 
		abc.IsVisible, 
		--abc.IsAlphaNumeric, abc.IsNumberOnly, abc.SpecialCharacters, 
		abc.ValidationExpression, abc.Description, 
		--abc.Remark, 
		abc.IsActive, abc.CreatedBy, abc.CreatedDate, abc.UpdatedBy, abc.UpdatedDate, abc.IPAddress
        FROM dbo.PageResourceMappingMaster prm LEFT OUTER JOIN (
					SELECT  rm.RoleMasterId AS RoleId, rm.RoleName, p.PageId, p.PageName, res.ResourceId, res.ResourceKey,res.ResourceValue, rfa.RoleWiseFieldAccessId, 
					rfa.IsMandatory, rfa.IsVisible,
					 --rfa.IsAlphaNumeric, rfa.IsNumberOnly, rfa.SpecialCharacters, 
					 rfa.ValidationExpression, rfa.Description, 
					 --rfa.Remark, 
					rfa.IsActive, rfa.CreatedBy, rfa.CreatedDate, rfa.UpdatedBy, rfa.UpdatedDate, rfa.IPAddress 
					FROM dbo.RoleWiseFieldAccess rfa, dbo.RoleMaster rm, dbo.Pages p, dbo.Resources res
					WHERE rfa.RoleId=rm.RoleMasterId
					AND rfa.PageId=p.PageId
					AND rfa.ResourceId=res.ResourceId
					AND rfa.PageId=@PageId
					AND rfa.RoleId=@RoleId
					) abc ON prm.ResourceId=abc.ResourceId
		JOIN dbo.Resources res ON prm.ResourceId=res.ResourceId
		JOIN dbo.Pages p ON prm.PageId=p.PageId
		WHERE prm.PageId=@PageId


	FOR XML RAW('PageResourceMappingMasterList'), ELEMENTS, ROOT('PageResourceMappingMaster')) AS XML)
    

END
