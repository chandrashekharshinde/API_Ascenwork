Create PROCEDURE [dbo].[SSP_GetMenuMasterByRoleMasterId] 
 @RoleMasterId BIGINT

AS
BEGIN
SELECT CAST((

SELECT distinct [MenuMaster].[MenuMasterId],
  [MenuName],
  [ParentMenuId],
  [Description],
  [PageURL],
  [PageURL] AS 'PageName',
  [AllowWithoutLogin]
      ,[MenuMaster].[IsActive]
      ,[MenuMaster].[CreatedDate]
      ,[MenuMaster].[CreatedBy]
      ,[MenuMaster].[UpdatedDate]
      ,[MenuMaster].[UpdatedBy]
   ,[MenuMaster].MenuSequence
   ,[RoleMaster].[RoleMasterId] AS 'RoleMasterId'
  FROM [dbo].[MenuMaster] LEFT OUTER JOIN [dbo].[RoleMenuLink] ON
  [MenuMaster].[MenuMasterId]=[RoleMenuLink].[MenuMasterId] 
  LEFT OUTER JOIN [dbo].[RoleMaster] ON [RoleMenuLink].[RoleMasterId]=[RoleMaster].[RoleMasterId]
  WHERE [RoleMaster].[RoleMasterId]=@RoleMasterId AND [MenuMaster].IsActive = 1
    order by MenuSequence

 FOR XML RAW('MenuMasterList'),ELEMENTS,ROOT('MenuMaster')) AS XML)
 
END
