CREATE PROCEDURE [dbo].[SSP_GetServicesConfigURLByAction] --'<Json><ServicesAction>LoadWorklfowList</ServicesAction><CompanyId>0</CompanyId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)

DECLARE @ServicesAction nvarchar(500)
DECLARE @EnquiryAutoNumberCriteria nvarchar(50)


set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ServicesAction = tmp.[ServicesAction]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ServicesAction] nvarchar(500)
			)tmp



--select cast ((select * from ServiceConfiguration where IsActive=1 and ServicesAction=@ServicesAction FOR XML RAW('ServiceConfigurationList'),ELEMENTS,ROOT('Json')) AS XML)

select ServicesURL from ServiceConfiguration where IsActive=1 and ServicesAction=@ServicesAction


END
