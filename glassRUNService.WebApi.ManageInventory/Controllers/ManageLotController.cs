using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using APIController.Framework.AppLogger;
using APIController.Framework.Controllers;
using glassRUNService.WebApi.ManageInventory.Business;
using glassRUNService.WebApi.ManageInventory.DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace glassRUNService.WebApi.ManageInventory.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ManageLotController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Inventory; }
        }


        [HttpPost]
        [Route("SaveLotMaster")]
        public IActionResult SaveLotMaster(dynamic lotDTO) // Error code: 501
        {
            try
            {
                string jsonInput = Convert.ToString(lotDTO);
                JObject jsonObj = JObject.Parse(jsonInput);
                string Input = JsonConvert.SerializeObject(jsonObj);
                string jsonObjectData = Convert.ToString(jsonObj["Json"]);
                jsonObj = JObject.Parse(jsonObjectData);
                LotMasterDTO lotMasterDTO = jsonObj.ToObject<LotMasterDTO>();

                ILotManager objlotManager = new LotManager(LoggerInstance);
                LoggerInstance.Information(lotMasterDTO.LotId + ":LotMaster Save call start", 50011);
                JObject returnObject = new JObject();
                lotMasterDTO = objlotManager.SaveLot(lotMasterDTO);
                LoggerInstance.Information(lotMasterDTO.LotId + ":LotMaster Save call end", 50011);
                return Ok(lotMasterDTO);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5001);
                return StatusCode(500);
            }
        }
        [HttpPost]
        [Route("GetLotDetails")]
        public IActionResult GetLotDetails(dynamic Json)
        {
            ILotManager objlotManager = new LotManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objlotManager.GetLotDetails(Input);
            return Ok(returnObject.ToString());
        }
    }
}
