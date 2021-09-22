using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.Configurations.DTO
{

    [Serializable]
    [XmlRoot(ElementName = "ConfigurationModificationStatus", IsNullable = false)]
    public class ConfigurationModificationStatusDTO
    {
        public long? ConfigurationModificationStatusId { get; set; }

        public string ConfigurationCode { get; set; }

        public string APIName { get; set; }

        public string APIUrl { get; set; }

        public DateTime? CreatedDate { get; set; }

        public long? CreatedBy { get; set; }

        public DateTime? ModifiedDate { get; set; }

        public long? ModifiedBy { get; set; }

        public long AppType { get; set; }

        public bool IsApiRequired { get; set; }



        [XmlElement(ElementName = "ConfigurationModificationStatusList")]
        public List<ConfigurationModificationStatusDTO> ConfigurationModificationStatusList { get; set; }
        public ConfigurationModificationStatusDTO()
        {

            ConfigurationModificationStatusList = new List<ConfigurationModificationStatusDTO>();

        }
    }
}
