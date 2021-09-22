using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.Configurations.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "Brand", IsNullable = false)]
    public class BrandDTO
    {
        public long? BrandId { get; set; }

        public string BrandName { get; set; }

        public string BrandLogo { get; set; }


        public long? CreatedBy { get; set; }

        public DateTime? CreatedDate { get; set; }

        public DateTime? UpdatedDate { get; set; }

        public long? UpdatedBy { get; set; }


        public string IsActive { get; set; }

        [XmlElement(ElementName = "BrandList")]
        public List<BrandDTO> BrandList { get; set; }
        public BrandDTO()
        {

            BrandList = new List<BrandDTO>();

        }
    }
}
