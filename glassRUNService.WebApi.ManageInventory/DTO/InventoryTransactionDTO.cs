using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.ManageInventory.DTO
{
	[Serializable, XmlRoot(ElementName = "InventoryTransaction", IsNullable = false)]
	public class InventoryTransactionDTO
    {
		public InventoryTransactionDTO()
		{
			InventoryTransactionDetailList = new List<InventoryTransactionDetailDTO>();
		}

		[XmlElement(ElementName = "InventoryTransactionDetailList")]
		public List<InventoryTransactionDetailDTO> InventoryTransactionDetailList { get; set; }

		public long InventoryTransactionId { get; set; }
		public long InventoryTransactionType { get; set; }
		public DateTime TransactionDate { get; set; }
		public string CompanyCode { get; set; }
		public string ReferenceNumber { get; set; }
		public long CreatedBy { get; set; }
		public DateTime CreatedDate { get; set; }
		public long ModifiedBy { get; set; }
		public DateTime ModifiedDate { get; set; }
		public string DocumentNumber { get; set; }
		public long OrderId { get; set; }
		public string TruckBranchPlantCode { get; set; }
		public string BusinessUnitCode { get; set; }
		
	}
}
