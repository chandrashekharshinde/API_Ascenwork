-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.LoginHistory table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_LoginHistory] --'<LoginHistory xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ObjectId>0</ObjectId><TotalCount>0</TotalCount><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>0</CreatedBy><UpdatedBy>1</UpdatedBy><LoginHistoryId>3</LoginHistoryId><LoginId>1</LoginId><LogoutType>ByUser</LogoutType><LoggingOutTime>2016-02-23T16:24:17.5906503+05:30</LoggingOutTime><LoginHistoryList /></LoginHistory>'

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

	
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @LoginHistoryId bigint
			 DECLARE @LoggingInTime DateTime

			 SELECT * INTO #TempLoginHistory FROM OPENXML(@intpointer,'LoginHistory',2)
			   WITH
     (
	 [LoginHistoryId] bigint
	 )tmp


	 Select * From #TempLoginHistory
	 Set @LoggingInTime = (Select LoggingInTime From LoginHistory Where [LoginHistoryId]= (SELECT [LoginHistoryId] FROM #TempLoginHistory))

	 Print @LoggingInTime

            UPDATE dbo.LoginHistory SET
        	[LoginId]=tmp.LoginId ,
        	[LogoutType]=tmp.LogoutType ,
			LoggingInTime =@LoggingInTime,
        	[LoggingOutTime]=tmp.LoggingOutTime ,
        	[IsActive]=tmp.IsActive ,
        	[CreatedFromIPAddress]=tmp.CreatedFromIPAddress ,
        	[UpdatedDate]=GETDATE(),
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'LoginHistory',2)
			WITH
			(
            [LoginHistoryId] bigint,
           
            [LoginId] bigint,
           
            [LogoutType] nvarchar(100),
           
           
            [LoggingOutTime] datetime,
           
            [IsActive] bit,
           
            [CreatedFromIPAddress] nvarchar(20),
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE LoginHistory.[LoginHistoryId]=tmp.[LoginHistoryId]
            SELECT  @LoginHistoryId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_LoginHistory'
