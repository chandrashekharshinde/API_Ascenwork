Create PROCEDURE [dbo].[SSP_LoadRPM_ByEnquiryId] --'<Json><ServicesAction>GetNoteByObjectId</ServicesAction><ObjectId>11904</ObjectId><RoleId>4</RoleId><ObjectType>1220</ObjectType></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @enquiryId BIGINT


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @enquiryId = tmp.[EnquiryId]
	

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EnquiryId] bigint
				
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT  'true' AS [@json:Array]  ,  [ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
	  ,(SELECT top 1 ItemId FROM dbo.Item WHERE ItemCode=[ProductCode] and IsActive=1) AS ItemId
	  ,(SELECT top 1 ItemName FROM dbo.Item WHERE ItemCode=[ProductCode] and IsActive=1) AS ItemName

	    ,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure


		
	
      ,rpm.[ProductType]
      ,rpm.[ProductQuantity]
	
	  ,i.StockInQuantity
	   ,i.ItemShortCode
	    ,rpm.ItemType
		from [ReturnPakageMaterial] rpm left join Item i on rpm.ProductCode = i.ItemCode
			
   WHERE rpm.IsActive = 1 AND rpm.EnquiryId = @enquiryId  
	FOR XML path('ReturnPakageMaterialList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
