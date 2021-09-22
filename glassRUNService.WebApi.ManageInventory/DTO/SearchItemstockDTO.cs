using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DTO
{
    public class SearchItemstockDTO
    {
		public string ItemCode { get; set; }
		public string DeliveryLocationCode { get; set; }
		public string LocationCode { get; set; }
		public string LotNumber { get; set; }
		public string Aisle { get; set; }
		public string Rack { get; set; }
		public string BusinessUnitCode { get; set; }
		public string CompanyCode { get; set; }
		
	}
	
}
