-- =============================================
-- Author:		Abhijit Kharat
-- Create date: 05 feb 2020
-- Description:	<Description,,>
-- [dbo].[SSP_GetAllFilterParametersByPageId] '<Json><ServicesAction>GetPageLevelConfiguration</ServicesAction><CompanyId>10001</CompanyId><pageUrl></pageUrl><UserId>10621</UserId><RoleId>5</RoleId><UserName>Subd1</UserName></Json>'
-- exec [dbo].[SSP_TEST] 2,10621
-- exec [dbo].[SSP_TEST] 3,0
-- =============================================
CREATE PROCEDURE [dbo].[SSP_TEST]
(
 @RoleId INT = 0,
 @UserId INT = 0
)
AS
BEGIN
	SET NOCOUNT ON;		

	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @ParameterDef NVARCHAR(500)
 
    SET @ParameterDef ='@RoleId INT, @UserId INT'

    SET @SQL =  'SELECT FM.FilterMasterId, FM.FilterDescription, FM.PropertyName, FM.ResourceKey, FM.PropertyType, 
						P.ControllerName,P.ControllerName as PageURL, ISNULL(FM.IsRange,0) as IsRange 
				 FROM   FilterMaster FM WITH (NOLOCK)
				 JOIN   PageFilterMapping PFM WITH (NOLOCK) ON PFM.FilterMasterId = FM.FilterMasterId 
				 JOIN   Pages P ON P.PageId = PFM.PageId
	                    AND FM.ParentOrChild=''P'' WHERE -1=-1 AND FM.ParentFilterId=0 
				        AND FM.IsActive=1   AND FM.IsActive=1
				        AND PFM.IsActive=1
				        AND P.IsActive=1' 



	IF EXISTS (SELECT 1 FROM Login WHERE loginId = @UserId)
	BEGIN
	    PRINT ('Match user')
		IF EXISTS (SELECT 1 FROM RoleWiseFilterMapping WHERE loginId = @UserId AND IsActive=1)
			BEGIN
			    PRINT ('got user')
				--set @RoleId=0;
				SET @SQL = @SQL+ ' AND FM.FilterMasterId in  (select FilterMasterId from RoleWiseFilterMapping where IsActive=1 and LoginId=@UserId) ORDER BY FM.FilterMasterId'
			END
		ELSE
			BEGIN
				--set @UserId=0
				PRINT('got Role')
				SET @SQL = @SQL+ ' AND FM.FilterMasterId in  (select FilterMasterId from RoleWiseFilterMapping where RoleMasterId=@RoleId and IsActive=1) ORDER BY FM.FilterMasterId'
			END
	 END
	ELSE 
		BEGIN
		SET @SQL = @SQL+ ' AND FM.FilterMasterId in  (select FilterMasterId from RoleWiseFilterMapping where RoleMasterId=@RoleId and IsActive=1) ORDER BY FM.FilterMasterId'
			PRINT('User does not exits')
			--RETURN -1;
		END


	EXEC sp_Executesql @SQL,  @ParameterDef, @UserId=@UserId,
											 @RoleId=@RoleId

END

