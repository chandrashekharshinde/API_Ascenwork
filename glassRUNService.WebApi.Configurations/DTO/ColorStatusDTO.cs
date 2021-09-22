using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.Configurations.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "ColorStaus", IsNullable = false)]
    public class ColorStatusDTO
    {
        public long? RoleId { get; set; }

        public long? CultureId { get; set; }

        public long? StatusId { get; set; }

        public long? Sequence { get; set; }

        public string Class { get; set; }

        public string Status { get; set; }

        [XmlElement(ElementName = "ColorStausList")]
        public List<ColorStatusDTO> ColorStausList { get; set; }
        public ColorStatusDTO()
        {

            ColorStausList = new List<ColorStatusDTO>();

        }
    }
}
