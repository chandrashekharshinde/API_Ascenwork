using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using APIController.Framework.AppLogger;
using APIController.Framework.Controllers;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using glassRUNService.WebApi.ManageInventory.DTO;
using glassRUNService.WebApi.ManageInventory.Business;

namespace glassRUNService.WebApi.ManageInventory.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class InvertoryStockController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Inventory; }
        }

        

        [HttpPost]
        [Route("UpdateStockDetails")]
        public IActionResult UpdateStockDetails
            (dynamic transationDTO) // Error code: 501
        {
            try
            {
                string jsonInput = Convert.ToString(transationDTO);
                JObject jsonObj = JObject.Parse(jsonInput);
                string Input = JsonConvert.SerializeObject(jsonObj);
                string jsonObjectData = Convert.ToString(jsonObj["Json"]["InventoryTransaction"]);
                jsonObj = JObject.Parse(jsonObjectData);
                InventoryTransactionDTO inventoryTrans = jsonObj.ToObject<InventoryTransactionDTO>();
               // LoggerInstance.Information(Input, 5002);
                IInventoryStockManager objinventoryManager = new InventoryStockManager(LoggerInstance);
               LoggerInstance.Information(inventoryTrans.InventoryTransactionId + ": Update Stock  call start", 50011);
                JObject returnObject = new JObject();
                inventoryTrans = objinventoryManager.UpdateStockDetails(inventoryTrans);
                LoggerInstance.Information(inventoryTrans.InventoryTransactionId + ":  Update Stock  call end", 50011);
                return Ok(inventoryTrans);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5001);
                return StatusCode(500);
            }
        }
        [HttpPost]  
        [Route("GetStockDetails")]
        public IActionResult GetStockDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string jsonObjectData = Convert.ToString(jsonObj["Json"]);
            jsonObj = JObject.Parse(jsonObjectData);
            SearchItemstockDTO searchItemstockDTO= jsonObj.ToObject<SearchItemstockDTO>();
            returnObject = objInventoryManager.GetStockDetails(searchItemstockDTO);
            return Ok(returnObject);
        }
        [HttpPost]
        [Route("GetDeliveryLocStockDetails")]
        public IActionResult GetDeliveryLocItemStockDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string jsonObjectData = Convert.ToString(jsonObj["Json"]);
            jsonObj = JObject.Parse(jsonObjectData);
            SearchItemstockDTO searchItemstockDTO = jsonObj.ToObject<SearchItemstockDTO>();
            returnObject = objInventoryManager.GetDeliveryItemStockDetails(searchItemstockDTO);
            return Ok(returnObject);
        }

        [HttpPost]
        [Route("GetTransationDetails")]
        public IActionResult GetTransationDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string jsonObjectData = Convert.ToString(jsonObj["Json"]);
            jsonObj = JObject.Parse(jsonObjectData);
            ItemstocksearchDTO searchItemstockDTO = jsonObj.ToObject<ItemstocksearchDTO>();
            returnObject = objInventoryManager.GetTransationDetails(searchItemstockDTO);
            return Ok(returnObject);
        }

        [HttpPost]
        [Route("GetItemStockDetails")]
        public IActionResult GetItemStockDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string jsonObjectData = Convert.ToString(jsonObj["Json"]);
            jsonObj = JObject.Parse(jsonObjectData);
            ItemstocksearchDTO searchItemstockDTO = jsonObj.ToObject<ItemstocksearchDTO>();
            returnObject = objInventoryManager.GetItemStockDetails(searchItemstockDTO);
            return Ok(returnObject);
        }

        [HttpPost]
        [Route("GetReasonCodeDetails")]
        public IActionResult GetReasonCodeDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objInventoryManager.GetReasonCodeDetails(Input);
            return Ok(returnObject.ToString());
        }
        [HttpPost]
        [Route("GetRackandAisleDetails")]
        public IActionResult GetRackandAisleDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objInventoryManager.GetRackandAisleDetails(Input);
            return Ok(returnObject.ToString());
        }
        [HttpPost]
        [Route("GetLocationCodeDetails")]
        public IActionResult GetLocationCodeDetails(dynamic Json)
        {
            IInventoryStockManager objInventoryManager = new InventoryStockManager(LoggerInstance);
            JObject returnObject = new JObject();
            string jsonInput = Convert.ToString(Json);
            JObject jsonObj = JObject.Parse(jsonInput);
            string Input = JsonConvert.SerializeObject(jsonObj);
            returnObject = objInventoryManager.GetLocationCodeDetails(Input);
            return Ok(returnObject.ToString());
        }
    }

   
}
