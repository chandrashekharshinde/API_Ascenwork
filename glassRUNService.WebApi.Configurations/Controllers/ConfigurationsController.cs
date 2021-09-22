using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using APIController.Framework.AppLogger;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using APIController.Framework.Controllers;
using glassRUNService.WebApi.Configurations.DTO;
using glassRUNService.WebApi.Configurations.Business;
using APIController.Framework;
using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace glassRUNService.WebApi.Configurations.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ConfigurationsController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Configurations; }
        }

        /// <summary>
        /// method for GetSetting 
        /// </summary>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetSetting")]
        public IActionResult GetSetting(long CompanyId) // Error code: 5001
        {
            try
            {
                // Get Records for GetSetting details 
                ICofigurationsManager objgetSetting = new CofigurationsManager();
                List<SettingDTO> lstgetSetting = objgetSetting.GetSetting(Convert.ToInt32(CompanyId));
                return Ok(lstgetSetting);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5001);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }
        }

        /// <summary>
        /// Implementation  for get lookup details 
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetLookUpDetails")]
        public IActionResult GetLookUpDetails() // Error code: 5002
        {
            try
            {
                // Get Records for Get lookup details 
                ICofigurationsManager objgetLookup = new CofigurationsManager();
                List<LookupDetailsDTO> lstgetSetting = objgetLookup.GetLookUpDetails();
                return Ok(lstgetSetting);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5002);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }

        }


        /// <summary>
        /// Implementation of get language resource
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GelLanguageResource")]
        public IActionResult GelLanguageResource() //Error code :5003 
        {
            try
            {
                // Get Records for Get Language Resource details 
                ICofigurationsManager objgetResource = new CofigurationsManager();
                List<LanguageResourceDTO> lstgetResource = objgetResource.GelLanguageResource();
                return Ok(lstgetResource);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5003);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }

        }
        /// <summary>
        /// Get the data from business for the page controls configurations
        /// </summary>
        /// <param name="RoleMasterId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetPageControlConfigurations")]
        public IActionResult GetPageControlConfigurations(long? RoleId) //error code :5004
        {
            try
            {
                // Get Records for Get page controls configurations details 
                ICofigurationsManager objGetPageControl = new CofigurationsManager();
                List<PageControlDTO> lstGetPageControl = objGetPageControl.GetPageControlConfigurations(Convert.ToInt32(RoleId));
                return Ok(lstGetPageControl);
            }

            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5004);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");

            }
        }

        /// <summary>
        /// method for Get Page Validations
        /// </summary>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        [HttpGet]
        [Route("GetPageValidations")]
        public IActionResult GetPageValidations(long? CompanyId) // Error code: 5005
        {
            try
            {
                // Get Records for Get Page Validations
                ICofigurationsManager objPageValidation = new CofigurationsManager();
                List<PageValidationsDTO> lstPageValidation = objPageValidation.GetPageValidations(Convert.ToInt32(CompanyId));
                return Ok(lstPageValidation);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5005);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }
        }
        /// <summary>
        /// Implementation for the get Culture Configuration
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("GetCultureConfigurations")]
        public IActionResult GetCultureConfigurations() // Error code: 5006
        {
            try
            {
                // Get Records for Get Culture Configurations
                ICofigurationsManager objgetPageCulture = new CofigurationsManager();
                List<PageCultureDTO> lstgetPageCulture = objgetPageCulture.GetCultureConfigurations();
                return Ok(lstgetPageCulture);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5006);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }

        }


        [HttpPost]
        [Route("GetStatusWiseColorList")]
        public IActionResult StatusWiseColorList(ColorStatusDTO colorStatusDTO) // Error code: 5006
        {
            try
            {
                // Get Records for Get Culture Configurations
                ICofigurationsManager objgetColorStatus = new CofigurationsManager();
                List<ColorStatusDTO> lstgetPageCulture = objgetColorStatus.StatusWiseColorList(colorStatusDTO);
                return Ok(lstgetPageCulture);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5006);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }

        }



        [HttpPost]
        [Route("AdvertisingBannerList")]
        public IActionResult AdvertisingBannerList(AdvertisingBannerDTO advertisingBannerDTO) // Error code: 5006
        {
            try
            {
                // Get Records for Get Culture Configurations
                LoggerInstance.Information("Get advertising banner call started", 5002);
                ICofigurationsManager objAdvertisingBanner = new CofigurationsManager();
                List<AdvertisingBannerDTO> advertisingBannerList = objAdvertisingBanner.AdvertisingBannerList(advertisingBannerDTO);
                return Ok(advertisingBannerList);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5006);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }

        }


        [HttpPost]
        [Route("BrandList")]
        public IActionResult BrandList(BrandDTO brandDTO) // Error code: 5006
        {
            try
            {
                // Get Records for Get Culture Configurations
                LoggerInstance.Information("Get brand list call started", 5002);
                ICofigurationsManager objBrand = new CofigurationsManager();
                List<BrandDTO> brandList = objBrand.BrandList(brandDTO);
                return Ok(brandList);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5006);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }

        }

        [HttpPost]
        [Route("CheckAppVersion")]
        public IActionResult CheckAppVersion(AppLatestVersionDTO appLatestVersionDTO)
        {
            LoggerInstance.Information("CheckAppVersion call started", 5002);
            LoggerInstance.Information("Version no -" + appLatestVersionDTO.AppLatestVersionNo, 5002);

            AppLatestVersionDTO appLatestVersionDTONew = new AppLatestVersionDTO();

            ICofigurationsManager objAppLatestVersion = new CofigurationsManager();
            List<AppLatestVersionDTO> appLatestVersionList = objAppLatestVersion.GetAppLatestVersionList(appLatestVersionDTO);

            if (appLatestVersionList != null)
            {

                if (appLatestVersionList.Count > 0)
                {
                    if (appLatestVersionList[0].AppLatestVersionMandatory)
                    {
                        string dbAppVersion = appLatestVersionList[0].AppLatestVersionNo;
                        string appVersion = appLatestVersionDTO.AppLatestVersionNo;

                        string dbAppBuildNo = appLatestVersionList[0].AppLatestBuildNo;
                        string appBuildNo = appLatestVersionDTO.AppLatestBuildNo;

                        if (appVersion != dbAppVersion || appBuildNo != dbAppBuildNo)
                        {
                            appLatestVersionDTONew.IsAppNeedToUpdate = "YES";
                            appLatestVersionDTONew.AppLatestVersionNo = appLatestVersionList[0].AppLatestVersionNo;
                            appLatestVersionDTONew.AppLatestBuildNo = appLatestVersionList[0].AppLatestBuildNo;
                            appLatestVersionDTONew.AppLatestVersionIsMandatory = appLatestVersionList[0].AppLatestVersionMandatory == true ? "YES" : "NO";
                            appLatestVersionDTONew.AppLatestDownloadLinkForAndroid = appLatestVersionList[0].AppLatestDownloadLinkForAndroid;
                            appLatestVersionDTONew.AppLatestDownloadLinkForIOS = appLatestVersionList[0].AppLatestDownloadLinkForIOS;
                            appLatestVersionDTONew.AppLatestDownloadLinkForWindows = appLatestVersionList[0].AppLatestDownloadLinkForWindows;
                        }
                        else
                        {
                            appLatestVersionDTONew.IsAppNeedToUpdate = "NO";
                        }
                    }
                    else
                    {
                        appLatestVersionDTONew.IsAppNeedToUpdate = "NO";
                    }



                }
                else
                {
                    appLatestVersionDTONew.IsAppNeedToUpdate = "NO";
                }
            }
            else
            {
                appLatestVersionDTONew.IsAppNeedToUpdate = "NO";
            }
            return Ok(appLatestVersionDTONew);

        }


        [HttpPost]
        [Route("ConfigurationModifyAPI")]
        public IActionResult ConfigurationModifyAPI(ConfigurationModificationStatusDTO configurationModificationStatusDTO)
        {
            try
            {
                List<ConfigurationModificationStatusDTO> updatedConfigurationModificationStatuses = new List<ConfigurationModificationStatusDTO>();
                LoggerInstance.Information("ConfigurationModifyAPI call started", 5002);
                LoggerInstance.Information("App type - " + configurationModificationStatusDTO.AppType + " Configuration code - " + configurationModificationStatusDTO.ConfigurationCode, 5002);


                ICofigurationsManager objAppLatestVersion = new CofigurationsManager();
                List<ConfigurationModificationStatusDTO> configurationModificationStatusDTOs = objAppLatestVersion.GetConfigurationModifyAPIList(configurationModificationStatusDTO);
                if (configurationModificationStatusDTOs.Count > 0)
                {
                    for (int i = 0; i < configurationModificationStatusDTOs.Count; i++)
                    {
                        List<ConfigurationModificationStatusDTO> filteredConfiguration = configurationModificationStatusDTO.ConfigurationModificationStatusList.Where(x => x.APIName == configurationModificationStatusDTOs[i].APIName).ToList();
                        if (filteredConfiguration.Count > 0)
                        {
                            if (configurationModificationStatusDTOs[i].ModifiedDate > filteredConfiguration[0].ModifiedDate)
                            {
                                updatedConfigurationModificationStatuses.Add(configurationModificationStatusDTOs[i]);
                            }
                        }
                        else
                        {
                            updatedConfigurationModificationStatuses.Add(configurationModificationStatusDTOs[i]);
                        }
                    }


                }



                return Ok(updatedConfigurationModificationStatuses);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5006);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");

            }

        }


        [HttpPost]
        [Route("PageLevelConfigurationForApp")]
        public IActionResult PageLevelConfigurationForApp(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICofigurationsManager objBrand = new CofigurationsManager();
            string output = objBrand.PageLevelConfigurationForApp(Input);
            JObject returnObject = new JObject();
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return Ok(returnObject);
        }


        [Route("GetAppPageControlAccessByPageIdAndRoleAndUserID")]
        [HttpPost]
        public IActionResult GetAppPageControlAccessByPageIdAndRoleAndUserID(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICofigurationsManager objBrand = new CofigurationsManager();

            string output = objBrand.GetAppPageControlAccessByPageIdAndRoleAndUserID(Input);
            JObject returnObject = new JObject();
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return Ok(returnObject);
        }


        [Route("GetAllSortingParametersByPageId")]
        [HttpPost]
        public IActionResult GetAllSortingParametersByPageId(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICofigurationsManager objBrand = new CofigurationsManager();
                string output = objBrand.GetAllSortingParametersByPageId(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }


        [Route("GetAllFilterParametersByPageId")]
        [HttpPost]
        public IActionResult GetAllFilterParametersByPageId(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICofigurationsManager objBrand = new CofigurationsManager();
                string output = objBrand.GetAllFilterParametersByPageId(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }


        [Route("LoadAllAppFormList")]
        [HttpPost]
        public IActionResult LoadAllAppFormList(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICofigurationsManager objBrand = new CofigurationsManager();
            string output = objBrand.LoadAllAppFormList(Input);
            JObject returnObject = new JObject();
            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);

                var chkAppFormsList = returnObject["Json"][0]["AppFormsList"];

                if (chkAppFormsList != null)
                {
                    var processToExecuteList = returnObject["Json"][0]["AppFormsList"].ToList();

                    for (int j = 0; j < processToExecuteList.Count; j++)
                    {
                        if (processToExecuteList[j]["FormContent"] != null)
                        {
                            string formCont = Convert.ToString(processToExecuteList[j]["FormContent"]);
                            //byte[] byt = System.Text.Encoding.UTF8.GetBytes(formCont);
                            // convert the byte array to a Base64 string
                            //processToExecuteList[j]["FormContent"] = Convert.ToBase64String(byt);
                            processToExecuteList[j]["FormContent"] = formCont;
                        }
                    }
                }
            }
            return Ok(returnObject);

        }

    }
}