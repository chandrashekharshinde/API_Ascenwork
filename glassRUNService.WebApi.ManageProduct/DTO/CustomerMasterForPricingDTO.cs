using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.ManageProduct.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "CustomerMasterForPricing", IsNullable = false)]
    public class CustomerMasterForPricingDTO
    {
        public long? CustomerMasterForPricingID { get; set; }

        public string CustomerNumber { get; set; }

        public string CustomerPriceGroup { get; set; }

        public string PriorityRating { get; set; }

        public string CustomerGroupName { get; set; }

        public string GroupCode { get; set; }

        public long? CompanyId { get; set; }

        public long? CreatedBy { get; set; }

        public string CompanyCode { get; set; }

        public bool IsActive { get; set; }

        public string Img { get; set; }


        [XmlElement(ElementName = "CustomerMasterForPricingList")]
        public List<CustomerMasterForPricingDTO> CustomerMasterForPricingList { get; set; }


        public CustomerMasterForPricingDTO()
        {
            CustomerMasterForPricingList = new List<CustomerMasterForPricingDTO>();
        }


    }
}
