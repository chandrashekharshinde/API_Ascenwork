using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{

    [Serializable]
    [XmlRoot(ElementName = "ConsolidatedProducts", IsNullable = false)]
    public class ConsolidatedProductsDTO
    {
        public long? EnquiryId { get; set; } = 0;
        public string EnquiryAutoNumber { get; set; }
        public string SoldToCode { get; set; }
        public string SoldToName { get; set; }
        public string ShipToCode { get; set; }
        public string ShipToName { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public decimal? ProductQuantity { get; set; } = 0;
        public string UOM { get; set; }
        public DateTime? RequestDate { get; set; }
        public decimal? UnitPrice { get; set; } = 0;
        public decimal? TotalPrice { get; set; } = 0;
        public long TotalEnquiriesCount { get; set; } = 0;
        public long Stock { get; set; } = 0;
        public long PriorityRating { get; set; } = 0;
        public DateTime? EnquiryDateFrom { get; set; }
        public DateTime? EnquiryDateTo { get; set; }
    }
}
