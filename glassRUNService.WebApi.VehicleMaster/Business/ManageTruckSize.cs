using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.VehicleMaster.DTO;
using glassRUNService.WebApi.VehicleMaster.DataAccess;
using APIController.Framework.AppLogger;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using glassRUN.Framework;
//using glassRUNService.WebApi.Configurations.DTO;
using System.Text.RegularExpressions;
using glassRUNProduct.DataAccess.Common;
using System.Dynamic;


namespace glassRUNService.WebApi.VehicleMaster.Business
{
    public class ManageTruckSize : IManageTruckSize
    {
        BaseAppLogger _loggerInstance;
        public ManageTruckSize(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }

        public ManageTruckSize()
        {

        }

        //Get All Truck Size List By Vehicle Id
        public JObject GetAllTruckSizeListByVehicleId(string Json)
        {
            dynamic returnObject = new ExpandoObject();
            string output = TruckSizeDataAccessManager.GetAllTruckSizeListByVehicleId(Json);
            if (output != null)
            {
                //string jsonOutput = JSONAndXMLSerializer.XMLtoJSON(output);
                returnObject = (JObject)JsonConvert.DeserializeObject(output);
            }
            return returnObject;
        }
    }
}
