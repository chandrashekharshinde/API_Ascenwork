CREATE PROCEDURE [dbo].[ISP_Notes] --'<Json><RequestDate>2017-10-26T00:00:00</RequestDate><EnquiryType>ST</EnquiryType><ShipTo>18</ShipTo><SoldTo>0</SoldTo><TruckSizeId>1</TruckSizeId><branchPlant>7</branchPlant><IsActive>true</IsActive><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CreatedBy>2</CreatedBy><OrderProductList><ItemId>97</ItemId><ItemName>Affligem Blond 300x24B Ctn</ItemName><ProductCode>65801001</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>1</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList><OrderProductList><ItemId>105</ItemId><ItemName>Desperados 330x12C Ctn</ItemName><ProductCode>65705131</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>3</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList></Json>'
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
			
				Declare @NotesId bigint

			    Declare @ObjectId bigint  
				Declare @ObjectType bigint
				Declare @RoleId bigint  
				Declare @CreatedBy bigint
				DECLARE @Note nvarchar(max)

			    SELECT @Note = tmp.[Note],
				@ObjectId = tmp.[ObjectId],
				@ObjectType = tmp.[ObjectType],
				@RoleId = tmp.[RoleId],
				@CreatedBy = tmp.[CreatedBy]
			   
			FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ObjectId] bigint,
			[ObjectType] bigint,
			[RoleId] bigint,
			[CreatedBy] bigint,
			[Note] NVARCHAR(max)
			
			)tmp 

			Declare @IsPresentOrNot bigint

			SET @IsPresentOrNot=(Select Count(NotesId) from Notes where ObjectId=@ObjectId and ObjectType = @ObjectType)
			if @IsPresentOrNot = 0
			Begin
				 INSERT INTO [dbo].[Notes]
			    (
			       [RoleId]
				  ,[ObjectId]
				  ,[ObjectType]
				  ,[Note]
				  ,[IsActive]
				  ,[CreatedBy]
				  ,[CreatedDate]
				  
			    )

			    SELECT
			    	@RoleId,
			    	@ObjectId,
			    	@ObjectType,        		
					@Note,
			    	1,
					@CreatedBy,
			    	GETDATE() 	

		 
		 SET @NotesId = @@IDENTITY
        	
		End
		Else
		Begin

			update notes set [Note] = @Note, ModifiedDate = GETDATE()  where ObjectId = @ObjectId and ObjectType = @ObjectType

			set @NotesId = (select NotesId from notes where ObjectId=@ObjectId and ObjectType = @ObjectType)
		End
		

        --Add child table insert procedure when required.
    SELECT @NotesId as NotesId FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
