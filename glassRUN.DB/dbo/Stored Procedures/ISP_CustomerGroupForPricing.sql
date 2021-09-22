


CREATE PROCEDURE [dbo].[ISP_CustomerGroupForPricing]-- ''
  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
	  DECLARE @UserId bigint;

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
							@xmlDoc 
				select Row_Number() Over(order by tmp1.GroupCode) as rownum,* into #tmpcustomerGroupList

				FROM OPENXML(@intpointer,'Json/CustomerGroupList',2)
				WITH
				(
				[CompanyId] bigint,
				[CustomerPriceGroup] nvarchar(200),
				GroupCode nvarchar(200),
				CreatedBy bigint,
				IsActive bit,
				CreatedDate datetime

				)tmp1


               select Row_Number() Over(order by tmp2.GroupCode) as rownum,* into #tmpChildGroupList

				FROM OPENXML(@intpointer,'Json/CustomerGroupList/ChildGroupList',2)
				WITH
				(
				[CompanyId] bigint,
				[CustomerPriceGroup] nvarchar(200),
				CustomerNumber nvarchar(200),
				GroupCode nvarchar(200),
				CreatedBy bigint,
				IsActive bit,
				IsSelectedGroup bit,
				CreatedDate datetime
				)tmp2


				
			UPDATE [dbo].[CustomerGroupForPricing]
			SET 
			 [CustomerPriceGroup] = msttmp1.[CustomerPriceGroup]
			,[GroupCode] = msttmp1.[GroupCode]
			,[IsActive] = msttmp1.[IsActive]
			,[CreatedBy] = msttmp1.[CreatedBy]
			,[CreatedDate] = msttmp1.[CreatedDate]
			from #tmpcustomerGroupList msttmp1
			WHERE [CustomerGroupForPricing].[CompanyId]=msttmp1.[CompanyId] 
			and [CustomerGroupForPricing].[GroupCode]=msttmp1.[GroupCode] 
			and [CustomerGroupForPricing].[CustomerPriceGroup]=msttmp1.[CustomerPriceGroup]

			

		   INSERT INTO [dbo].[CustomerGroupForPricing]
           ([CustomerGroupID]
           ,[CustomerPriceGroup]
           ,[GroupCode]
           ,[CompanyId]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
			select 
			(Select (select top 1 CustomerGroupID  from CustomerGroupForPricing order by 1 desc) + 1),
			msttmp.[CustomerPriceGroup],
			msttmp.[GroupCode],
			msttmp.[CompanyId],
			msttmp.[IsActive],
			msttmp.[CreatedBy],
			msttmp.[CreatedDate]
			from #tmpcustomerGroupList msttmp where msttmp.[CustomerPriceGroup] 
			not in(select [CustomerPriceGroup] from [CustomerGroupForPricing]  
			where [CustomerPriceGroup]=msttmp.[CustomerPriceGroup]
			 and CompanyId=msttmp.[CompanyId] 
			and [CustomerGroupForPricing].[GroupCode]=msttmp.[GroupCode])


		
			--UPDATE [dbo].[CustomerMasterForPricing]
			--SET [CustomerNumber] = Childtmp1.[CustomerNumber]
			--,[CustomerPriceGroup] = Childtmp1.[CustomerPriceGroup]
			--,[IsActive] = '0'
			--,[ModifiedDate] = Childtmp1.[CreatedDate]
			--,[ModifiedBy] = Childtmp1.[CreatedBy]
			--from #tmpChildGroupList Childtmp1
			--WHERE [CustomerMasterForPricing].[CustomerPriceGroup]=Childtmp1.[CustomerPriceGroup] 
			--and [CustomerMasterForPricing].[CompanyId]=Childtmp1.[CompanyId] 
			--and isnull([CustomerMasterForPricing].IsActive,'0')!='0'

			--UPDATE [dbo].[CustomerMasterForPricing]
			--SET [CustomerNumber] = Childtmp1.[CustomerNumber]
			--,[CustomerPriceGroup] = Childtmp1.[CustomerPriceGroup]
			--,[IsActive] ='1'
			--,[ModifiedDate] = Childtmp1.[CreatedDate]
			--,[ModifiedBy] = Childtmp1.[CreatedBy]
			--from #tmpChildGroupList Childtmp1
			--WHERE [CustomerMasterForPricing].[CustomerPriceGroup]=Childtmp1.[CustomerPriceGroup] 
			--and [CustomerMasterForPricing].[CompanyId]=Childtmp1.[CompanyId]
			-- and isnull(Childtmp1.IsSelectedGroup,'0')!='0'

			delete from  [CustomerMasterForPricing] where [CustomerPriceGroup] in (select   #tmpChildGroupList.[CustomerPriceGroup] from #tmpChildGroupList)
			and CompanyId =(select  top 1 #tmpChildGroupList.CompanyId from #tmpChildGroupList)
			-- where #tmpChildGroupList.[CustomerPriceGroup] and #tmpChildGroupList[CompanyId]=[CompanyId]
			

		INSERT INTO [dbo].[CustomerMasterForPricing]
           ([CustomerNumber]
           ,[CustomerPriceGroup]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[CompanyId])
    
			select 
			Childtmp.[CustomerNumber],
			Childtmp.[CustomerPriceGroup],
			Childtmp.[IsActive],
			Childtmp.[CreatedDate],
			Childtmp.[CreatedBy],
			Childtmp.[CompanyId]
			from #tmpChildGroupList Childtmp --where Childtmp.[CustomerPriceGroup]
			--not in(select [CustomerPriceGroup] from [CustomerMasterForPricing]  where [CustomerPriceGroup]=Childtmp.[CustomerPriceGroup] and CompanyId=Childtmp.[CompanyId])


			select top 1 @UserId= #tmpChildGroupList.[CreatedBy] from #tmpChildGroupList where isnull(#tmpChildGroupList.[CreatedBy],0)!=0

           drop table #tmpChildGroupList
		   drop table #tmpcustomerGroupList

		  SELECT @UserId as UserId FOR XML RAW('Json'),ELEMENTS

  --     WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		--SELECT CAST((SELECT 'true' AS [@json:Array],
		--1 AS CompanyId ,'Success' as Status
		--FOR XML path('ServicesAction'),ELEMENTS,ROOT('Json')) AS XML)

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
