Create PROCEDURE [dbo].[SSP_GetAllResourcesKey] 
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
   Select * into #tempRules
 FROM OPENXML(@intpointer,'Json/RulesList',2)
        WITH
        (
       
		[SKUCode] [nvarchar](max) ,
		[SKUname] [nvarchar](max) ,
		[Customerid] [nvarchar](max) ,
		[CusomerName] [nvarchar](max) ,
		[Totalallocation] [nvarchar](max) ,
		[MaxOrderQtyforpromotionalperiod] [nvarchar](max) ,
		[Startdateforpromotion] [nvarchar](max) ,
		[Enddateforpromotion] [nvarchar](max) 
		
        )tmp

	Select * from Resources where IsActive=1
		
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
