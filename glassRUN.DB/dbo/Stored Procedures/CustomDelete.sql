Create PROCEDURE  [dbo].[CustomDelete] 

@TableName NVARCHAR(1000),
@PrimeryKey  NVARCHAR(1000),
@Count INT OUTPUT
   
AS
BEGIN
   

   

DECLARE @sql NVARCHAR(1000)
DECLARE @ROWCOUNT int
DECLARE @name VARCHAR(500)
DECLARE @getname CURSOR
SET @getname = CURSOR FOR



SELECT 
sys.sysobjects.name
FROM 
sys.foreign_keys 
inner join sys.sysobjects ON
    sys.foreign_keys.parent_object_id = sys.sysobjects.id
WHERE 
referenced_object_id = OBJECT_ID(@TableName)
SET @Count=0
OPEN @getname
FETCH NEXT
FROM @getname INTO @name
WHILE @@FETCH_STATUS = 0
BEGIN
SET @sql='SELECT * FROM '+ @name +' where IsActive=1 and '+@PrimeryKey
PRINT @sql
EXEC (@sql)

SET @ROWCOUNT=@@Rowcount
SET @Count =@ROWCOUNT
IF @ROWCOUNT > 0

BREAK;

FETCH NEXT
FROM @getname INTO @name
END
CLOSE @getname
DEALLOCATE @getname
--PRINT  @ROWCOUNT

  
END
