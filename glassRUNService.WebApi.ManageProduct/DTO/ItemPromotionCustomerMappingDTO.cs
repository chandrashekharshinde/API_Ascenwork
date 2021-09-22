using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;


namespace glassRUNService.WebApi.ManageProduct.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "ItemPromotionCustomerMapping", IsNullable = false)]
    public class ItemPromotionCustomerMappingDTO
    {

        public long? PromotionCustomerMappingId { get; set; }


        public long? CustomerId { get; set; }

        public string CustomerCode { get; set; }

        public long? ExternalSystemRefID { get; set; }


        public long? AllocatedQuantity { get; set; }


        public long? ConsumedQuantity { get; set; }

        [XmlElement(ElementName = "ItemPromotionCustomerMappingList")]
        public List<ItemPromotionCustomerMappingDTO> ItemPromotionCustomerMappingList { get; set; }

        public ItemPromotionCustomerMappingDTO()
        {
            ItemPromotionCustomerMappingList = new List<ItemPromotionCustomerMappingDTO>();
        }

    }
}
