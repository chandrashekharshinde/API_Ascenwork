CREATE FUNCTION [dbo].[SSP_GetSpecificEventrecipientbyEventCode](@EventMasterId Bigint,@EventNotificationId Bigint,@RoleMasterId Bigint)
RETURNS @UserDetails TABLE (
   EmailId VARCHAR(255),
   LoginId bigint
    )
	
BEGIN
-- *****
-- THIS FUNCTION IS USED ONLY IN CASE OF EMAIL NEED TO BE SEND TO SPECIFIC USER
-- *****

Declare @EventCode NVARCHAR(100);
Declare @RoleName NVARCHAR(100);

SELECT top 1 @EventCode=lower(EventCode) FROM eventMaster WHERE EventMasterId=@EventMasterId
SELECT top 1 @RoleName=lower(RoleName) FROM RoleMaster WHERE RoleMasterId=@RoleMasterId

Declare @ObjectType NVARCHAR(100);
Declare @ObjectId  BIGINT 

SELECT Top 1 @ObjectType=  lower(ObjectType) FROM EventNotification  WHERE EventNotificationId=@EventNotificationId
SELECT Top 1 @ObjectId=  lower(ObjectId) FROM EventNotification  WHERE EventNotificationId=@EventNotificationId

IF(@ObjectType='Order') -- Notifications related to Order
BEGIN
	IF(@RoleName='Customer') -- Contact information for customer
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  AND objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		l.LoginId    FROM [order]  o  
		JOIN  Login  l ON l.ReferenceId  = o.SoldTo AND l.ReferenceType in (22,24,25) and l.RoleMasterId=4 WHERE o.OrderId=@ObjectId
		UNION
		SELECT isnull(c.Contacts,'')EmailId, 0 as LoginId   FROM  [order] o LEFT JOIN ContactInformation c  ON c.ObjectId=o.SoldTo  AND c.ObjectType='Company'  and c.ContactType='Email'
		JOIN EventNotification  e ON e.ObjectId = o.OrderId     WHERE o.OrderId=@ObjectId

	END 
	ELSE IF(@RoleName='Carrier') -- Contact information for carrier
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		 l.LoginId    FROM [order]  o  
		  JOIN  Login  l ON l.ReferenceId  = o.CarrierNumber   and   l.ReferenceType=28 and l.RoleMasterId=7   WHERE o.OrderId=@ObjectId
		UNION
		SELECT isnull(c.Contacts,'')EmailId, 0 as LoginId   FROM  [order] o left join ContactInformation c  ON c.ObjectId=o.CarrierNumber  and c.ObjectType='Company'  and c.ContactType='Email'
		JOIN EventNotification  e on e.ObjectId = o.OrderId   WHERE o.OrderId=@ObjectId

	END
	ELSE IF(@RoleName='Driver') -- Contact information for driver
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		 l.LoginId    FROM [order]  o  
		 JOIN OrderMovement   om ON om.OrderId= o.OrderId
		 JOIN  Login  l ON l.LoginId  = om.DeliveryPersonnelId and l.RoleMasterId=8 WHERE o.OrderId=@ObjectId 

	END
	ELSE IF(@RoleName='CustomerService') -- Contact information for carrier
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		 l.LoginId    FROM [order]  o  
		  JOIN  Login  l ON l.ReferenceId  = o.CompanyId   AND l.ReferenceType in (22,24,25) and l.RoleMasterId=3   WHERE o.OrderId=@ObjectId
		UNION
		SELECT isnull(c.Contacts,'')EmailId, 0 as LoginId   FROM  [order] o left join ContactInformation c  ON c.ObjectId=o.CompanyId  and c.ObjectType='Company'  and c.ContactType='Email'
		JOIN EventNotification  e on e.ObjectId = o.OrderId   WHERE o.OrderId=@ObjectId

	END
END

IF(@ObjectType='Enquiry') -- Notifications related to Enquiry
BEGIN
	IF(@RoleName='Customer') -- Contact information for customer
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  AND objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		l.LoginId    FROM [Enquiry]  E 
		JOIN  Login  l ON l.ReferenceId  = E.SoldTo AND l.ReferenceType in (22,24,25) and l.RoleMasterId=4 WHERE E.EnquiryID=@ObjectId
		UNION
		SELECT isnull(c.Contacts,'')EmailId, 0 as LoginId   FROM  [Enquiry] E LEFT JOIN ContactInformation c  ON c.ObjectId=E.SoldTo  AND c.ObjectType='Company'  and c.ContactType='Email'
		JOIN EventNotification  en ON en.ObjectId = E.EnquiryId     WHERE E.EnquiryID=@ObjectId

	END 
	ELSE IF(@RoleName='Carrier') -- Contact information for carrier
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		 l.LoginId    FROM [Enquiry]  eq  
		  JOIN  Login  l ON l.ReferenceId  = eq.CarrierId   and   l.ReferenceType=28  and l.RoleMasterId=7   WHERE eq.EnquiryId=@ObjectId
		UNION
		SELECT isnull(c.Contacts,'')EmailId, 0 as LoginId   FROM  [Enquiry] eq left join ContactInformation c  ON c.ObjectId=eq.CarrierId  and c.ObjectType='Company'  and c.ContactType='Email'
		JOIN EventNotification  e on e.ObjectId = eq.EnquiryId   WHERE eq.EnquiryId=@ObjectId

	END
	ELSE IF(@RoleName='CustomerService') -- Contact information for carrier
	BEGIN
		INSERT @UserDetails
		SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
		 l.LoginId    FROM [Enquiry]  eq  
		  JOIN  Login  l ON l.ReferenceId  = eq.CompanyId   AND l.ReferenceType in (22,24,25) and l.RoleMasterId=3   WHERE eq.EnquiryId=@ObjectId
		UNION
		SELECT isnull(c.Contacts,'')EmailId, 0 as LoginId   FROM  [Enquiry] eq left join ContactInformation c  ON c.ObjectId=eq.CompanyId  and c.ObjectType='Company'  and c.ContactType='Email'
		JOIN EventNotification  e on e.ObjectId = eq.EnquiryId   WHERE eq.EnquiryId=@ObjectId

	END
END

ELSE IF (@ObjectType='Login') -- Notifications related to Login
BEGIN 
	INSERT @UserDetails
	SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
	 l.LoginId   FROM  Login  l     WHERE l.LoginId=@ObjectId
END

ELSE IF (@ObjectType='Company') -- Notifications related to Company. e.g. Notify Allocation
BEGIN 
	INSERT @UserDetails
	SELECT isnull((SELECT Top 1 Contacts FROM ContactInformation WHERE objectid=c.CompanyID  and objecttype='Company'   and Contacttype='Email' ),'')EmailId,
	 c.CompanyId FROM Company c WHERE c.CompanyId=@ObjectId
	 UNION
	
		
			SELECT isnull((SELECT   Top 1 Contacts   FROM  ContactInformation  WHERE  objectid=l.LoginId  and objecttype='Login'   and Contacttype='Email' ),'')EmailId,
	 l.LoginId   FROM  Login  l     WHERE l.ReferenceId=@ObjectId 
END


RETURN  
END


