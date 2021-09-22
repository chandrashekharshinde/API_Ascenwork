CREATE PROCEDURE [dbo].[SSP_AllTruckSizeList] 
AS
BEGIN





WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] , [TruckSizeId]
				  ,[TruckSize]
				  ,[TruckCapacityPalettes]
				  ,[TruckCapacityWeight]
				  ,[IsActive]
				   FROM [TruckSize] WHERE IsActive = 1 and ISNULL([TruckCapacityWeight],0) != 0
	FOR XML path('TruckSizeList'),ELEMENTS,ROOT('TruckSize')) AS XML)
END
