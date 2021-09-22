﻿

			FROM OPENXML(@intpointer,'Json/OutletTypeList',2)
			WITH
			(
				[OutletType] nvarchar(2000)
			)tmp1;
AddressLine2,
logo
c.CompanyMnemonic as Code,
c.Field5 as OutletType,
c.AddressLine1,
c.AddressLine2,
(case when isnull(c.logo,0)=0 then 0 else c.logo end) logo,

CASE WHEN (select count(*) from [EntityRelationship] fi where fi.[RelatedEntity] = c.CompanyId and fi.PrimaryEntity=@companyId) = 0 THEN 0 ELSE 1 END As IsItemCatalog,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactNumber,
(select top 1 ContactPerson from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactPerson
From company c where c.IsActive=1  and CompanyType=24 --and  c.Field5 in( select OutletType from  #OutletTypeList)
AddressLine2,
logo
c.CompanyMnemonic as Code,
c.Field5 as OutletType,
c.AddressLine1,
c.AddressLine2,
(case when isnull(c.logo,0)=0 then 0 else c.logo end) logo,

CASE WHEN (select count(*) from [EntityRelationship] fi where fi.[RelatedEntity] = c.CompanyId and fi.PrimaryEntity=@companyId) = 0 THEN 0 ELSE 1 END As IsItemCatalog,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactNumber,
(select top 1 ContactPerson from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Phone') ContactPerson
From company c where c.IsActive=1  and CompanyType=24) as tmp