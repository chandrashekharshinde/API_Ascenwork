

CREATE PROCEDURE [dbo].[ISP_FavouriteItemForB2BApp]
  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

	select * into #FavouriteItemList
FROM OPENXML(@intpointer,'Json/FavouriteItemList',2)
WITH
(
[CompanyId] bigint
)tmp1

declare @CompanyId bigint
set @CompanyId = (select ReferenceId from Login where LoginId = (select top 1 #FavouriteItemList.[CompanyId] from #FavouriteItemList))

delete from FavouriteItem where CompanyId = @CompanyId


          INSERT INTO [dbo].[FavouriteItem]
           ([CompanyId]
           ,[ItemId]
           ,[ItemCode]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]) 
          SELECT @CompanyId, 
                 tmp.[ItemId], 
                 tmp.[ItemCode], 
                 1, 
                 tmp.[CreatedBy],
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/FavouriteItemList', 2) 
                    WITH ( [CompanyId]           bigint, 
                           [ItemId]             bigint, 
                           [ItemCode] nvarchar(50), 
                           [CreatedBy]   bigint )tmp 

          DECLARE @FavouriteItemId BIGINT 

          SET @FavouriteItemId = @@IDENTITY 

          --Add child table insert procedure when required. 
          SELECT @FavouriteItemId AS FavouriteItemId 
          FOR xml raw('Json'), elements 

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
