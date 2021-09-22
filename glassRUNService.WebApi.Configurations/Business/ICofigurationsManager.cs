using glassRUNService.WebApi.Configurations.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.Business
{
  public  interface ICofigurationsManager
    {
        List<SettingDTO> GetSetting(long CompanyId);
        List<LookupDetailsDTO> GetLookUpDetails();
        List<LanguageResourceDTO> GelLanguageResource();
        List<PageControlDTO> GetPageControlConfigurations(long? RoleId);
        List<PageValidationsDTO> GetPageValidations(long? CompanyId);
        List<PageCultureDTO> GetCultureConfigurations();
        List<ColorStatusDTO> StatusWiseColorList(ColorStatusDTO colorStatusDTO);


        List<AdvertisingBannerDTO> AdvertisingBannerList(AdvertisingBannerDTO advertisingBannerDTO);

        List<BrandDTO> BrandList(BrandDTO brandDTO);

        List<AppLatestVersionDTO> GetAppLatestVersionList(AppLatestVersionDTO appLatestVersionDTO);


        List<ConfigurationModificationStatusDTO> GetConfigurationModifyAPIList(ConfigurationModificationStatusDTO configurationModificationStatusDTO);
        string PageLevelConfigurationForApp(dynamic Json);
        string GetAppPageControlAccessByPageIdAndRoleAndUserID(dynamic Json);
        string GetAllSortingParametersByPageId(dynamic Json);
        string GetAllFilterParametersByPageId(dynamic Json);
        string LoadAllAppFormList(dynamic input);
    }
}
