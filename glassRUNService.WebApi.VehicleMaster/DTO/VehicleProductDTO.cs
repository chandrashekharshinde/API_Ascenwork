using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.VehicleMaster.DTO
{
    [Serializable, XmlRoot(ElementName = "VehicleProductTypeList", IsNullable = false)]
    public class VehicleProductDTO
    {
        public long TransportVehicleId { get; set; }
        public string ProductTypeId { get; set; }
        public string ProductType { get; set; }
        public bool? IsActive { get; set; }
        public long CreatedBy { get; set; }
        public string CreatedDate { get; set; }

    }
}
