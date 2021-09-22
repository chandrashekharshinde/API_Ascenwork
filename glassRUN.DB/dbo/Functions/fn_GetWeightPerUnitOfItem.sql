CREATE FUNCTION [dbo].[fn_GetWeightPerUnitOfItem]
(@itemId bigint)
RETURNS float
BEGIN

declare @primaryUnitOfMeasure bigint
declare @UOM bigint
declare @ConversionFactor decimal(18,2)
declare @WeightPerUnit Float

select @primaryUnitOfMeasure=PrimaryUnitOfMeasure from Item where ItemId=@ItemId
--select @ConversionFactor=ConversionFactor,@UOM=UOM from UnitOfMeasure where ItemId=@ItemId and RelatedUOM=@primaryUnitOfMeasure
select @WeightPerUnit=ConversionFactor from UnitOfMeasure where ItemId=@ItemId and RelatedUOM=18



return @WeightPerUnit

END