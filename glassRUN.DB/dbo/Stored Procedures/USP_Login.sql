-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.Login table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_Login]

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 
	Declare @guid nvarchar(500)
	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @LoginId bigint


			 Declare @roleId bigint
			 Declare @check bigint
  Declare @passwordExpire bigint
   Select * into #tmpRoleMaster  FROM OPENXML(@intpointer,'Login',2)
        WITH
        (
            RoleMasterId bigint
          
           
        )tmp

		SET @roleId=(Select  #tmpRoleMaster.RoleMasterId from #tmpRoleMaster)
		Print @roleId
	SET @check=(SELECT  Count(*) From PasswordPolicy p inner Join RolePasswordPolicyMapping rpm on rpm.PasswordPolicyId=p.PasswordPolicyId
  inner join RoleMaster r on r.RoleMasterId=rpm.RoleMasterId Where rpm.RoleMasterId=@roleId and p.IsActive=1)
  if @check > 0
  BEGIN
	SET @passwordExpire=	(SELECT  [PasswordExpiryPeriod] From PasswordPolicy p inner Join RolePasswordPolicyMapping rpm on rpm.PasswordPolicyId=p.PasswordPolicyId
  inner join RoleMaster r on r.RoleMasterId=rpm.RoleMasterId Where rpm.RoleMasterId=@roleId and p.IsActive=1)
  END
  ELSE
  BEGIN
  SET @passwordExpire=0
  END

  Print @passwordExpire


            UPDATE dbo.Login SET
			@guid=tmp.[GUID],
			@LoginId=tmp.[LoginId],
        	[ProfileId]=tmp.ProfileId ,
        	[UserName]=tmp.UserName ,
        	[HashedPassword]=tmp.HashedPassword ,
        	[PasswordSalt]=tmp.PasswordSalt ,
        	[LoginAttempts]=tmp.LoginAttempts ,
        	[AccessKey]=tmp.AccessKey ,
        	[LastLogin]=tmp.LastLogin ,
        	[ExpiryDate]=DATEADD(DAY, @passwordExpire, GETDATE()) ,
        	[LastPasswordChange]=GETDATE() ,
        	[ChangePasswordonFirstLoginRequired]=tmp.ChangePasswordonFirstLoginRequired ,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedDate]=getdate() ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress,
			[GUID] = null
            FROM OPENXML(@intpointer,'Login',2)
			WITH
			(
            [LoginId] bigint,
           
            [ProfileId] bigint,
           
            [UserName] nvarchar(50),

			 [GUID] nvarchar(500),
           
            [HashedPassword] nvarchar(50),
           
            [PasswordSalt] int,
           
            [LoginAttempts] int,
           
            [AccessKey] nvarchar(250),
           
            [LastLogin] datetime,
           
            [ExpiryDate] datetime,
           
            [LastPasswordChange] datetime,
           
            [ChangePasswordonFirstLoginRequired] bit,
           
            [IsActive] bit,
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE Login.[LoginId]=tmp.[LoginId] --Login.[GUID]=tmp.[GUID]

			--update Login set GUId=NULL where GUID=@guid
			--SELECT  @LoginId
            SELECT  @@ROWCOUNT
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Login'
