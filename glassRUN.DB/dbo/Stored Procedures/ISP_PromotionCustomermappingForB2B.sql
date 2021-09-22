


CREATE PROCEDURE [dbo].[ISP_PromotionCustomermappingForB2B]--'<Json><ServicesAction>SavePromotionB2B</ServicesAction><PromotionList><CompanyId/><ItemCode>65705131</ItemCode><ItemQuanity>123</ItemQuanity><FocItemCode>988887702</FocItemCode><FocItemQuantity>35</FocItemQuantity><FromDate>14-Jan-2020</FromDate><ToDate>14-Mar-2020</ToDate><PromotionIdentifier>2345678</PromotionIdentifier><SystemPromotionIdentifier>988887701</SystemPromotionIdentifier><IsActive>1</IsActive><CreatedBy>10621</CreatedBy><FocItemUoM>11</FocItemUoM><NormalitemUoM>11</NormalitemUoM></PromotionList><PromotionList><CompanyId/><ItemCode>988887705</ItemCode><ItemQuanity>12</ItemQuanity><FocItemCode>65201001</FocItemCode><FocItemQuantity>124</FocItemQuantity><FromDate>15-Jan-2020</FromDate><ToDate>21-Mar-2020</ToDate><PromotionIdentifier>345677654</PromotionIdentifier><SystemPromotionIdentifier>988887703</SystemPromotionIdentifier><IsActive>1</IsActive><CreatedBy>10621</CreatedBy><FocItemUoM>10</FocItemUoM><NormalitemUoM>18</NormalitemUoM></PromotionList><PromotionList><CompanyId/><ItemCode>988887704</ItemCode><ItemQuanity>12</ItemQuanity><FocItemCode>65201001</FocItemCode><FocItemQuantity>12</FocItemQuantity><FromDate>15-Jan-2020</FromDate><ToDate>13-Feb-2020</ToDate><PromotionIdentifier>567890ty</PromotionIdentifier><SystemPromotionIdentifier>988887702</SystemPromotionIdentifier><IsActive>1</IsActive><CreatedBy>10621</CreatedBy><FocItemUoM>10</FocItemUoM><NormalitemUoM>12</NormalitemUoM><PromotionCustomerMappingList><CustomerId>10003</CustomerId><CustomerCode>76666001</CustomerCode><SystemPromotionIdentifier>988887702</SystemPromotionIdentifier><CompanyId>10001</CompanyId><IsActive>1</IsActive><CreatedBy>10621</CreatedBy></PromotionCustomerMappingList><PromotionCustomerMappingList><CustomerId>10020</CustomerId><CustomerCode>766660001</CustomerCode><SystemPromotionIdentifier>988887702</SystemPromotionIdentifier><CompanyId>10001</CompanyId><IsActive>1</IsActive><CreatedBy>10621</CreatedBy></PromotionCustomerMappingList></PromotionList></Json>'
  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
	  DECLARE @UserId bigint;
	  DECLARE @CarouselCount bigint;
	  declare @Response nvarchar(200);
      SET @ErrSeverity = 15; 
	  set @CarouselCount=0;
      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
							@xmlDoc 
				select Row_Number() Over(order by tmp1.PromotionIdentifier) as rownum,* into #tmpPromotionFocItemList

				FROM OPENXML(@intpointer,'Json/PromotionList',2)
				WITH
				(
				[CompanyId] bigint,
				[ItemCode] nvarchar(200),
				[ItemQuanity] bigint,
				[FocItemCode] nvarchar(200),
				[FocItemQuantity] bigint,
				[FromDate] nvarchar(200),
				[ToDate] nvarchar(200),
				[SystemPromotionIdentifier] nvarchar(200),
				[PromotionIdentifier] nvarchar(200),
				[FocItemUoM] nvarchar(200),
				[NormalitemUoM] nvarchar(200),
				CreatedBy bigint,
				IsActive bit,
				IsShowCarousel bit,
				CreatedDate datetime

				)tmp1


               select Row_Number() Over(order by tmp2.SystemPromotionIdentifier) as rownum,* into #tmpPromotionCustomerMappingList

				FROM OPENXML(@intpointer,'Json/PromotionList/PromotionCustomerMappingList',2)
				WITH
				(
				[CustomerId] bigint,
				[CustomerCode] nvarchar(200),
				[SystemPromotionIdentifier] nvarchar(200),
				[CompanyId] bigint,
				CreatedBy bigint,
				IsActive bit,
				IsSelectedCustomer bit,
				CreatedDate datetime
				)tmp2

				 select Row_Number() Over(order by tmp3.PromotionCode) as rownum,* into #tmpPromotionShowcaseList

				FROM OPENXML(@intpointer,'Json/PromotionList/ShowCaseCarouselList',2)
				WITH
				(
				[Base64Photo] nvarchar (max),
				[ImageUrl] nvarchar (max),
				[CustomerCode] nvarchar(200),
				[PromotionCode] nvarchar(200),
				[PromotionIdentifier] nvarchar(200),
				[PromotionDescription] nvarchar(200),
				[CarouselDescription] nvarchar(200),
				[CompanyId] bigint,
				[CultureId] bigint,
				[CreatedBy] bigint,
				[CompanyCode] nvarchar(200),
				[CompanyType] nvarchar(200),
				IsActive bit
				)tmp3
				
			
			select @CarouselCount= isnull(Count(*),0) from #tmpPromotionShowcaseList
			--print @CarouselCount
			--select *  from #tmpPromotionShowcaseList
				UPDATE [dbo].[PromotionFocItemDetail]
					SET [ItemCode] = msttmp1.[ItemCode]
					,[ItemQuanity] = msttmp1.[ItemQuanity]
					,[FocItemCode] = msttmp1.[FocItemCode]
					,[FocItemQuantity] = msttmp1.[FocItemQuantity]
					,[FromDate] = msttmp1.[FromDate]
					,[ToDate] = msttmp1.[ToDate]
					,[PromotionIdentifier] = msttmp1.[PromotionIdentifier]
					,[SystemPromotionIdentifier] = msttmp1.[SystemPromotionIdentifier]
					,[ItemUnitOfMeasure]=msttmp1.[NormalitemUoM]
					,[FocItemUnitOfMeasure]=msttmp1.[FocItemUoM]
					,[IsShowCarousel] = msttmp1.[IsShowCarousel]
					,[CompanyId] = msttmp1.[CompanyId]
					,[IsActive] = msttmp1.IsActive
					,[UpdatedBy] = msttmp1.CreatedBy
					,[UpdatedDate] = GetDate()
					from #tmpPromotionFocItemList msttmp1
					WHERE [PromotionFocItemDetail].[CompanyId]=msttmp1.[CompanyId] 
					and [PromotionFocItemDetail].[PromotionIdentifier]=msttmp1.[PromotionIdentifier] 
					and [PromotionFocItemDetail].[SystemPromotionIdentifier]=msttmp1.[SystemPromotionIdentifier]

			



		
			
					INSERT INTO [dbo].[PromotionFocItemDetail]
					([ItemCode]
					,[ItemQuanity]
					,[FocItemCode]
					,[FocItemQuantity]
					,[FromDate]
					,[ToDate]
					,[PromotionIdentifier]
					,[SystemPromotionIdentifier]
					,[ItemUnitOfMeasure]
					,[FocItemUnitOfMeasure]
					,[IsShowCarousel]
					,[CompanyId]
					,[IsActive]
					,[CreatedBy]
					,[CreatedDate])
					select 
					msttmp.[ItemCode],
					msttmp.[ItemQuanity],
					msttmp.[FocItemCode],
					msttmp.[FocItemQuantity],
					msttmp.[FromDate],
					msttmp.[ToDate],
					msttmp.[PromotionIdentifier],
					msttmp.[SystemPromotionIdentifier],
					msttmp.[NormalitemUoM],
					msttmp.[FocItemUoM],
					msttmp.[IsShowCarousel],
					msttmp.[CompanyId],
					msttmp.[IsActive],
					msttmp.[CreatedBy],
					Getdate()
					from #tmpPromotionFocItemList msttmp where msttmp.[SystemPromotionIdentifier] 
					not in(select [SystemPromotionIdentifier] from [PromotionFocItemDetail]  
						where [PromotionFocItemDetail].[CompanyId]=msttmp.[CompanyId] 
					and [PromotionFocItemDetail].[PromotionIdentifier]=msttmp.[PromotionIdentifier] 
					and [PromotionFocItemDetail].[SystemPromotionIdentifier]=msttmp.[SystemPromotionIdentifier])



			delete from  [PromotionCustomerMapping]  where [PromotionCustomerMapping].[SystemPromotionIdentifier] in (select   #tmpPromotionCustomerMappingList.[SystemPromotionIdentifier] from #tmpPromotionCustomerMappingList)
			and [PromotionCustomerMapping].CompanyId =(select  top 1 #tmpPromotionCustomerMappingList.[CompanyId] from #tmpPromotionCustomerMappingList)
		
			

			
			INSERT INTO [dbo].[PromotionCustomerMapping]
					   ([CustomerId]
					   ,[CustomerCode]
					   ,[SystemPromotionIdentifier]
					   ,[CompanyId]
					   ,[IsActive]
					   ,[CreatedBy]
					   ,[CreatedDate])
				 select 
						Childtmp.[CustomerId],
						Childtmp.[CustomerCode],
						Childtmp.[SystemPromotionIdentifier],
						Childtmp.[CompanyId],
						Childtmp.[IsActive],
						Childtmp.[CreatedBy],
						Getdate()
						from #tmpPromotionCustomerMappingList Childtmp

				 if @CarouselCount > 0
				 begin
				delete from  [ShowCase]  where [ShowCase].[SystemPromotionIdentifier]= (select  top 1 #tmpPromotionShowcaseList.[PromotionCode] from #tmpPromotionShowcaseList)

					INSERT INTO [dbo].[ShowCase]
							([SystemPromotionIdentifier]
							,[CultureId]
							,[Type]
							,[CompanyId]
							,[CompanyType]
							,[CompanyCode]
							,[ProductCode]
							,[ProductName]
							,[FromDate]
							,[ToDate]
							,[SmallImage]
							,[BigImage]
							,[Description]
							,[Title]
							,[IsActive]
							,[CreatedBy]
							,[CreatedDate])
							select 
							TmpShowCase.[PromotionCode],
							TmpShowCase.[CultureId],
							4102,
							msttmp.[CompanyId],
							TmpShowCase.[CompanyType],
							TmpShowCase.[CompanyCode],
							msttmp.[ItemCode],
							(select  top 1 ItemName from item where ItemCode=msttmp.[ItemCode]),
							msttmp.[FromDate],
							msttmp.[ToDate],
							TmpShowCase.[ImageUrl],
							TmpShowCase.[ImageUrl],
							TmpShowCase.[CarouselDescription],
							'',
							'1',
							msttmp.[CreatedBy],
							Getdate()
							from #tmpPromotionFocItemList msttmp join #tmpPromotionShowcaseList  TmpShowCase on TmpShowCase.PromotionCode=msttmp.[SystemPromotionIdentifier] 
							--where msttmp.[SystemPromotionIdentifier] 
							--not in(select [SystemPromotionIdentifier] from [PromotionFocItemDetail]  
							--where [PromotionFocItemDetail].[CompanyId]=msttmp.[CompanyId] 
							--and [PromotionFocItemDetail].[PromotionIdentifier]=msttmp.[PromotionIdentifier] 
							--and [PromotionFocItemDetail].[SystemPromotionIdentifier]=msttmp.[SystemPromotionIdentifier])

		 
				 end


			select top 1 @UserId= #tmpPromotionFocItemList.[CreatedBy] from #tmpPromotionFocItemList where isnull(#tmpPromotionFocItemList.[CreatedBy],0)!=0

           drop table #tmpPromotionFocItemList
		   drop table #tmpPromotionCustomerMappingList
		   drop table #tmpPromotionShowcaseList
		 set  @Response='Success';
	 	  SELECT @UserId as UserId,'Success' as Status FOR XML RAW('Json'),ELEMENTS

 

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
