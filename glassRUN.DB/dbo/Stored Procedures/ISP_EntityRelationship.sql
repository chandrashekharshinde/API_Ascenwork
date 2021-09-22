
CREATE PROCEDURE [dbo].[ISP_EntityRelationship]
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

		select ROW_NUMBER() OVER (ORDER BY PrimaryEntity) as rownumber ,* into #tempEntityRelationship
		FROM OPENXML(@intpointer,'Json/EntityRelationshipList',2)
			WITH
			(
				[PrimaryEntity] bigint,
				[RelatedEntity] bigint ,
				[RelationshipPurpose] bigint ,
				[RuleId] bigint ,
				[CompanyTypeId] bigint,
				[FromDate] datetime ,
				[ToDate] datetime ,
				[EntityRelationshipGUID] nvarchar(100) ,
				[IsActive] bit ,
				[CreatedBy] bigint 
            )tmp 




			Update [dbo].[EntityRelationship] Set IsActive=1 where PrimaryEntity in (Select PrimaryEntity from #tempEntityRelationship)


			DECLARE @site_value INT;
			DEClare @totalCount int;
			SET @site_value = 1;
			set @totalCount =(Select Count(*) from #tempEntityRelationship)

			WHILE @site_value <= @totalCount
			BEGIN
			  
			

			if exists (Select * from EntityRelationship es join #tempEntityRelationship tmpes on es.PrimaryEntity=tmpes.PrimaryEntity and es.RelatedEntity=tmpes.RelatedEntity where tmpes.rownumber=@site_value)
			 BEGIN
				Update [dbo].[EntityRelationship] Set IsActive=1,RuleId=tmpes.RuleId from #tempEntityRelationship tmpes where [EntityRelationship].PrimaryEntity=tmpes.PrimaryEntity and [EntityRelationship].RelatedEntity=tmpes.RelatedEntity
			 End
			 Else
			 BEGIN
			
			INSERT INTO [dbo].[EntityRelationship]
           ([PrimaryEntity]
           ,[RelatedEntity]
           ,[RelationshipPurpose]
           ,[RuleId]
		   ,[CompanyTypeId]
           ,[FromDate]
           ,[ToDate]
           ,[EntityRelationshipGUID]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy])

		   Select [PrimaryEntity]
           ,[RelatedEntity]
           ,[RelationshipPurpose]
           ,[RuleId]
		   ,[CompanyTypeId]
           ,[FromDate]
           ,[ToDate]
           ,[EntityRelationshipGUID]
           ,[IsActive]
           ,GETDATE()
           ,1 From #tempEntityRelationship Where rownumber=@site_value
		   End

			SET @site_value = @site_value + 1;
			END;



		




		DECLARE @EntityRelationshipId bigint
	    SET @EntityRelationshipId = @@IDENTITY

  		SELECT @EntityRelationshipId as EntityRelationshipId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
