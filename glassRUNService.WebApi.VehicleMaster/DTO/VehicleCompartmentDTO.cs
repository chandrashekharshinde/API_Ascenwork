using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.VehicleMaster.DTO
{
    [Serializable, XmlRoot(ElementName = "VehicleCompartmentList", IsNullable = false)]
    public class VehicleCompartmentDTO
    {
        public string CompartmentName { get; set; }
        public string Capacity { get; set; }
        public long UnitOfMeasureId { get; set; }
        public string UnitOfMeasure { get; set; }
        public bool? IsActive { get; set; }
        public long CreatedBy { get; set; }
        public string CreatedDate { get; set; }

    }
}
