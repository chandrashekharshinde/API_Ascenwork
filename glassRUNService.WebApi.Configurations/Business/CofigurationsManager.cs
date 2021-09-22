using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using glassRUN.Framework.Serializer;
using glassRUNProduct.DataAccess.Common;
using glassRUN.Framework;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Data;
using APIController.Framework;
using glassRUNService.WebApi.Configurations.DataAccess;
using glassRUNService.WebApi.Configurations.DTO;

namespace glassRUNService.WebApi.Configurations.Business
{
    public class CofigurationsManager : ICofigurationsManager
    {
        public bool ValidateDTO()
        {
            return true;
        }
        /// <summary>
        /// Get records for the GetSetting 
        /// </summary>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        public List<SettingDTO> GetSetting(long CompanyId)
        {
            // Call data access class to get the get setting details
            DataTable dtSetting = new DataTable();
            dtSetting = ConfigurationsDataAccessManager.GetSetting<DataTable>(Convert.ToInt32(CompanyId));
            List<SettingDTO> lstgetSetting = Extension.DataTableToList<SettingDTO>(dtSetting);
            return lstgetSetting;
        }
        /// <summary>
        /// get data access method to get lookup details
        /// </summary>
        /// <returns></returns>
        public List<LookupDetailsDTO> GetLookUpDetails( )
        {
            // Call data access class to get the get lookup details
            DataTable dtLookupDetails = new DataTable();
            dtLookupDetails = ConfigurationsDataAccessManager.GetLookUpDetails<DataTable>();
            List<LookupDetailsDTO> lstgetSetting = Extension.DataTableToList<LookupDetailsDTO>(dtLookupDetails);
            return lstgetSetting;
        }
        /// <summary>
        /// Implementation of get data for language resource access 
        /// </summary>
        /// <returns></returns>
        public List<LanguageResourceDTO> GelLanguageResource()
        {
            // Call data access class to get the get lookup details
            DataTable dtLanguageResource = new DataTable();
            dtLanguageResource = ConfigurationsDataAccessManager.GelLanguageResource<DataTable>();
            List<LanguageResourceDTO> lstgetresource = Extension.DataTableToList<LanguageResourceDTO>(dtLanguageResource);
            return lstgetresource;
        }

        /// <summary>
        /// business logic for Get page controls configurations
        /// </summary>
        /// <returns></returns>        
        public List<PageControlDTO> GetPageControlConfigurations(long? RoleId)
        {
            // Call data access class to get the page control configurations
            DataTable dtPageControl = new DataTable();
            dtPageControl = ConfigurationsDataAccessManager.GetPageControlConfigurations<DataTable>(Convert.ToInt32(RoleId));
            List<PageControlDTO> getPageControl = Extension.DataTableToList<PageControlDTO>(dtPageControl);
            return getPageControl;
        }
        /// <summary>
        /// Business Logic for the get page validations 
        /// </summary>
        /// <param name="RoleMasterId"></param>
        /// <returns></returns>
        public List<PageValidationsDTO> GetPageValidations(long? CompanyId)
        {
            // Call data access class to get the page validations
            DataTable dtPageValidation = new DataTable();
            dtPageValidation = ConfigurationsDataAccessManager.GetPageValidationsV3<DataTable>(Convert.ToInt32(CompanyId));
            List<PageValidationsDTO> getPageValidations = Extension.DataTableToList<PageValidationsDTO>(dtPageValidation);
            return getPageValidations;
        }

        /// <summary>
        /// Business Logic for the get page validations 
        /// </summary>
        /// <param name="RoleMasterId"></param>
        /// <returns></returns>
        public List<PageValidationsDTO> GetPageValidationsV3(long? CompanyId)
        {
            // Call data access class to get the page validations
            DataTable dtPageValidation = new DataTable();
            dtPageValidation = ConfigurationsDataAccessManager.GetPageValidations<DataTable>(Convert.ToInt32(CompanyId));
            List<PageValidationsDTO> getPageValidations = Extension.DataTableToList<PageValidationsDTO>(dtPageValidation);
            return getPageValidations;
        }

        public List<PageCultureDTO> GetCultureConfigurations()
        {
            // Call data access class to get the get lookup details
            DataTable dtCultureConfiguration = new DataTable();
            dtCultureConfiguration = ConfigurationsDataAccessManager.GetCultureConfigurations<DataTable>();
            List<PageCultureDTO> lstgetPageCulture = Extension.DataTableToList<PageCultureDTO>(dtCultureConfiguration);
            return lstgetPageCulture;
        }

        public List<ColorStatusDTO> StatusWiseColorList(ColorStatusDTO colorStatusDTO)
        {
            // Call data access class to get the get lookup details
            DataTable dtColoerwiseStatus = new DataTable();
            dtColoerwiseStatus = ConfigurationsDataAccessManager.StatusWiseColorList<DataTable>(colorStatusDTO);
            List<ColorStatusDTO> lstgetPageCulture = Extension.DataTableToList<ColorStatusDTO>(dtColoerwiseStatus);
            return lstgetPageCulture;
        }

        public List<AdvertisingBannerDTO> AdvertisingBannerList(AdvertisingBannerDTO advertisingBannerDTO)
        {
            // Call data access class to get the get lookup details
            DataTable dtAdvertisingList = new DataTable();
            dtAdvertisingList = ConfigurationsDataAccessManager.AdvertisingBannerList<DataTable>(advertisingBannerDTO);
            List<AdvertisingBannerDTO> advertisingBannerList = Extension.DataTableToList<AdvertisingBannerDTO>(dtAdvertisingList);
            return advertisingBannerList;
        }


        public List<BrandDTO> BrandList(BrandDTO brandDTO)
        {
            // Call data access class to get the get lookup details
            DataTable dtBrandList = new DataTable();
            dtBrandList = ConfigurationsDataAccessManager.BrandList<DataTable>(brandDTO);
            List<BrandDTO> brandList = Extension.DataTableToList<BrandDTO>(dtBrandList);
            return brandList;
        }

        public List<AppLatestVersionDTO> GetAppLatestVersionList(AppLatestVersionDTO appLatestVersionDTO)
        {
            // Call data access class to get the get lookup details
            DataTable dtAppLatestVersionList = new DataTable();
            dtAppLatestVersionList = ConfigurationsDataAccessManager.GetAppLatestVersionList<DataTable>(appLatestVersionDTO);
            List<AppLatestVersionDTO> appLatestVersionList = Extension.DataTableToList<AppLatestVersionDTO>(dtAppLatestVersionList);
            return appLatestVersionList;
        }

        public List<ConfigurationModificationStatusDTO> GetConfigurationModifyAPIList(ConfigurationModificationStatusDTO configurationModificationStatusDTO)
        {
            // Call data access class to get the get lookup details
            DataTable dtConfigurationApiList = new DataTable();
            dtConfigurationApiList = ConfigurationsDataAccessManager.GetConfigurationModifyAPIList<DataTable>(configurationModificationStatusDTO);
            List<ConfigurationModificationStatusDTO> appLatestVersionList = Extension.DataTableToList<ConfigurationModificationStatusDTO>(dtConfigurationApiList);
            return appLatestVersionList;
        }


        public string PageLevelConfigurationForApp(dynamic Json)
        {
           
            string dtConfigurationApiList = ConfigurationsDataAccessManager.PageLevelConfigurationForApp(Json);
           
            return dtConfigurationApiList;
        }


        public string GetAppPageControlAccessByPageIdAndRoleAndUserID(dynamic Json)
        {
            string dtConfigurationApiList = ConfigurationsDataAccessManager.GetAppPageControlAccessByPageIdAndRoleAndUserID(Json);
            return dtConfigurationApiList;
        }

        public string GetAllSortingParametersByPageId(dynamic Json)
        {
            string dtConfigurationApiList = ConfigurationsDataAccessManager.GetAllSortingParametersByPageId(Json);
            return dtConfigurationApiList;
        }

        public string GetAllFilterParametersByPageId(dynamic Json)
        {
            string dtConfigurationApiList = ConfigurationsDataAccessManager.GetAllFilterParametersByPageId(Json);
            return dtConfigurationApiList;
        }

        public string LoadAllAppFormList(dynamic Json)
        {
            string dtConfigurationApiList = ConfigurationsDataAccessManager.LoadAllAppFormList(Json);
            return dtConfigurationApiList;
        }

        
    }
}
