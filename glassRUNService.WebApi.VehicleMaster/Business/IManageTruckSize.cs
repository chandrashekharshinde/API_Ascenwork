using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.VehicleMaster.Business
{
    interface IManageTruckSize
    {
        JObject GetAllTruckSizeListByVehicleId(string Json);
    }
}
