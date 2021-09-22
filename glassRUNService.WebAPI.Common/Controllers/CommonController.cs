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
using glassRUNProduct.DataAccess.Common;
using System.Data;
using glassRUN.Framework;
using Microsoft.Extensions.Configuration;
using glassRUNService.WebAPI.Common.DataAccess;
using glassRUNService.WebAPI.Common.Business;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Linq;




namespace glassRUNService.WebAPI.Common.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CommonController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get
            {
                return EnumLoggerType.Product;
            }
        }


        [HttpPost]
        [Route("ResourceDataForApp")]
        public IActionResult ResourceDataForApp(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICommonManager ruleManager = new CommonManager();
            string output = ruleManager.ResourceDataForApp(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }

            return Ok(returnObject);
        }

        [HttpPost]
        [Route("UpdateLoginHistoryB2BApp")]
        public IActionResult UpdateLoginHistoryB2BApp(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICommonManager ruleManager = new CommonManager();
                LoggerInstance.Information("UpdateLoginHistoryB2BApp --> Input String : " + Input, 5002);
                string output = ruleManager.UpdateLoginHistoryB2BApp(Input);
                LoggerInstance.Information("UpdateLoginHistoryB2BApp --> Output String : " + output, 5002);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception ex)
            {
                LoggerInstance.Information("UpdateLoginHistoryB2BApp Exception : " + ex.Message, 5002);

            }

            return Ok(returnObject);

        }

        [HttpPost]
        [Route("LoadAllPagesMenuListB2BApp")]
        public IActionResult LoadAllPagesMenuListB2BApp(dynamic Json)
        {
            JObject returnObject = new JObject();

            try
            {

                string Input = JsonConvert.SerializeObject(Json);
                ICommonManager ruleManager = new CommonManager();
                string output = ruleManager.LoadAllPagesMenuListB2BApp(Input);

                if (output != null)
                {

                    returnObject = (JObject)JsonConvert.DeserializeObject(output);
                }

            }
            catch (Exception ex)
            {

            }

            return Ok(returnObject);

        }


        [HttpPost]
        [Route("LoadAllCultureMaster")]
        public IActionResult LoadAllCultureMaster(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICommonManager ruleManager = new CommonManager();
            string output = ruleManager.LoadAllCultureMaster(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return Ok(returnObject);
        }


        [HttpPost]
        [Route("LoadLookupForApp")]
        public IActionResult LoadLookupForApp(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICommonManager ruleManager = new CommonManager();
            string output = ruleManager.LoadLookupForApp(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }

            return Ok(returnObject);
        }


        [HttpPost]
        [Route("LoadAllSettingMaster")]
        public IActionResult LoadAllSettingMaster(dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            ICommonManager ruleManager = new CommonManager();
            string output = ruleManager.GetAllSettingMasterList(Input);

            JObject returnObject = new JObject();

            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return Ok(returnObject);
        }


        [HttpPost]
        [Route("AddDeviceToken")]
        public IActionResult AddDeviceToken(dynamic Json)
        {
            JObject returnObject = new JObject();

            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICommonManager ruleManager = new CommonManager();
                string output = ruleManager.UserDetailDeviceTokenMapping(Input);

                if (output != null)
                {
                    returnObject = (JObject)JsonConvert.DeserializeObject(output);
                }
            }
            catch (Exception)
            {
            }

            return Ok(returnObject);

        }

        [HttpPost]
        [Route("GetSQLCurrentDatetimeAndZone")]
        public IActionResult GetSQLCurrentDatetimeAndZone(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICommonManager ruleManager = new CommonManager();
                string output = ruleManager.GetSQLCurrentDatetimeAndZone(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }
            return Ok(returnObject);
        }


        [HttpPost]
        [Route("GetAllNotificationB2BApp")]
        public IActionResult GetAllNotificationB2BApp(dynamic Json)
        {
            JObject returnObject = new JObject();
            try
            {
                string Input = JsonConvert.SerializeObject(Json);
                ICommonManager ruleManager = new CommonManager();
                string output = ruleManager.GetAllNotificationB2BApp(Input);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            catch (Exception)
            {

            }

            return Ok(returnObject);

        }


        [HttpPost]
        [Route("InsertApplogging")]
        public IActionResult InsertApplogging(dynamic Json)
        {
            string input = JsonConvert.SerializeObject(Json);
            ICommonManager ruleManager = new CommonManager();
            string output = ruleManager.InsertApplogging(input);

            JObject returnObject = new JObject();

            if (output != null)
            {
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }

            return Ok(returnObject);
        }


    }
}
