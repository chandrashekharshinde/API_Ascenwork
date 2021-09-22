
CREATE PROCEDURE [dbo].[ISP_OrderDocumentType]
(
	@xmlDoc xml 
)
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
		DECLARE @LookUpId bigint

		Declare @LoginId bigint
Declare @PageName nvarchar(100)

		SELECT 
			@LoginId = tmp.[LoginId],
			@PageName = tmp.[PageName]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[LoginId] bigint,
			[PageName] nvarchar(100)
		)tmp ;

		
		select * into #tempLookUp
			  FROM OPENXML(@intpointer,'Json/LookUpList',2)
			WITH
			(
				[LookUpId] [bigint] ,
	[LookupCategory] [bigint] ,
	[Name] [nvarchar](500) ,
	[Code] [nvarchar](200) ,
	[Description] [nvarchar](500) ,
	[ShortCode] [nvarchar](150) ,
	[SortOrder] [bigint] ,
	[ResourceKey] [nvarchar](500) ,
	[Criteria] [nvarchar](500) ,
	[ParentId] [bigint] ,
	[Remarks] [nvarchar](max) ,
	[CreatedBy] [bigint] ,
	[CreatedDate] [datetime] ,
	[ModifiedBy] [bigint] ,
	[ModifiedDate] [datetime] ,
	[IsActive] [bit] ,
	[SequenceNo] [bigint] ,
	[Field1] [nvarchar](500) ,
	[Field2] [nvarchar](500) ,
	[Field3] [nvarchar](500) ,
	[Field4] [nvarchar](500) ,
	[Field5] [nvarchar](500) ,
	[Field6] [nvarchar](500) ,
	[Field7] [nvarchar](500) ,
	[Field8] [nvarchar](500) ,
	[Field9] [nvarchar](500) ,
	[Field10] [nvarchar](500) 
            )tmp  

			SET @LookUpId = (select MAX(LookUpId)+1 FROM LookUp where LookupCategory = (select LookUpCategoryId from LookupCategory where Name = 'OrderDocument'))

			INSERT INTO [LookUp] ( 
			LookUpId,LookupCategory,Name,IsActive,CreatedBy,CreatedDate 
			) 
			SELECT 
			@LookUpId,
			(select LookUpCategoryId from LookupCategory where Name = 'OrderDocument'), 
			#tempLookUp.[Name], 
			#tempLookUp.[IsActive], 
			#tempLookUp.[CreatedBy], 
			GETDATE()
			from #tempLookUp  

	    

		print @LookUpId
		

INSERT INTO [dbo].[UserDimensionMapping]
           ([UserId]
           ,[RoleMasterId]
           ,[DimensionName]
           ,[PageName]
           ,[OperatorType]
           ,[DimensionValue]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[UpdatedBy]
           ,[UpdatedDate])
     VALUES
           (@LoginId
           ,NULL
           ,'LookUpId'
           ,@PageName
           ,1
           ,@LookUpId
           ,1
           ,@LoginId
           ,GETDATE()
           ,NULL
           ,NULL)

  		SELECT @LookUpId as LookUpId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END