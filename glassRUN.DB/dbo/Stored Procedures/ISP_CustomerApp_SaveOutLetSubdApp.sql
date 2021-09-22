
CREATE PROCEDURE [dbo].[ISP_CustomerApp_SaveOutLetSubdApp] --'<Json><ServicesAction>SaveOutletForSubdApp</ServicesAction><OutletList><CustomerId>66</CustomerId><Companyid>1</Companyid><CreatedBy>536</CreatedBy></OutletList></Json>'
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @EntityRelationshipId BIGINT 
	 set @EntityRelationshipId=0;
      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 
			select *  into #OutletDetails
				FROM OPENXML(@intpointer,'Json/OutletList',2)
				WITH
				(
					[CustomerId] bigint,
					[Companyid] bigint,
					[CreatedBy] bigint
					
				)tmp	

  delete from [EntityRelationship] where [PrimaryEntity] = (select top 1 #OutletDetails.CustomerId from #OutletDetails)
INSERT INTO [dbo].[EntityRelationship]
           ([PrimaryEntity]
           ,[RelatedEntity]
           ,[RelationshipPurpose]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy])
           Select #OutletDetails.CustomerId,#OutletDetails.[Companyid],(select top 1 LookUpId from LookUp where Name='OrderTo'),1,Getdate(),[CreatedBy] from #OutletDetails;

		   set @EntityRelationshipId=SCOPE_IDENTITY();

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
			SELECT CAST((SELECT   'true' AS [@json:Array],
            @EntityRelationshipId AS EntityRelationshipId , (case when @EntityRelationshipId=0 then 'Faild' else 'Success'end ) as Status
          FOR XML path('OutletDetails'),ELEMENTS,ROOT('Json')) AS XML)

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 
          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
