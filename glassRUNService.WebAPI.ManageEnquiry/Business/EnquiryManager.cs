using APIController.Framework;
using APIController.Framework.AppLogger;
using glassRUN.Framework;
using glassRUN.Framework.Serializer;
using glassRUN.Framework.Utility;
using glassRUNProduct.DataAccess.Common;
using glassRUNService.WebAPI.ManageEnquiry.DataAccess;
using glassRUNService.WebAPI.ManageEnquiry.DTO;
using glassRUNService.WebApi.Configurations.DTO;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.ManageEnquiry.Business
{

    public class EnquiryManager : IEnquiryManager
    {
        BaseAppLogger _loggerInstance;
        public EnquiryManager(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }

        public EnquiryManager()
        {

        }


        public EnquiryDTO Save(EnquiryDTO enquiryDTO)
        {
            // ToDo: Business Validations
            ValidateDTO();

            // 1. Update The Enquiry object with Routing rules
            //UpdateRouteInformation(enquiryDTO);

            // 2. Update the Enquiry object with Rules
            //create Rules Json

            // 3. Update the enquiry object with master data columns

            // ToDo: Call the Manager class to process the request - refactor for extending



            string enquiryDTOXML = ObjectXMLSerializer<EnquiryDTO>.Save(enquiryDTO);
            DataTable dtresponse = new DataTable();
            dtresponse = ManageEnquiryDataAccessManager.SaveEnquiry<DataTable>(enquiryDTOXML);
            if (dtresponse.Rows.Count > 0)
            {

                enquiryDTO.EnquiryId = Convert.ToInt64(dtresponse.Rows[0]["EnquiryId"].ToString());
                enquiryDTO.EnquiryAutoNumber = dtresponse.Rows[0]["EnquiryAutoNumber"].ToString();
                enquiryDTO.CurrentState = Convert.ToInt64(dtresponse.Rows[0]["CurrentState"].ToString());

                //Updating the EnquiryAutoNumber and EnquiryId in product list
                enquiryDTO.ProductList.ToList().ForEach(w => { w.EnquiryAutoNumber = enquiryDTO.EnquiryAutoNumber; w.EnquiryId = enquiryDTO.EnquiryId; });

            }
            //EnquiryId,EnquiryAutoNumber,CurrentState ,Status return output 
            return enquiryDTO;
        }

        public bool ValidateDTO()
        {
            return true;
        }

        //Save the gratis order
        public JObject SaveGratisOrder(dynamic Json)
        {
            JObject returnObject = new JObject();

            // IF VALIDATIONS ARE SUCCESSFUL SAVE ALL THE ORDERS

            returnObject = ValidateGratisOrder(Json);
            if(returnObject.Count == 0)
            {
                string enquiryDTOXML = ObjectXMLSerializer<EnquiryDTO>.Save(Json);
                DataTable dtresponse = new DataTable();
                dtresponse = ManageEnquiryDataAccessManager.InsertEnquiryForGratisOrder<DataTable>(enquiryDTOXML);
                if (dtresponse.Rows.Count > 0)
                {

                }
                returnObject.Add("OK", "Enquiry saved successfully");
            }

            return returnObject;
        }

        /// <summary>
        /// Validate the Gratis order information
        /// Check if the Company Code, Sold TO, Ship To, Product Code is valid
        /// Check if the LENGTH are within the boundries
        /// Other basic checks like quantity is not negetative etc.
        /// </summary>
        /// <param name="Json"></param>
        /// <returns></returns>
        /// 

        public bool ValidateSettingData(dynamic Json)
        {
            bool result = true;
            string routeDetails = String.Empty;
            string apiRequest = "http://localhost:54398/Configurations/GetSetting"; // API Url for testing
            GRSeeting routeRequest = new GRSeeting(apiRequest, "GET");
            routeDetails = routeRequest.GetResponse();

            List<SettingDTO> lstgetSetting = JsonConvert.DeserializeObject<List<SettingDTO>>(routeDetails);

            List<SettingDTO> lstSttingDTO = lstgetSetting.Where(x => x.SettingParameter == "AllowedOrderTypesforGratis" && x.SettingValue.Contains(Json.EnquiryType)).ToList();

            if (lstSttingDTO.Count == 0)
            {
                result = false;
            }
            return result;
        }

        public string ValidatePageControlData(dynamic Json)
        {
            bool result = true;
            string response = string.Empty;
            string routeDetailsForPage = String.Empty;
            string apiRequestForPage = "http://localhost:54398/Configurations/GetPageValidations"; // API Url for testing
            GRSeeting routeRequestForPage = new GRSeeting(apiRequestForPage, "GET");
            routeDetailsForPage = routeRequestForPage.GetResponse();

            List<PageValidationsDTO> lstPageValidation = JsonConvert.DeserializeObject<List<PageValidationsDTO>>(routeDetailsForPage);
            PageValidationsDTO Desc1Validation = lstPageValidation.Where(x => x.PageName == "GratisUpload" && x.DisplayName == "Description1").FirstOrDefault();
            PageValidationsDTO Desc2Validation = lstPageValidation.Where(x => x.PageName == "GratisUpload" && x.DisplayName == "Description2").FirstOrDefault();

            var regDesc1 = new Regex(Desc1Validation.ValidationExpression);
            if (!regDesc1.IsMatch(Json.Description1))
            {
                result = false;
                response = "Desription1Error";
            }

            var regDesc2 = new Regex(Desc2Validation.ValidationExpression);
            if (!regDesc2.IsMatch(Json.Description2))
            {
                if (result == false)
                    response = "BothDescriptionError";
                else
                {
                    response = "Desription2Error";
                    result = false;
                }

            }

            if (result == true)
                response = "OK";

            return response;
        }
        public JObject ValidateGratisOrder(dynamic Json)
        {
            JObject returnObject = new JObject();

            // ADD VALIDATIONS HERE
            // Expect multple orders will be received. validate every order
            bool result = ValidateSettingData(Json);
            if (result == false) 
                returnObject.Add("Invalid Order Tpye","Enquiry Type doesn't exist");


            //validation for for page control description

            string response = ValidatePageControlData(Json);
            if (response == "Desription1Error")
                returnObject.Add("Invalid Description1 Property", "Doesn't match description1 criteria");
            else if (response == "Desription2Error")
                returnObject.Add("Invalid Description2 Property", "Doesn't match description2 criteria");
            else if (response == "BothDescriptionError")
            {
                returnObject.Add("Invalid Description1 Property", "Doesn't match description1 criteria");
                returnObject.Add("Invalid Description2 Property", "Doesn't match description2 criteria");
            }
           

            return returnObject;
        }

        /// <summary>
        /// Create the route JSON which searches for the specific route information based on the Enquiry details
        /// </summary>
        /// <param name="enquiryDTO"></param>
        /// <returns></returns>
        private string GetJsonForRouteSearch(EnquiryDTO enquiryDTO)
        {
            //string Jsonformat = "{'CompanyId':" + enquiryDTO.CompanyId.ToString() + ",'DestinationId':" + enquiryDTO.ShipTo.ToString() + ",'TruckSizeId':" + enquiryDTO.TruckSizeId.ToString() + "}";
            string Jsonformat = "{\"RouteId\":0" + ",\"CompanyId\":" + enquiryDTO.CompanyId + ",\"OriginId\":" + 0 + ",\"OriginCode\":\"" + enquiryDTO.CollectionLocationCode + "\",\"DestinationId\":" + enquiryDTO.ShipTo + ",\"DestinationCode\":\"" + enquiryDTO.ShipToCode.ToString() + "\",\"TruckSizeId\":" + enquiryDTO.TruckSizeId + ",\"ReferenceID\":\"" + enquiryDTO.EnquiryGuid + "\"}";
            return Jsonformat;
        }

        /// <summary>
        /// Get the route details. Based on the route information update enquiry object with collection Location and Carrier
        /// </summary>
        /// <param name="formattedJSONforRouteSearch"></param>
        /// <returns></returns>
        private string GetrouteDetails(string formattedJSONforRouteSearch, EnquiryDTO enquiryDTO) //errorcode 501.1
        {
            string routeDetails = String.Empty;

            try
            {
                //  Call Webapi method to get the route details
                string apiRequest = "http://localhost:59844/Route/RouteInformation"; // API Url for testing

                string routeInformationAction = "LoadRouteDetails";
                DataTable dtRouteInformationURL = ServiceConfigurationDataAccessManager.GetServicesConfiguartionURL<DataTable>(routeInformationAction);
                if (dtRouteInformationURL.Rows.Count > 0)
                    apiRequest = dtRouteInformationURL.Rows[0]["ServicesURL"].ToString();

                //Sending the API HTTP request
                if (apiRequest != string.Empty)
                {
                    //HttpClient client = new HttpClient();
                    //var responseMessage =  client.PostAsync(apiRequest, new StringContent(formattedJSONforRouteSearch, Encoding.UTF8, "application/json")).Result;
                    //if (responseMessage.IsSuccessStatusCode)
                    //{
                    //    var responseContent = responseMessage.Content;
                    //    // by calling .Result you are synchronously reading the result
                    //     routeDetails = responseContent.ReadAsStringAsync().Result;
                    //}

                    GRClientRequest routeRequest = new GRClientRequest(apiRequest, "POST", formattedJSONforRouteSearch);
                    routeDetails = routeRequest.GetResponse();
                }
            }
            catch (Exception ex)
            {
                throw new ApplicationException(enquiryDTO.EnquiryGuid + ": Error Code 501.1 - GetrouteDetails From API:" + ex.Message);
            }
            return routeDetails;
        }

        /// <summary>
        /// Updating the route information in Enquiry Object
        /// </summary>
        /// <param name="enquiryDTO"></param>
        /// <returns></returns>
        private EnquiryDTO UpdateRouteInformation(EnquiryDTO enquiryDTO)
        {
            //1. Create Json for rout search
            string formattedJSONforRouteSearch = GetJsonForRouteSearch(enquiryDTO);
            //2. send the Json to route aPI
            _loggerInstance.Information(enquiryDTO.EnquiryGuid + ": Fetching Route Details for Enquiry ", 502);
            string routeInfromation = GetrouteDetails(formattedJSONforRouteSearch, enquiryDTO);
            _loggerInstance.Information(enquiryDTO.EnquiryGuid + ": Fetching Route Details for Enquiry Ends", 502);

            //3. Update enquiry Object
            if (routeInfromation != MessageConstants.NoRecords)
            {
                var cList = JsonConvert.DeserializeObject<List<dynamic>>(routeInfromation);
                if (cList != null)
                {
                    // Updated 3 feild as of now.. how many field need to update that i dont know
                    if (cList.Count == 1)
                    {
                        enquiryDTO.CollectionLocationId = cList.First().OriginId;
                        enquiryDTO.CollectionLocationCode = cList.First().OriginCode;
                        enquiryDTO.CarrierId = cList.First().CarrierNumber;
                        enquiryDTO.CarrierCode = cList.First().CarrierCode;
                        enquiryDTO.CarrierName = cList.First().CarrierName;
                    }
                    else
                    {
                        enquiryDTO.CollectionLocationId = null;
                        enquiryDTO.CollectionLocationCode = null;
                        enquiryDTO.CarrierId = 0;
                        enquiryDTO.CarrierCode = null;
                        enquiryDTO.CarrierName = null;
                    }
                }
            }
            else
            {
                enquiryDTO.CollectionLocationId = null;
                enquiryDTO.CollectionLocationCode = null;
                enquiryDTO.CarrierId = 0;
                enquiryDTO.CarrierCode = null;
                enquiryDTO.CarrierName = null;
            }

            //JObject obj = (JObject)JsonConvert.DeserializeObject(routeInfromation);

            return enquiryDTO;
        }

        private EnquiryDTO UpdateEnquiryInformationBasedOnRules(EnquiryDTO enquiryDTO, string routeDetails)
        {

            return enquiryDTO;
        }

    }
}
