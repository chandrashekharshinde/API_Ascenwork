using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{

	[Serializable]
	[XmlRoot(ElementName = "ConsolidatedProductsSearch", IsNullable = false)]
	public class ConsolidatedProductsSearchDTO
    {
		public ConsolidatedProductsSearchDTO()
		{

		}
		public long? EnquiryId { get; set; }
		public string EnquiryAutoNumber { get; set; }
		public string SoldToCode { get; set; }
		public string SoldToName { get; set; }
		public string ShipToCode { get; set; }
		public string ShipToName { get; set; }
		public string ProductCode { get; set; }
		public string ProductName { get; set; }
		public long? ProductQuantity { get; set; }
		public string UOM { get; set; }
		public DateTime? RequestDate { get; set; }
		public decimal? UnitPrice { get; set; }
		public decimal? TotalPrice { get; set; }
		public long? TotalEnquiriesCount { get; set; }
		public long? Stock { get; set; }
		public long? PriorityRating { get; set; }
		public DateTime? RequestDateFrom { get; set; }
		public DateTime? RequestDateTo { get; set; }
		public long? CompanyId { get; set; }
	}
}
