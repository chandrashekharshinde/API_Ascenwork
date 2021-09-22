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

    //[EnableCors("*", "*", "PUT,POST")]
    public class TransportVehicleController : BaseAPIController
    {

        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Vehicle; }
        }

        #region staticVariables
        //private static GRValidations _GRValidations = new GRValidations();
        #endregion
        [HttpPost]
        [Route("LoadTransportVehicleDetails")]
        public IActionResult LoadTransportVehicleDetails(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.LoadTransportVehicleDetails(Input);
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        [Route("CheckDuplicateTransportVehicale")]
        public IActionResult CheckDuplicateTransportVehicale(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);

            returnObject = objVehicleMaster.CheckDuplicateTransportVehicale(Input);
            return Ok(returnObject);
        }

        [HttpPost]
        [Route("SaveTransportVehicle")]
        public IActionResult SaveTransportVehicle(dynamic vehicleDTO)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            string jsonInput = Convert.ToString(vehicleDTO);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);

            dynamic returnObject = new ExpandoObject();

            //JObject returnObject = new JObject();

            returnObject = objVehicleMaster.SaveVehicle(Input);

            return Ok(returnObject.ToString());
        }



        [HttpPost]
        [Route("GetAllTransportVehicle_Paging")]
        public IActionResult GetAllTransportVehicle_Paging(dynamic json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            dynamic rspjsonobj = new ExpandoObject();

            string jsonInput = Convert.ToString(json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);

            rspjsonobj = objVehicleMaster.GetTransportVehiclePaging(Input);
           
            return Ok(rspjsonobj.ToString());
        }


        [HttpPost]
        [Route("GetTransportVehicleById")]
        public IActionResult GetTransportVehicleById(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetVehicleByID(Input);
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        [Route("DeleteTransportVehicleById")]
        public IActionResult DeleteTransportVehicleById(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.DeleteVehicleByID(Input);
            return Ok(returnObject.ToString());
        }


        [HttpPost]
        [Route("LoadTransportVehicleByTransportVehicleId")]
        public IActionResult LoadTransportVehicleByTransportVehicleId(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.LoadTransportVehicleById(Input);

            //List<dynamic> orderList = new List<dynamic>();
            //if (!string.IsNullOrEmpty(Convert.ToString(returnObject["Json"]["OrderDocumentList"])))
            //{
            //    orderList = ((JArray)returnObject["Json"]["OrderDocumentList"]).ToObject<List<dynamic>>();
            //}
            //string x = "";
            //foreach (dynamic order in orderList)
            //{
            //    x = order.DocumentBlob;
            //}
            //byte[] byt = Convert.FromBase64String(x);


            // string fileName = "";


            // string datetimeStamp = DateTime.Now.Year.ToString() + DateTime.Now.Month + DateTime.Now.Day +
            //                        DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second;


            // fileName = "565656.pdf";
            //string filePath = @"D:\Blankchq TFS\glassRUN Product\200 - SDLC\300 - Development\glassRUNProduct";

            // if (!Directory.Exists(filePath + "/"))
            // {
            //     Directory.CreateDirectory(filePath + "/");
            // }

            // FileStream fs = new FileStream(filePath + "/" + fileName, FileMode.Create);
            // fs.Write(byt, 0, byt.Length);
            // fs.Close();

            //byte[] byt ;
            //HttpResponseMessage result = new HttpResponseMessage();
            //if (byt == null)
            //{
            //    result = Request.CreateResponse(HttpStatusCode.Gone);
            //}
            //else
            //{

            //    result.Content = new ByteArrayContent(byt);
            //    result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment");
            //    result.Content.Headers.ContentDisposition.FileName = "OrderPickSlip.pdf";
            //    result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/pdf");
            //    //result.StatusCode = HttpStatusCode.InternalServerError;

            //}
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        [Route("GetTransportVehicleDetailsById")]
        public IActionResult GetTransportVehicleDetailsById(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetTransportVehicleDetailsById(Input);
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        [Route("DeleteTransportVehicle")]
        public IActionResult DeleteTransportVehicle(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.DeleteTransportVehicle(Input);
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        [Route("GetPlateNumberByCarrierId")]
        public IActionResult GetPlateNumberByCarrierId(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetPlateNumberByCarrier(Input);
            return Ok(returnObject.ToString());
        }

        [HttpPost]
        [Route("GetDriverByPlateNumber")]
        public IActionResult GetDriverByPlateNumber(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetDriverByPlateNumberId(Input);
            return Ok(returnObject.ToString());
        }


        [HttpPost]
        [Route("GetAllPlateNumberForSecurityApp")]
        public IActionResult GetAllPlateNumberForSecurityApp(dynamic Json)
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetAllPlateNumberForSecurityApp(Input);
            return Ok(returnObject.ToString());
        }

        [HttpGet]
        [Route("GetCountryDetails")]
        public IActionResult GetCountryDetails()
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            //string jsonInput = Convert.ToString(Json);
            //JObject jsonObj = JObject.Parse(jsonInput);
            //string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetCountry();
            return Ok(returnObject.ToString());
        }

        [HttpGet]
        [Route("GetAllVehicleForThirdPartySync")]
        public IActionResult GetAllVehicleForThirdPartySync()
        {
            IManageVehicle objVehicleMaster = new ManageVehicle(LoggerInstance);
            JObject returnObject = new JObject();
            //string jsonInput = Convert.ToString(Json);
            //JObject jsonObj = JObject.Parse(jsonInput);
            //string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objVehicleMaster.GetAllVehicleForThirdPartySync();
            return Ok(returnObject.ToString());
        }



    }
}
