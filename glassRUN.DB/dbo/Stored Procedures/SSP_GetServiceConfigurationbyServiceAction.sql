CREATE PROCEDURE [dbo].[SSP_GetServiceConfigurationbyServiceAction] --'<Json><ServicesAction>ca1</ServicesAction></Json>'
(
@ServicesAction nvarchar(250)
)
AS



BEGIN

-----only pass service action --







	SELECT ServicesURL , RequestFormat from ServiceConfiguration where ServiceConfiguration.IsActive=1 and ServiceConfiguration.ServicesAction=@ServicesAction FOR XML RAW('Json'),ELEMENTS

END
