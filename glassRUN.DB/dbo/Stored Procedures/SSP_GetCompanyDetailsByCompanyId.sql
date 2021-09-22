﻿CREATE PROCEDURE [dbo].[SSP_GetCompanyDetailsByCompanyId]
(
@xmlDoc XML
)
AS

BEGIN
				,fc.[TransporterId]
				,(Select  ct.CompanyName from Company ct where ct.CompanyId=fc.TransporterId) as Transporter
				,fc.[FinancePartnerId]
				,fc.[Amount]
				,convert(date,fc.[FromDate],103) as [FromDate]
				,convert(date,fc.[ToDate],103) as [ToDate]
				ObjectId  ,ObjectType   ,IsActive,DocumentTypeId  , (select  Name  from  LookUp  where LookUpId=DocumentTypeId)  as 'DocumentType' , 
				NEWID() as 'DocumentinfoGUID'   from Documents  where ObjectId=c.CompanyId   and ObjectType ='Company'
				FOR XML path('DocumentInformationList'),ELEMENTS) AS xml))