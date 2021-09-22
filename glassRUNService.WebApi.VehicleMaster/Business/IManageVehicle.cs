using glassRUNService.WebApi.VehicleMaster.DTO;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.VehicleMaster.Business
{
    interface IManageVehicle
    {
        JObject SaveVehicle(string Json);
        JObject GetVehicleByID(string Json);
        JObject DeleteVehicleByID(string Json);
        JObject GetPlateNumberByCarrier(string Json);
        JObject GetDriverByPlateNumberId(string Json);
        JObject GetAllPlateNumberForSecurityApp(string Json);
        JObject LoadTransportVehicleById(string Json);
        JObject GetTransportVehicleDetailsById(string Json);
        JObject DeleteTransportVehicle(string Json);
        JObject GetTransportVehiclePaging(string Json);
        JObject LoadTransportVehicleDetails(string Json);
        JObject CheckDuplicateTransportVehicale(string Json);
        JObject GetCountry();
        JObject GetAllVehicleForThirdPartySync();
    }
}
