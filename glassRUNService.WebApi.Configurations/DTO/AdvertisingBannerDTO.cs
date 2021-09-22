using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.Configurations.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "AdvertisingBanner", IsNullable = false)]

    public class AdvertisingBannerDTO
    {
        public long? AdvertisingBannerId { get; set; }
        public long? RoleId { get; set; }
        public long? UserId { get; set; }
        public long? CompanyId { get; set; }

        public string BannerName { get; set; }

        public string BannerImage { get; set; }


        public DateTime? FromDate { get; set; }

        public DateTime? ToDate { get; set; }

        public string Field1 { get; set; }

        public string Field2 { get; set; }

        public string Field3 { get; set; }

        public string Field4 { get; set; }

        public string Field5 { get; set; }

        public string Field6 { get; set; }

        public string Field7 { get; set; }

        public string Field8 { get; set; }

        public string Field9 { get; set; }

        public string Field10 { get; set; }


        public long? CreatedBy { get; set; }

        public DateTime? CreatedDate { get; set; }

        public DateTime? UpdatedDate { get; set; }

        public long? UpdatedBy { get; set; }


        public string IsActive { get; set; }

        [XmlElement(ElementName = "AdvertisingBannerList")]
        public List<AdvertisingBannerDTO> AdvertisingBannerList { get; set; }
        public AdvertisingBannerDTO()
        {

            AdvertisingBannerList = new List<AdvertisingBannerDTO>();

        }
    }
}
