-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, June 13, 2016
-- Created By:   Manas
-- Procedure to insert entries in the dbo.CultureMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[usp_CultureMaster_Insert]

@CultureMasterId bigint OUTPUT,
@CultureName nvarchar(250),
@CultureCode nvarchar(50),
@Description nvarchar(500),
@Active bit,
@CreatedBy bigint,
@CreatedDate datetime,
@UpdatedBy bigint,
@UpdatedDate datetime

AS

INSERT INTO	[CultureMaster]
(
	[CultureName],
	[CultureCode],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
)
VALUES
(
	@CultureName,
	@CultureCode,
	@Description,
	@Active,
	@CreatedBy,
	@CreatedDate,
	@UpdatedBy,
	@UpdatedDate
)
SET @CultureMasterId = SCOPE_IDENTITY()
