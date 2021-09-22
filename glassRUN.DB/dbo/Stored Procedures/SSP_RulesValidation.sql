CREATE PROCEDURE [dbo].[SSP_RulesValidation] --'<Json><RulesList><SKUCode>65101021</SKUCode><SKUname>Tiger 330x24B Uncage</SKUname><Customerid>1111635</Customerid><CusomerName>HMcc</CusomerName><Totalallocation>100</Totalallocation><MaxOrderQtyforpromotionalperiod /><Startdateforpromotion>2017-01-19T00:00:00</Startdateforpromotion><Enddateforpromotion>2017-01-21T00:00:00</Enddateforpromotion></RulesList><RulesList><SKUCode /><SKUname /><Customerid /><CusomerName /><Totalallocation /><MaxOrderQtyforpromotionalperiod /><Startdateforpromotion /><Enddateforpromotion /></RulesList><RulesList><SKUCode /><SKUname /><Customerid /><CusomerName /><Totalallocation /><MaxOrderQtyforpromotionalperiod /><Startdateforpromotion /><Enddateforpromotion /></RulesList></Json>'
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
		[Enddateforpromotion] [nvarchar](max) ,
		[AddOrDelete] [nvarchar](max), 
		[Description] [nvarchar](max) 
        )tmp

		select *
		,case when Isnull(ItemId,'0') ='0' then  [SKUCode]+' SKU Code not found' else 
		case when SoldTo=0 then [Customerid]+' Company Mnemonic not found' else 
		case when Convert(date,GETDATE()) > isnull([Enddateforpromotion],Convert(date,GETDATE())) and [AddOrDelete] != 'N' then 'Allocation Expired' else
		NUll end end end as Remark from (
		Select
		--Isnull ((Select I.ItemId from Item I where I.ItemCode=#tempRules.[SKUCode]),0) as ItemId,
        (SELECT [dbo].[fn_GetListOfItems] (#tempRules.[SKUCode])) as ItemId,
		#tempRules.[SKUCode]  ,
		#tempRules.[SKUname]  ,
		isnull((Select top 1 c.CompanyId from Company c where c.CompanyMnemonic=#tempRules.[Customerid]),0) as SoldTo,
		#tempRules.[Customerid] ,
		#tempRules.[CusomerName],
		#tempRules.[Totalallocation]  ,
		#tempRules.[MaxOrderQtyforpromotionalperiod]  ,
		#tempRules.[Startdateforpromotion]  ,
		#tempRules.[Enddateforpromotion],#tempRules.[AddOrDelete],#tempRules.[Description]   from #tempRules ) as ruleValidation where ISnull([SKUCode],'') !=''
		
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
