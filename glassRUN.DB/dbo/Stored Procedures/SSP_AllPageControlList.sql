CREATE PROCEDURE [dbo].[SSP_AllPageControlList] --'<Json><ServicesAction>GetAllPageControlList</ServicesAction><ControlType>2</ControlType><CultureId>1101</CultureId><PageId>9</PageId></Json>'
(
@xmlDoc XML
)
AS	
BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

Declare @PageId Nvarchar(100)
Declare @ControlType nvarchar(100)='0'
Declare @ControlType1 nvarchar(100)='2'
Declare @CultureId nvarchar(100)
SELECT  
		@PageId = tmp.[PageId],
		@ControlType=tmp.[ControlType],
		@CultureId=tmp.[CultureId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [PageId] bigint,
   [ControlType] bigint,
   [CultureId]	bigint
   )tmp;


set @ControlType1 = case when @ControlType='2002' then 2002 else 2 end;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], [PageControlId] as ObjectId
      ,[PageId]
      ,[ResourceKey]
	  ,ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = pc.ResourceKey and CultureId = @CultureId),pc.[DisplayName]) as DisplayName
      ,[ControlType]
      ,[ControlName]
      ,[DataSource]
      ,[DataType]
  FROM [dbo].[PageControl] pc where (PageId = @PageId or @PageId=0) and [ControlType] in (@ControlType1,@ControlType) 
  
  FOR XML path('PageControlList'),ELEMENTS,ROOT('PageControl')) AS XML)
END
