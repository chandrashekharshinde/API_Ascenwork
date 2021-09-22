using System;
using Microsoft.AspNetCore.Mvc;
using APIController.Framework.AppLogger;
using APIController.Framework.Controllers;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Diagnostics;
using System.Net;
using APIController.Framework;
using glassRUNService.WebAPI.ManageEnquiry.DTO;
using glassRUNService.WebAPI.ManageEnquiry.Business;
using System.Collections.Generic;
using System.Xml;
using glassRUN.Framework.Serializer;
using Microsoft.AspNetCore.Cors;
using System.Dynamic;
using glassRUNProduct.DataAccess.Common;
using System.Data;
using glassRUN.Framework;
using Microsoft.Extensions.Configuration;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Linq;
//using glassRUN.Framework.Cache;

namespace glassRUNService.WebAPI.ManageEnquiry.Controllers
{


    //[GRAuthorize]
    [ApiController]
    [Route("[controller]")]
    public class ManageEnquiryController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Enquiry; }
        }
      //  CacheManager cacheManager = new CacheManager();

        /// <summary>
        /// Default method for post. creates enquiry.
        /// </summary>
        /// <param name="enquiryDTO"></param>
        /// <returns></returns>

        [HttpPost]
        [Route("Create")]
        public IActionResult CreateEnquiry(dynamic enquiryDTO) // Error code: 501
        {
            try
            {
                string jsonInput = Convert.ToString(enquiryDTO);
                JObject jsonObj = JObject.Parse(jsonInput);
                string Input = JsonConvert.SerializeObject(jsonObj);
                string jsonObjectData = Convert.ToString(jsonObj["Json"]["Enquiry"]);
                jsonObj = JObject.Parse(jsonObjectData);
                EnquiryDTO enquiry = jsonObj.ToObject<EnquiryDTO>();

                IEnquiryManager objEnquiryManager = new EnquiryManager(LoggerInstance);
          //      LoggerInstance.Information(enquiry.EnquiryGuid + ": Create Enquiry Save call start", 50011);
                JObject returnObject = new JObject();
                enquiry = objEnquiryManager.Save(enquiry);
                LoggerInstance.Information(enquiry.EnquiryGuid + ": CreateEnquiry Save call end", 50011);
                return Ok(enquiry);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5001);
                return StatusCode(500);
            }
        }



        
        [HttpPost]
        [Route("api/Enquiry/SaveEnquiryForGratisOrder")]
        public IActionResult SaveEnquiryForGratisOrder(dynamic Json)
        {
            IEnquiryManager objEnquiryManager = new EnquiryManager(LoggerInstance);
            //string Input = JsonConvert.SerializeObject(Json);
            //JObject obj = (JObject)JsonConvert.DeserializeObject(Input);
            JObject returnObject = new JObject();
            //JObject jsonObj = JObject.Parse(obj["Json"]["Enquiry"].ToString());
            //var jdeBatchGenerator = jsonObj["JdeBatchGeneratorId"];

            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            string jsonObjectData = Convert.ToString(jsonObj["Json"]["Enquiry"]);
            jsonObj = JObject.Parse(jsonObjectData);
            var jdeBatchGenerator = jsonObj["JdeBatchGeneratorId"];
            EnquiryDTO enquiry = jsonObj.ToObject<EnquiryDTO>();
            if (Convert.ToString(jdeBatchGenerator) == "0")
            {
                returnObject = objEnquiryManager.SaveGratisOrder(enquiry);
            }
            return Ok(returnObject.ToString());
        }

       public static StringBuilder ConvertDataTableToCsvFileNew(DataTable dtData)
        {
            StringBuilder data = new StringBuilder();

            //Taking the column names.
            for (int column = 0; column < dtData.Columns.Count; column++)
            {
                //Making sure that end of the line, shoould not have comma delimiter.
                if (column == dtData.Columns.Count - 1)
                    data.Append(dtData.Columns[column].ColumnName.ToString().Replace(",", ";"));
                else
                    data.Append(dtData.Columns[column].ColumnName.ToString().Replace(",", ";") + ',');
            }

            data.Append(Environment.NewLine);//New line after appending columns.

            for (int row = 0; row < dtData.Rows.Count; row++)
            {
                for (int column = 0; column < dtData.Columns.Count; column++)
                {
                    ////Making sure that end of the line, shoould not have comma delimiter.
                    if (column == dtData.Columns.Count - 1)
                        data.Append(dtData.Rows[row][column].ToString().Replace(",", ";"));
                    else
                        data.Append(dtData.Rows[row][column].ToString().Replace(",", ";") + ',');
                }

                //Making sure that end of the file, should not have a new line.
                if (row != dtData.Rows.Count - 1)
                    data.Append(Environment.NewLine);
            }
            return data;
        }

        public static DataTable SetColumnsOrder(DataTable table, string columnNames)
        {
            string[] value = columnNames.Split(',');
            int columnIndex = 0;
            foreach (var columnName in value)
            {
                table.Columns[columnName].SetOrdinal(columnIndex);
                columnIndex++;
            }

            return table;
        }



        //[HttpPost]
        //[Route("api/Enquiry/SaveEnquiryForGratisOrder")]
        //public IActionResult SaveEnquiryForGratisOrder(dynamic Json)
        //{
        //    IEnquiryManager objEnquiryManager = new EnquiryManager(LoggerInstance);
        //    string Input = JsonConvert.SerializeObject(Json);
        //    JObject obj = (JObject)JsonConvert.DeserializeObject(Input);
        //    JObject returnObject = new JObject();
        //    JObject jsonObj = JObject.Parse(obj["Json"]["Enquiry"].ToString());
        //    var jdeBatchGenerator = jsonObj["JdeBatchGeneratorId"];
        //    if (Convert.ToString(jdeBatchGenerator) == "0")
        //    {
        //        returnObject = objEnquiryManager.SaveGratisOrder(Json);
        //    }
        //    return Ok("");
        //}
    }
}
