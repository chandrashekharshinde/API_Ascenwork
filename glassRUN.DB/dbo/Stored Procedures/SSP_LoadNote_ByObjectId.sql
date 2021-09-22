CREATE PROCEDURE [dbo].[SSP_LoadNote_ByObjectId] --'<Json><ServicesAction>GetNoteByObjectId</ServicesAction><ObjectId>11904</ObjectId><RoleId>4</RoleId><ObjectType>1220</ObjectType></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @objectId BIGINT
declare @roleId BIGINT
declare @UserId BIGINT
declare @objectType nvarchar(50)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @objectId = tmp.[ObjectId],
	   @objectType = tmp.[ObjectType],
       @roleId = tmp.[RoleId],
	   @UserId = tmp.[UserId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ObjectId] bigint,
				[RoleId] bigint,
				[ObjectType] nvarchar(50),
				[UserId] bigint
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT 
	 'true' AS [@json:Array] ,
	 NotesId,
	 ObjectId,
	 ObjectType,
	 Note

	FROM Notes
	 where objectId = @objectId and ObjectType = @objectType and (RoleId in (select RoleId from NotesRoleWiseConfiguration where ViewNotesByRoleId = @roleId and ObjectType = @objectType) or CreatedBy = @UserId)
	FOR XML path('NotesList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
