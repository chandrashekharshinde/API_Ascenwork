
CREATE PROCEDURE [dbo].[ISP_UserDimension] --'<Json><ServicesAction>SaveDimensionMapping</ServicesAction><PropertyMappingList><PropertyGUID>0ce2eb53-529b-459b-889e-6e382efc7644</PropertyGUID><UserDimensionMappingId>0</UserDimensionMappingId><RoleId>3</RoleId><PageId>9</PageId><PageName>SalesAdminApproval</PageName><UserId>467</UserId><ControlId>1</ControlId><PropertyName>AssociatedOrder</PropertyName><ControlType>Equal</ControlType><ControlTypeId>Equal</ControlTypeId><ControlValue>12</ControlValue><IsActive>true</IsActive></PropertyMappingList></Json>'  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @CompanyId BIGINT 

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

          INSERT INTO [dbo].UserDimensionMapping 
                      (UserId,
					  RoleMasterId,
					  ControlId,
					  PageName,
					  OperatorType,
					  DimensionName,
					  DimensionValue,
					  IsActive,
					  CreatedBy,
					  CreatedDate) 
          SELECT tmp.[UserId], 
                 tmp.[RoleId], 
				 tmp.[ControlId], 
				 tmp.[ControllerName], 
				 tmp.ControlType,
				 tmp.[PropertyName], 
				 tmp.[ControlValue],
                 1, 
                                  1 ,
								  Getdate()
                  
          FROM   OPENXML(@intpointer, 'Json/PropertyMappingList', 2) 
                    WITH ( [UserId]         NVARCHAR(500), 
                           [RoleId]     NVARCHAR(200), 
                           [ControlId]      NVARCHAR(50),
						   [ControllerName]      NVARCHAR(50), 
                           [PageName]			NVARCHAR(200), 
						   [ControlType]        NVARCHAR(max), 
                           [PropertyName]       NVARCHAR(max), 
						   [ControlValue] nvarchar(max)
                           )tmp 

          SET @CompanyId = @@IDENTITY 

          --INSERT INTO DimensionSPMapping 
          --            ([DimensionName],
					   		--			   [PageName], 
          --             [isactive], 
          --             [createdby], 
          --             [createddate]) 
          --SELECT 
          --       tmp1.[PropertyName], 
          --       tmp1.[PageName],
          --       1,
          --       1,
          --       Getdate() 
          --FROM   OPENXML(@intpointer, 'Json/PropertyMappingList', 2) 
          --          WITH ( 
          --                 [PropertyName]  NVARCHAR(max), 
          --                 [PageName]  NVARCHAR(max)
						    --)tmp1 

          SELECT @CompanyId AS CompanyId 
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

































