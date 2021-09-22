using glassRUNService.WebApi.ManageInventory.DTO;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.Business
{
    public interface IInventoryStockManager
    {
        InventoryTransactionDTO UpdateStockDetails(InventoryTransactionDTO InventoryTransDto);
        JObject GetStockDetails(SearchItemstockDTO searchItemstockDTO);
        JObject GetReasonCodeDetails(string jsondata);
        JObject GetRackandAisleDetails(string jsondata);
        JObject GetLocationCodeDetails(string jsondata);
        JObject GetItemStockDetails(ItemstocksearchDTO stockDTO);
        JObject GetTransationDetails(ItemstocksearchDTO stockDTO);
        JObject GetDeliveryItemStockDetails(SearchItemstockDTO stockDTO);

    }
}
