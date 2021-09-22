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
    public class LotManager: ILotManager
    {
        BaseAppLogger _loggerInstance;
        public LotManager(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }
        public LotManager()
        {

        }
        public LotMasterDTO SaveLot(LotMasterDTO lotMasterDTO)
        {
            // ToDo: Business Validations3.6+20
            ValidateDTO();
            string lotMasterDTOXML = ObjectXMLSerializer<LotMasterDTO>.Save(lotMasterDTO);
            DataTable dtresponse = new DataTable();
            string output = ManageLotDataAccessManager.SaveLotMaster<string>(lotMasterDTOXML);
            if (output != null)
            {
                string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                JObject jsonObj = JObject.Parse(jsonOutput);
                string jsonObjectData = Convert.ToString(jsonObj["Json"]["LotId"]);
                lotMasterDTO.LotId = Convert.ToInt64(jsonObjectData);
            }

            return lotMasterDTO;
        }

        public bool ValidateDTO()
        {
            return true;
        }
        public JObject GetLotDetails(string lotDTO)
        {
            JObject returnObject = new JObject();
            string output = ManageLotDataAccessManager.GetLotDetails(lotDTO);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
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
