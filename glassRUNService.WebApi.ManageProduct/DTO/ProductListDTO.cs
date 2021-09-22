using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageProduct.DTO
{
    public class ProductListDTO
    {
      public  long ? ItemSupplierId { get; set; }
        public long?  ItemId { get; set; }
        public string   ItemCode { get; set; }
        public string ItemShortCode { get; set; }
        public long? CompanyId { get; set; }
        public string CompanyMnemonic { get; set; }
        public bool IsActive { get; set; }
        public long? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
    }
}
