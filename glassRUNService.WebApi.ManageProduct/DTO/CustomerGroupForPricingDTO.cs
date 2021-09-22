using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.ManageProduct.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "CustomerGroupForPricing", IsNullable = false)]
    public class CustomerGroupForPricingDTO
    {
        public long? CustomerGroupForPricingID { get; set; }

        public string CustomerGroupID { get; set; }

        public string CustomerPriceGroup { get; set; }

        public string CustomerGroupName { get; set; }

        public string GroupCode { get; set; }

        public long? CompanyId { get; set; }

        public long? CreatedBy { get; set; }

        public string CompanyCode { get; set; }

        public bool IsGroupAll { get; set; }

        public bool IsGroup { get; set; }

        public bool IsActive { get; set; }

        public DateTime? CreatedDate { get; set; }

        public string NumberOfCustomers { get; set; }

        public string NumberOfPricingVariations { get; set; }

        [XmlElement(ElementName = "CustomerGroupForPricingList")]
        public List<CustomerGroupForPricingDTO> CustomerGroupForPricingList { get; set; }

        [XmlElement(ElementName = "CustomerMasterForPricingList")]
        public List<CustomerMasterForPricingDTO> CustomerMasterForPricingList { get; set; }




        public CustomerGroupForPricingDTO()
        {
            CustomerGroupForPricingList = new List<CustomerGroupForPricingDTO>();
            CustomerMasterForPricingList = new List<CustomerMasterForPricingDTO>();
        }


    }
}
