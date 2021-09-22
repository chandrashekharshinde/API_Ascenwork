using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using Newtonsoft.Json.Linq;
using System.Dynamic;
using Newtonsoft.Json.Converters;
using APIController.Framework.AppLogger;
using Newtonsoft.Json;
using glassRUN.Framework;
using Microsoft.Extensions.Caching.Memory;
using System.Data;
using glassRUNProduct.DataAccess.Common;
using glassRUN.Framework.Cache;
using glassRUN.Framework.Utility;
using APIController.Framework.Controllers;
using APIController.Framework;

namespace glassRUNService.WebApi.ProcessRequest.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class grRequestController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get
            {
                return EnumLoggerType.Configurations;
            }
        }

        public IMemoryCache cache;
        public grRequestController(IMemoryCache memoryCache)
        {
            this.cache = memoryCache;
        }


        [HttpPost]
        [Route("/api/[controller]/ProcessRequest")]
        public IActionResult ProcessRequest(RequestData request)
        {
            //HttpClient client = new HttpClient();
            //Request.Headers.Authorization

            JObject obj = new JObject();
            try
            {
                //string jsonData = request.Json.GetRawText();
                //JObject objNew = (JObject)JsonConvert.DeserializeObject(jsonData);
                JObject jsonObj = request.Json;
                var newObj = new JObject
                {
                    ["Json"] = jsonObj,
                };

                string newJsonString = Convert.ToString(newObj);



                dynamic inputObject = new ExpandoObject();

                var expConverter = new ExpandoObjectConverter();
                inputObject = JsonConvert.DeserializeObject<ExpandoObject>(newJsonString, expConverter);


                string customApi = "";

                customApi = ServiceConfigurationDataAccessManager.GetServiceActionURL(inputObject.Json.ServicesAction);

                if (!string.IsNullOrEmpty(customApi))
                {
                    //create the constructor with post type and few data
                    GRClientRequest myRequest = new GRClientRequest(customApi, "POST", newJsonString);
                    //show the response string on the console screen.
                    string outputResponse = myRequest.GetResponse();

                    if (outputResponse != null)
                    {
                        obj = (JObject)JsonConvert.DeserializeObject(outputResponse);

                    }
                }

            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 999);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");

            }

            return Ok(obj);
        }


    }

    public class RequestData
    {
        public dynamic Json { get; set; }

        public RequestData()
        {
        }
    }

}
