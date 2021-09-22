CREATE PROCEDURE [dbo].[USP_ObjectVersion]-- '<ObjectVersion xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>1</CreatedBy><ObjectVersionId>7</ObjectVersionId><ObjectName>Order</ObjectName><VersionNumber>lo</VersionNumber><ObjectVersionPropertiesList><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><ObjectVersionPropertiesId>0</ObjectVersionPropertiesId><ObjectPropertyId>2</ObjectPropertyId><Mandatory>true</Mandatory></ObjectVersionPropertiesList><ObjectVersionDefaultsList><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><ObjectVersionDefaultsId>0</ObjectVersionDefaultsId><ObjectPropertyId>1</ObjectPropertyId><DefaultValue>fghfgh</DefaultValue></ObjectVersionDefaultsList><ObjectVersionDefaultsList><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><ObjectVersionDefaultsId>0</ObjectVersionDefaultsId><ObjectPropertyId>3</ObjectPropertyId><DefaultValue>25</DefaultValue></ObjectVersionDefaultsList></ObjectVersion>'

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
            DECLARE @ObjectVersionId bigint
            UPDATE dbo.ObjectVersion SET
			@ObjectVersionId=tmp.[ObjectVersionId],
        	[ObjectId]=tmp.ObjectId ,
        	[ObjectName]=tmp.ObjectName ,
        	[VersionNumber]=tmp.VersionNumber ,
        	[IsActive]=tmp.IsActive ,        	
        	[ModifiedBy]=1 ,
        	[ModifiedDate]=GETDATE()
            FROM OPENXML(@intpointer,'ObjectVersion',2)
			WITH
			(
            [ObjectVersionId] bigint,           
            [ObjectId] bigint,           
            [ObjectName] nvarchar(50),           
            [VersionNumber] nvarchar(50),           
            [IsActive] bit,     
            [ModifiedBy] bigint,           
            [ModifiedDate] datetime
           
            )tmp WHERE ObjectVersion.[ObjectVersionId]=tmp.[ObjectVersionId]
            SELECT  @ObjectVersionId


			SELECT * INTO #tmpObjectVersionProperties
			FROM OPENXML(@intpointer,'ObjectVersion/ObjectVersionPropertiesList',2)
			 WITH
             (
			 [ObjectVersionPropertiesId] BIGINT,
			[ObjectVersionId] BIGINT,
            [ObjectId] bigint,
            [ObjectPropertyId] bigint,
            [Mandatory] bit,
            [ValidationExpression] nvarchar(250),
            [IsActive] bit          
			 ) tmp			


			  SELECT * INTO #tmpObjectVersionDefaults
			FROM OPENXML(@intpointer,'ObjectVersion/ObjectVersionDefaultsList',2)
			 WITH
             (
			 [ObjectVersionDefaultsId] BIGINT,
			[ObjectId] bigint,
            [ObjectPropertyId] bigint,
			[ObjectVersionId] BIGINT,
            [DefaultValue] nvarchar(500),
            [IsActive] bit           
			 ) tmp


			  UPDATE ObjectVersionProperties SET IsActive=0 WHERE ObjectVersionId=@ObjectVersionId

			   UPDATE dbo.ObjectVersionProperties SET dbo.ObjectVersionProperties.Mandatory=#tmpObjectVersionProperties.Mandatory,
			 dbo.ObjectVersionProperties.[ValidationExpression]=#tmpObjectVersionProperties.[ValidationExpression],
			  dbo.ObjectVersionProperties.[IsActive]=#tmpObjectVersionProperties.[IsActive],dbo.ObjectVersionProperties.[ModifiedDate]=GETDATE(),dbo.ObjectVersionProperties.[ModifiedBy]=1
			FROM #tmpObjectVersionProperties WHERE dbo.ObjectVersionProperties.ObjectVersionPropertiesId=#tmpObjectVersionProperties.ObjectVersionPropertiesId

				
		 INSERT INTO	[ObjectVersionProperties]([ObjectVersionId],[ObjectId],[ObjectPropertyId],[Mandatory],	[ValidationExpression],[IsActive],[CreatedBy],[CreatedDate])
     SELECT  	@ObjectVersionId,#tmpObjectVersionProperties.[ObjectId],#tmpObjectVersionProperties.[ObjectPropertyId],#tmpObjectVersionProperties.[Mandatory],
	 #tmpObjectVersionProperties.[ValidationExpression],#tmpObjectVersionProperties.[IsActive],1,getdate()
            FROM #tmpObjectVersionProperties WHERE #tmpObjectVersionProperties.ObjectVersionPropertiesId =0

			 update ObjectVersionDefaults Set IsActive=0  WHERE ObjectVersionId=@ObjectVersionId

			 UPDATE ObjectVersionDefaults SET DefaultValue=#tmpObjectVersionDefaults.DefaultValue,[ObjectPropertyId]=#tmpObjectVersionDefaults.[ObjectPropertyId]
			 ,IsActive=#tmpObjectVersionDefaults.IsActive,ObjectVersionDefaults.[ModifiedDate]=getdate() from #tmpObjectVersionDefaults 
			 WHERE ObjectVersionDefaults.ObjectVersionDefaultsId=#tmpObjectVersionDefaults.ObjectVersionDefaultsId

			 		
		INSERT INTO	[ObjectVersionDefaults]([ObjectVersionId],[ObjectId],[ObjectPropertyId],[DefaultValue],[IsActive],[CreatedBy],[CreatedDate])
     SELECT  	@ObjectVersionId,#tmpObjectVersionDefaults.[ObjectId],#tmpObjectVersionDefaults.[ObjectPropertyId],#tmpObjectVersionDefaults.[DefaultValue],
	 #tmpObjectVersionDefaults.[IsActive],1,getdate() 
	 FROM #tmpObjectVersionDefaults WHERE #tmpObjectVersionDefaults.ObjectVersionDefaultsId =0





            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_ObjectVersion'
