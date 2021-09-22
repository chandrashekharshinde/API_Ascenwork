-- =============================================
-- AUTHOR:		<AUTHOR,,ALOK>
-- CREATE DATE: <MONDAY ,JANUARY 27,2020,>
-- DESCRIPTION:	<GET LOOKUP DETAILS ,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetLookupDetailsV2]
	-- ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE
	 
AS
BEGIN
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING WITH SELECT STATEMENTS.
	SET NOCOUNT ON;
	select lkp.lookupid , lkp.name  ,lkp.code  ,lkp.description  ,lkp.parentid  ,0 as companyid 
from lookup as lkp  with (nolock)
 

    
	 
END
