
CREATE PROCEDURE [dbo].[SSP_GetServiceConfigurationbyServiceActionV2] --'<Json><ServicesAction>ca1</ServicesAction></Json>'
(
@ServicesAction nvarchar(250)
)
AS
BEGIN
-----only pass service action --
	SELECT ServicesURL , RequestFormat from ServiceConfiguration with (NOLOCK)
	where ServiceConfiguration.IsActive=1 and ServiceConfiguration.ServicesAction=@ServicesAction 

END