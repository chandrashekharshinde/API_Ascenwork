﻿Create PROCEDURE [dbo].[SSP_CompanyTransporterMappingId]
(
@xmlDoc XML
)
AS

BEGIN
				[CompanyId],
				[TransporterId],	
				[IsActive],
				
				[CompanyId],
				[TransporterId] as Id,	
				[IsActive]
				from CompanyTransporterMapping op  where op.CompanyId = ctm.CompanyId and op.isactive=1