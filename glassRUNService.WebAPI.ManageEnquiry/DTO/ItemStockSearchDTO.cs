using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{

    public class ItemStockSearchDTO
    {
        public ItemStockSearchDTO()
        {
            
        }
        public string ProductCode { get; set; }

        public string CollectionLocationCode { get; set; }

        public DateTime? CreatedDate { get; set; }

    }
}
