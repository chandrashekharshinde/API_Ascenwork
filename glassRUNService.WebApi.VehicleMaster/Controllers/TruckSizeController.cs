using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using System.Net;
using System.Net.Http;
using System.Data;
//using System.Web.Http.Cors;
using System.Dynamic;
using Microsoft.AspNetCore.Cors;
using glassRUNProduct.DataAccess;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
//using System.Web.Http;
using glassRUNService.WebApi.VehicleMaster.DataAccess;
using glassRUNService.WebApi.VehicleMaster.Business;
using glassRUNService.WebApi.VehicleMaster.DTO;
using APIController.Framework.Controllers;
using APIController.Framework.AppLogger;

namespace glassRUNService.WebApi.VehicleMaster.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TruckSizeController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Vehicle; }
        }

  

        [HttpPost]
        public IActionResult GetAllTruckSizeList(dynamic json)
        {
            string Input = JsonConvert.SerializeObject(json);

            string output = TruckSizeDataAccessManager.GetAllTruckSizeList(Input);


            JObject returnObject = new JObject();

            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return Ok(returnObject);
        }


        [HttpPost]
        [Route("GetAllTruckSizeListByVehicleId")]
        public IActionResult GetAllTruckSizeListByVehicleId(dynamic Json)
        {
            IManageTruckSize objVehicleMaster = new ManageTruckSize(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetAllTruckSizeListByVehicleId(Input);
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        public IActionResult GetAllTruck(dynamic json)
        {
            string Input = JsonConvert.SerializeObject(json);

            string output = TruckSizeDataAccessManager.GetAllTruck(Input);


            JObject returnObject = new JObject();

            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }




            return Ok(returnObject);



        }



        [HttpPost]
        public IActionResult SaveTruck(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            dynamic returnObject = new ExpandoObject();

            string notValidFields = "";
            //notValidFields = _GRValidations.ValidateAllFields(Json);

            if (notValidFields == "")
            {


                JObject obj = (JObject)JsonConvert.DeserializeObject(Input);
                var truckIdList = obj["Json"]["TruckSizeId"].ToString();
                if (truckIdList == "0")
                {
                    string output = TruckSizeDataAccessManager.Insert(Input);
                }
                else
                {
                    string output = TruckSizeDataAccessManager.Update(Input);
                }

                // JObject returnObject = new JObject();
                if (Input != null)
                {

                    returnObject = (JObject)JsonConvert.DeserializeObject(Input);
                }
            }
            else
            {
                returnObject.ErrorValidationMessage = notValidFields;
            }


            return Ok(returnObject);
        }

        [HttpPost]
        public IActionResult LoadTruckDetails(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            string output = TruckSizeDataAccessManager.LoadTruckDetails_getPagging(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }




            return Ok(returnObject);


        }


        [HttpPost]
        public IActionResult GetTruckDetailsById(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            string output = TruckSizeDataAccessManager.GetTruckDetailsById(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }




            return Ok(returnObject);


        }



        [HttpPost]
        public IActionResult DeleteTruck(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            string output = TruckSizeDataAccessManager.Delete(Input);

            JObject returnObject = new JObject();
            if (Input != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(Input);
            }


            return Ok(returnObject);
        }


        //[CustomActionFilterAttribute]
        [HttpPost]
        public IActionResult GetTruckDetailByLocationIdAndCompanyId(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            string output = TruckSizeDataAccessManager.LoadTruckDetailByLocationIdAndCompanyId(Input);

            JObject obj = new JObject();

            if (output != null)
            {

                obj = (JObject)JsonConvert.DeserializeObject(output);
            }




            return Ok(obj);
        }

        [HttpPost]
        public IActionResult LoadAllTruckSizeLisByDropDown(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);

            string output = TruckSizeDataAccessManager.LoadAllTruckSizeLisByDropDown(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }

            return Ok(returnObject);

        }


        #region
        //[CustomActionFilterAttribute]
        [HttpPost]
        public IActionResult LoadTruckSizeDetails(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            string output = TruckSizeDataAccessManager.LoadTruckSizeDetails(Input);

            JObject obj = new JObject();

            if (output != null)
            {

                obj = (JObject)JsonConvert.DeserializeObject(output);
            }




            return Ok(obj);
        }





        #endregion

    }
}
