CREATE PROCEDURE [dbo].[SSP_LoadPageControlsByPageId]-- '<Json><ServicesAction>LoadPageControlsByPageId</ServicesAction><PageId>7</PageId></Json>'
@xmlDoc XML
AS 
 BEGIN 
	
	DECLARE @intPointer INT
Declare @pageId Nvarchar(100)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@pageId = tmp.[PageId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
      [PageId] bigint
   )tmp;


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

Select Cast((SELECT 
      PageName
	  ,PageId
       ,  
	  (Cast((SELECT  'true' AS [@json:Array]  , [PageControlId] ,
	pc.[PageId] ,
	
	ControlName,
	[DisplayName] ,
	[IsActive] 
		
  FROM PageControl pc 
  
   WHERE pc.IsActive = 1 and pc.PageId = @pageId
	
	 FOR XML path('PageControlList'),ELEMENTS) AS xml))
 

    from Pages p where PageId = @pageId
and p.IsActive = 1

   
  
  FOR XML PATH('Page'),ELEMENTS,ROOT('Json')) AS XML)
 
END
