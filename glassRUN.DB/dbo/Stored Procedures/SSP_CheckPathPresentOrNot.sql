CREATE PROCEDURE [dbo].[SSP_CheckPathPresentOrNot] --'<Json><FilePathName>D:\Blankchq TFS\glassRUN Product\200 - SDLC\300 - Development\glassRUNProduct\glassRUNProduct\glassRUNService.WebAPI\App_Data\GratisOrder\GratisOrders Modified.xlsx</FilePathName><FileType>GratisOrder</FileType><IsActive>true</IsActive></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @pathFile nvarchar(500)
declare @fileType nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @pathFile = tmp.[FilePathName],@fileType = tmp.[FileType]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[FilePathName] nvarchar(500),
				[FileType] nvarchar(50)
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((
	select FilePathId,FilePathName,FileType from FilePath where IsActive=1 and FilePathName=@pathFile and FileType=@fileType
	FOR XML path('FilePathList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
