CREATE PROCEDURE [dbo].[ISP_ObjectVersion]-- '<ObjectVersion xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>1</CreatedBy><ObjectVersionId>0</ObjectVersionId><ObjectName>Order</ObjectName><VersionNumber>2.1</VersionNumber><ObjectVersionPropertiesList><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><ObjectVersionPropertiesId>0</ObjectVersionPropertiesId></ObjectVersionPropertiesList><ObjectVersionDefaultsList><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><ObjectVersionDefaultsId>0</ObjectVersionDefaultsId><DefaultValue>4</DefaultValue></ObjectVersionDefaultsList><ObjectVersionDefaultsList><ObjectId>2</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><ObjectVersionDefaultsId>0</ObjectVersionDefaultsId><DefaultValue>5</DefaultValue></ObjectVersionDefaultsList></ObjectVersion>'
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

			DECLARE @CreatedBy BIGINT
			SET @CreatedBy=( SELECT tmp.[CreatedBy] FROM OPENXML(@intpointer,'ObjectVersion',2) WITH([CreatedBy] bigint)tmp)
        INSERT INTO	[ObjectVersion]
        (
        	[ObjectId],
        	[ObjectName],
        	[VersionNumber],
        	[IsActive],        	
        	[CreatedBy],
        	[CreatedDate]
        )

        SELECT
        	tmp.[ObjectId],
        	tmp.[ObjectName],
        	tmp.[VersionNumber],
        	tmp.[IsActive],        	
        	@CreatedBy,
        	GETDATE()
            FROM OPENXML(@intpointer,'ObjectVersion',2)
        WITH
        (
            [ObjectId] bigint,
            [ObjectName] nvarchar(50),
            [VersionNumber] nvarchar(50),
            [IsActive] bit,           
            [CreatedBy] bigint,
            [CreatedDate] datetime
        )tmp
        
        DECLARE @ObjectVersion bigint
	    SET @ObjectVersion = @@IDENTITY

		 INSERT INTO	[ObjectVersionProperties]([ObjectVersionId],[ObjectId],[ObjectPropertyId],[Mandatory],	[ValidationExpression],[IsActive],[CreatedBy],[CreatedDate])

        SELECT
		@ObjectVersion,tmp.[ObjectId],tmp.[ObjectPropertyId],tmp.[Mandatory],tmp.[ValidationExpression],tmp.[IsActive],@CreatedBy,GETDATE()
		      FROM OPENXML(@intpointer,'ObjectVersion/ObjectVersionPropertiesList',2)
        WITH
        (
		[ObjectVersionId] BIGINT,
            [ObjectId] bigint,
            [ObjectPropertyId] bigint,
            [Mandatory] bit,
            [ValidationExpression] nvarchar(250),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
           
        )tmp



		INSERT INTO	[ObjectVersionDefaults]
        (
		[ObjectVersionId],
        	[ObjectId],
        	[ObjectPropertyId],
        	[DefaultValue],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        	
        )

        SELECT
		@ObjectVersion,
        	tmp.[ObjectId],
        	tmp.[ObjectPropertyId],
        	tmp.[DefaultValue],
        	tmp.[IsActive],
        	@CreatedBy,
        	GETDATE()
        
            FROM OPENXML(@intpointer,'ObjectVersion/ObjectVersionDefaultsList',2)
        WITH
        ([ObjectVersionId] BIGINT,

            [ObjectId] bigint,
            [ObjectPropertyId] bigint,
            [DefaultValue] nvarchar(500),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
           
        )tmp





        
        --Add child table insert procedure when required.
    
    SELECT @ObjectVersion
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
