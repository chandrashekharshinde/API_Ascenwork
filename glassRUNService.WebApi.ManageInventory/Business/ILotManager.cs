using glassRUNService.WebApi.ManageInventory.DTO;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.Business
{
  public  interface ILotManager
    {
        LotMasterDTO SaveLot(LotMasterDTO lotMasterDTO);
        JObject GetLotDetails(string lotDTO);
    }
}
