﻿

CREATE PROCEDURE [dbo].[SSP_AllDriverListForSecurityApp]--'<Json><ServicesAction>LoadAllDriverListForSecurityApp</ServicesAction><CarrierId>0</CarrierId><Driver>trin</Driver></Json>'
     ORDER BY [name] ) as rownumber  from [Login] tv where ( tv.Name like '%'+@Driver+'%' or @Driver='') 