-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, June 13, 2016
-- Created By:   Manas
-- Procedure to update entries in the dbo.CultureMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[usp_CultureMaster_Update]

@CultureMasterId bigint,
@CultureName nvarchar(250),
@CultureCode nvarchar(50),
@Description nvarchar(500),
@Active bit,
@CreatedBy bigint,
@CreatedDate datetime,
@UpdatedBy bigint,
@UpdatedDate datetime
	
AS

UPDATE
	[CultureMaster]
SET
	[CultureName] = @CultureName,
	[CultureCode] = @CultureCode,
	[Description] = @Description,
	[Active] = @Active,
	[CreatedBy] = @CreatedBy,
	[CreatedDate] = @CreatedDate,
	[UpdatedBy] = @UpdatedBy,
	[UpdatedDate] = @UpdatedDate
WHERE

	[CultureMasterId] = @CultureMasterId
