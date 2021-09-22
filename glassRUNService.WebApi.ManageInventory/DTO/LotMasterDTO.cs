using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DTO
{
    public class LotMasterDTO
    {
		public long LotId { get; set; }
		public string LotNumber { get; set; }
		public string BusinessUnitCode { get; set; }
		public long ItemID { get; set; }
		public string ItemCode { get; set; }
		public string ItemShortCode { get; set; }
		public string CompanyCode { get; set; }
		public DateTime LotCreationDate { get; set; }
		public DateTime LotExpiryDate { get; set; }
		public DateTime SellByDate { get; set; }
		public string LotReusable { get; set; }
		public bool IsActive { get; set; }
		public long CreatedBy { get; set; }
		public DateTime CreatedDate { get; set; }
		public long ModifiedBy { get; set; }
		public DateTime ModifiedDate { get; set; }
		public string ItemName { get; set; }
	}
}
