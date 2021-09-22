using System;
using Microsoft.AspNetCore.Mvc;
using APIController.Framework.AppLogger;
using APIController.Framework.Controllers;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Diagnostics;
using System.Net;
using APIController.Framework;
using System.Collections.Generic;
using System.Xml;
using glassRUN.Framework.Serializer;
using Microsoft.AspNetCore.Cors;
using System.Dynamic;
using glassRUNService.WebAPI.ManageCustomer.Business;
using System.Data;
using glassRUN.Framework;
using Microsoft.Extensions.Configuration;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Linq;

namespace glassRUNService.WebAPI.ManageCustomer.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ManageCustomerController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get
            {
                return EnumLoggerType.Product;
            }
        }

        [HttpPost]
        [Route("GetAllSupplierDetailsB2BApp")]
        public IActionResult GetAllSupplierDetailsB2BApp(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICustomerManager customerManager = new CustomerManager();
                string output = customerManager.GetAllSupplierDetailsB2BApp(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }

        [HttpPost]
        [Route("GetAllCustomerListB2BApp")]
        public IActionResult GetAllCustomerListB2BApp(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICustomerManager customerManager = new CustomerManager();
                string output = customerManager.GetAllCustomerListB2BApp(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }

        [HttpPost]
        [Route("GetCustomerDetailsBySupplier")]
        public IActionResult GetCustomerDetailsBySupplier(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICustomerManager customerManager = new CustomerManager();
                string output = customerManager.GetCustomerDetailsBySupplier(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception ex)
            {

            }

            return Ok(returnObject);

        }


        [HttpPost]
        [Route("UpadateManageCusomerDetailsB2BApp")]
        public IActionResult UpadateManageCusomerDetailsB2BApp(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICustomerManager customerManager = new CustomerManager();
                string output = customerManager.UpdateManageCusomerDetailsB2BApp(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }


        [HttpPost]
        [Route("SaveCustomerGroup")]
        public IActionResult SaveCustomerGroup(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICustomerManager customerManager = new CustomerManager();
                string output = customerManager.SaveCustomerGroup(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }

    }
}
