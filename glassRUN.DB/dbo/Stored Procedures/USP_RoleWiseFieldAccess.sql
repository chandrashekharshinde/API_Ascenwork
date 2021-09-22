-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Wednesday, January 20, 2016
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleWiseFieldAccess table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_RoleWiseFieldAccess]

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

              INSERT INTO	[RoleWiseFieldAccess]
        (
        	[RoleId],
        	[PageId],
        	[ResourceId],
        	[IsMandatory],
        	[IsVisible],
			--[IsAlphaNumeric],
			--[IsNumberOnly],
			--[SpecialCharacters],
			[ValidationExpression],
        	[Description],
        	--[Remark],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate],
        	--[UpdatedBy],
        	--[UpdatedDate],
        	[IPAddress]
        )

        SELECT
        	tmp.[RoleId],
        	tmp.[PageId],
        	tmp.[ResourceId],
        	tmp.[IsMandatory],
        	tmp.[IsVisible],
        	--tmp.[IsAlphaNumeric],
        	--tmp.[IsNumberOnly],
        	--tmp.[SpecialCharacters],
        	tmp.[ValidationExpression],
        	tmp.[Description],
        	--tmp.[Remark],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE(),--tmp.[CreatedDate],
        	--tmp.[UpdatedBy],
        	--tmp.[UpdatedDate],
        	tmp.[IPAddress]
            --FROM OPENXML(@intpointer,'RoleWiseFieldAccess',2)
			FROM OPENXML(@intpointer,'RoleWiseFieldAccess/RoleWiseFieldAccessList',2)
        WITH
        (
            [RoleWiseFieldAccessId] bigint,
			[RoleId] bigint,
            [PageId] bigint,
            [ResourceId] BIGINT,
            [IsMandatory] bit,
            [IsVisible] bit,
            --[IsAlphaNumeric] bit,
            --[IsNumberOnly] bit,
            --[SpecialCharacters] nvarchar(20),
            [ValidationExpression] nvarchar(50),
            [Description] nvarchar(500),
            --[Remark] nvarchar(500),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime,
            --[UpdatedBy] bigint,
            --[UpdatedDate] datetime,
            [IPAddress] nvarchar(20)
        )tmp WHERE tmp.RoleWiseFieldAccessId=0
        
        DECLARE @RoleWiseFieldAccessId bigint
	    SET @RoleWiseFieldAccessId= @@IDENTITY
        
        --Add child table insert procedure when required.

            
            UPDATE dbo.RoleWiseFieldAccess SET
			@RoleWiseFieldAccessId=tmp.RoleWiseFieldAccessId,
        	[RoleId]=tmp.RoleId ,
        	[PageId]=tmp.PageId ,
        	[ResourceId]=tmp.ResourceId ,
        	[IsMandatory]=tmp.IsMandatory ,
        	[IsVisible]=tmp.IsVisible ,
        	--[IsAlphaNumeric]=tmp.IsAlphaNumeric ,
        	--[IsNumberOnly]=tmp.IsNumberOnly ,
        	--[SpecialCharacters]=tmp.SpecialCharacters ,
        	[ValidationExpression]=tmp.ValidationExpression,
        	[Description]=tmp.Description ,
        	--[Remark]=tmp.Remark ,
        	[IsActive]=tmp.IsActive ,
        	--[CreatedBy]=tmp.CreatedBy ,
        	--[CreatedDate]=tmp.CreatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[IPAddress]=tmp.IPAddress
            FROM OPENXML(@intpointer,'RoleWiseFieldAccess/RoleWiseFieldAccessList',2)
			WITH
			(
            [RoleWiseFieldAccessId] bigint,
            [RoleId] bigint,
            [PageId] bigint,
            [ResourceId] BIGINT,
            [IsMandatory] bit,
            [IsVisible] bit,
            --[IsAlphaNumeric] bit,
            --[IsNumberOnly] bit,
            --[SpecialCharacters] nvarchar(20),
            [ValidationExpression] nvarchar(50),
            [Description] nvarchar(500),
            --[Remark] nvarchar(500),
            [IsActive] bit,
            --[CreatedBy] bigint,
            --[CreatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedDate] datetime,
            [IPAddress] nvarchar(20)
            )tmp WHERE RoleWiseFieldAccess.[RoleWiseFieldAccessId]=tmp.[RoleWiseFieldAccessId]

            SELECT  @RoleWiseFieldAccessId

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleWiseFieldAccess'
