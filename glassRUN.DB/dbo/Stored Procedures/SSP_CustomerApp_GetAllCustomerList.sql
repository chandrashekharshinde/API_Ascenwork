﻿

@companyId = tmp.CompanyId

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CompanyId bigint
			)tmp;