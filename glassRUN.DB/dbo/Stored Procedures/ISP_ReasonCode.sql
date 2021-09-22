CREATE PROCEDURE [dbo].[ISP_ReasonCode] --'<Json><ServicesAction>InsertReasonMappingCode</ServicesAction><ReasonCodeId>hhhhhhh</ReasonCodeId><ReasonDescription>fsdfg sdfsf</ReasonDescription><ObjectId>77668</ObjectId><ObjectType>Order</ObjectType><EventName>UpdateDeliveryLocation</EventName><LookupCategory>ChangeDeliveryLocationReason</LookupCategory><Action>Add</Action></ReasonCodeList></Json>'
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
   
        

Select * into #tmpReasonCode
	FROM OPENXML(@intpointer,'Json/ReasonCodeList',2)
        WITH
        (
            [ReasonCodeId] nvarchar(500),
            [ReasonDescription] nvarchar(max),
            [ObjectId] bigint,
            [ObjectType] nvarchar(50),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime,        
            [EventName] nvarchar(200),
			LookupCategory nvarchar(100),
			Action nvarchar(30)
            
        )tmp

		Declare @reasonCodeIdentity bigint=0
	Declare @reasonCodeId nvarchar(100)
	Declare @action nvarchar(50)
	SET @action=(Select top 1 Action from #tmpReasonCode)	
	SET @reasonCodeId=(Select top 1 [ReasonCodeId] from #tmpReasonCode)
    If @action = 'Add'
	BEGIN
	
		INSERT INTO [LookUp]
        (
    LookUpId     
    ,LookupCategory
    ,Name  
	,Code 
    ,[IsActive]
    ,[CreatedBy]
    ,[CreatedDate]
    

    
        )

        SELECT top 1
		(select top 1 LookUpId + 1 from LookUp order by LookUpId desc),
        (Select  top 1 LookUpCategoryId from LookUpCategory where Name=#tmpReasonCode.LookupCategory),
         #tmpReasonCode.[ReasonCodeId],  
		 1    ,           
         1,
		 1,
         GETDATE()          
          FROM #tmpReasonCode
		  SET @reasonCodeIdentity = (select top 1 LookUpId from LookUp order by LookUpId desc)
	END
	 
    
        Print @reasonCodeIdentity

   INSERT INTO [ReasonCodeObjectMapping]
        (
         
    [ReasonCodeId]
    ,[ReasonDescription]
    ,[ObjectId]
    ,[ObjectType]
    ,[IsActive]
    ,[CreatedBy]
    ,[CreatedDate]
    ,[EventName]

    
        )

        SELECT
        Case when @reasonCodeIdentity=0 then @reasonCodeId else @reasonCodeIdentity end, 
         tmp.[ReasonDescription],
         tmp.[ObjectId],
         tmp.[ObjectType],          
         1,
   1,
         GETDATE(),
   tmp.[EventName]
         
            FROM OPENXML(@intpointer,'Json/ReasonCodeList',2)
        WITH
        (
           -- [ReasonCodeId] bigint,
            [ReasonDescription] nvarchar(max),
            [ObjectId] bigint,
            [ObjectType] nvarchar(50),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime,        
            [EventName] nvarchar(200)
            
        )tmp

  Declare @ReasonCodeObjectMappingId bigint
  SET @ReasonCodeObjectMappingId = @@IDENTITY

        --Add child table insert procedure when required.
    SELECT @ReasonCodeObjectMappingId as ReasonCodeObjectMappingId FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
