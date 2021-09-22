using APIController.Framework.AppLogger;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.ManageInventory.DataAccess;
using glassRUNService.WebApi.ManageInventory.DTO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.Business
{
    public class InventoryStockManager: IInventoryStockManager
    {
        BaseAppLogger _loggerInstance;
        public InventoryStockManager(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }
        public InventoryStockManager()
        {

        }
        public InventoryTransactionDTO UpdateStockDetails(InventoryTransactionDTO inventoryTransactionDTO)
        {
            string output = "";

            ValidateDTO();

            string inventoryTransactionDTOXML = ObjectXMLSerializer<InventoryTransactionDTO>.Save(inventoryTransactionDTO);
            DataSet dsresponse = new DataSet();
            dsresponse = ManageInvertoryDataAccessManager.SaveInvertoryStock<DataSet>(inventoryTransactionDTOXML);
            if (dsresponse != null)
            {
                output = dsresponse.Tables[0].Rows[0][0].ToString();
                if (output != null)
                {
                    string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                    JObject jsonObj = JObject.Parse(jsonOutput);
                    string jsonObjectData = Convert.ToString(jsonObj["Json"]["InventoryTransactionId"]);
                    inventoryTransactionDTO.InventoryTransactionId = Convert.ToInt64(jsonObjectData);
                }
            }
            return inventoryTransactionDTO;
        }

        public bool ValidateDTO()
        {
            return true;
        }
        //Get GetTransationDetails
        public JObject GetTransationDetails(ItemstocksearchDTO searchDTO)
        {
            dynamic returnObject = new ExpandoObject();
            string output = ManageInvertoryDataAccessManager.GetTransactionDetail(searchDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject = null;
            }
            return returnObject;
        }

        //Get GetStockDetails
        public JObject GetStockDetails(SearchItemstockDTO stockDTO)
        {
            dynamic returnObject = new ExpandoObject();
            string output = ManageInvertoryDataAccessManager.GetStockDetail(stockDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject = null;
            }
            return returnObject;
        }
        public JObject GetDeliveryItemStockDetails(SearchItemstockDTO stockDTO)
        {
            dynamic returnObject = new ExpandoObject();
            string output = ManageInvertoryDataAccessManager.GetDeliveryLocitemStockDetail(stockDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject = null;
            }
            return returnObject;
        }

        //Get GetStockDetails
        public JObject GetItemStockDetails(ItemstocksearchDTO stockDTO)
        {
            dynamic returnObject = new ExpandoObject();
            string output = ManageInvertoryDataAccessManager.GetItemStockDetail(stockDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject = null;
            }
            return returnObject;
        }
        public JObject GetReasonCodeDetails(string jsondata)
        {
            JObject returnObject = new JObject();
            string output = ManageInvertoryDataAccessManager.GetReasonCodeDetails(jsondata);
            if (output != null)
            {
              
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject.Add("length", 0);
            }

            return returnObject;
        }
        public JObject GetRackandAisleDetails(string jsondata)
        {
            JObject returnObject = new JObject();
            string output = ManageInvertoryDataAccessManager.GetRackandAisleDetails(jsondata);
            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject.Add("length", 0);
            }
           
            return returnObject;
        }
        public JObject GetLocationCodeDetails(string jsondata)
        {
            JObject returnObject = new JObject();
            string output = ManageInvertoryDataAccessManager.GetLocationcodeDetails(jsondata);
            if (output != null)
            {

                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            else
            {
                returnObject.Add("length", 0);
            }
            return returnObject;
        }
    }
}
