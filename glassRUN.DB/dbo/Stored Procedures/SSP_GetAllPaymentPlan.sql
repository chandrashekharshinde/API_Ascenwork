CREATE PROCEDURE [dbo].[SSP_GetAllPaymentPlan]

AS
BEGIN
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT DISTINCT
				'true' AS [@json:Array] ,
				p.[PaymentPlanId],
				p.[PlanName],
				p.[IsActive],
				p.[CreatedBy],
				p.[CreatedDate],
				p.[UpdatedBy],
				p.[UpdatedDate]
			FROM [dbo].[PaymentPlan] p
			Join [dbo].[PaymentSlab] ps on ps.PaymentPlanId=p.PaymentPlanId
			WHERE p.IsActive=1
			And ps.IsActive=1
		FOR XML path('PaymentPlanList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
