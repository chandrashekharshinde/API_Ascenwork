using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;



namespace glassRUNService.WebApi.ManageProduct.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "ItemBasePrice", IsNullable = false)]
    public class ItemBasePriceDTO
    {
        public long? ItemBasePriceID { get; set; }
        public long? ItemId { get; set; }

        public string ItemName { get; set; }

        public string ItemShortCode { get; set; }

        public string ItemLongCode { get; set; }

        public string AddressNumber { get; set; }

        public string CurrencyCode { get; set; }

        public string UOM { get; set; }

        public string ApplicableFor { get; set; }

        public string Brand { get; set; }

        public string ImageUrl { get; set; }

        public DateTime? EffectiveDate { get; set; }

        public DateTime? ExpiryDate { get; set; }

        public string CustomerGroupName { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public decimal? Price { get; set; }

        public string CustomerGroupID { get; set; }


        public string CustomerPriceGroup { get; set; }

        public string ItemGroupId { get; set; }

        public long? CompanyId { get; set; }

        public string CompanyCode { get; set; }

        public bool IsGroupAll { get; set; }


        public bool IsGroup { get; set; }

        public bool IsValid { get; set; }

        public bool IsActive { get; set; }

        [XmlElement(ElementName = "ItemBasePriceList")]
        public List<ItemBasePriceDTO> ItemBasePriceList { get; set; }



        [XmlElement(ElementName = "CustomerGroupForPricing")]
        public CustomerGroupForPricingDTO CustomerGroupForPricing { get; set; }


        [XmlElement(ElementName = "CustomerMasterForPricingList")]
        public List<CustomerMasterForPricingDTO> CustomerMasterForPricingList { get; set; }


        public ItemBasePriceDTO()
        {
            ItemBasePriceList = new List<ItemBasePriceDTO>();
            CustomerGroupForPricing = new CustomerGroupForPricingDTO();
            CustomerMasterForPricingList = new List<CustomerMasterForPricingDTO>();
        }


    }
}
