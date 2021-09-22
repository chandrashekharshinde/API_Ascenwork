using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DTO
{
    public class ItemStockDTO
    {
		public long ItemStockId { get; set; }
		public string ItemCode { get; set; }
		public string DeliveryLocationCode { get; set; }
		public float ItemQuantity { get; set; }
		public bool LocationCode { get; set; }
		public string LotNumber { get; set; }
		public string SubLocationCode { get; set; }
		public decimal QuantityOnHand { get; set; }
		public decimal QuantitySoftCommitted { get; set; }
		public decimal QuantityHardCommitted { get; set; }
		public decimal QuantityInTransit { get; set; }
		public decimal QuantityInInspection { get; set; }
		public string CompanyCode { get; set; }
		public string BusinessUnitCode { get; set; }
		public string StockStatus { get; set; }
		public string Aisle { get; set; }
		public string Rack { get; set; }
		public long ItemID { get; set; }
		public string ItemShortCode { get; set; }
		public string ItemName { get; set; }
	
	}
}
