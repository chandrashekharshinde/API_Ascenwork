using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DTO
{
    public class InventoryTransactionDetailDTO
    {
		public long InventoryTransactionDetailId { get; set; }
		public long InventoryTransactionId { get; set; }
		public long TransactionType { get; set; }
		public int AdjustmentType { get; set; }
		public string ItemCode { get; set; }
		public decimal Quantity { get; set; }
		public string BranchPlantCode { get; set; }
		public string LocationCode { get; set; }
		public string SubLocationCode { get; set; }
		public string Aisle { get; set; }
		public string Rack { get; set; }
		public string LotNumber { get; set; }
		public long CreatedBy { get; set; }
		public DateTime CreatedDate { get; set; }
		public long ModifiedBy { get; set; }
		public DateTime? ModifiedDate { get; set; }
		public long ItemID { get; set; }
		public string ItemShortCode { get; set; }
		public string ItemName { get; set; }
		public string ReasonCode { get; set; }
		public string Reason { get; set; }

	}
}
