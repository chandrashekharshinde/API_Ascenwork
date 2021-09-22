
-- ============================================= 
-- AUTHOR:     
-- CREATE DATE: <27 JANUARY 2020,,> 
-- DESCRIPTION:   
-- ============================================= 
CREATE PROCEDURE [dbo].[SSP_GetSettingV2]
-- ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE 
@COMPANYID bigint
AS
BEGIN
  SELECT
    SM.settingmasterid,
    SM.settingparameter,
    SM.description,
    SM.settingvalue,
    SM.companyid
  FROM [settingmaster] AS SM WITH (NOLOCK)
  WHERE SM.companyid = @COMPANYID
  AND SM.isactive = 1
END