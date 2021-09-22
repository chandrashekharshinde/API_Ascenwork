-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Tuesday, September 19, 2017
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.Rules table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[DSP_ItemAllocationRules] --'<Rules><RuleId>65105013</RuleId><RuleType>2</RuleType><RuleText>1110899</RuleText><CompanyType>0</CompanyType><Remarks></Remarks><ShipTo>0</ShipTo><SequenceNumber>0</SequenceNumber><FromDate>2017-11-09T00:00:00</FromDate><ToDate>2017-12-11T00:00:00</ToDate><CreatedBy>0</CreatedBy><CreatedDate>2017-11-09T13:55:06.7269703+05:30</CreatedDate><IsActive>1</IsActive><SequenceNo>0</SequenceNo></Rules>'
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


        
        Select * Into #temp  FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		[RuleId] [bigint] 
        )tmp
        

		Update Rules set IsActive=0,ModifiedDate=GETDATE() where RuleId in (select RuleId from #temp t)

	

        DECLARE @Rules bigint
		set @Rules=(select RuleId from #temp t)
	    SET @Rules = @@IDENTITY
        


        --Add child table insert procedure when required.
    
    SELECT @Rules as RulesId FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
