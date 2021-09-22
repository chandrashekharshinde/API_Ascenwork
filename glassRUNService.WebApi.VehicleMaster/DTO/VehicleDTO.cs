using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;
using glassRUN.Framework.Utility;

namespace glassRUNService.WebApi.VehicleMaster.DTO
{
    [Serializable, XmlRoot(ElementName = "TransportVehicleList", IsNullable = false)]
    public class VehicleDTO
    {
        //public string [bigint] IDENTITY(1,1) NOT NULL,

        public VehicleDTO()
        {
            TransportVehicleList = new List<VehicleDTO>();
            VehicleCompartmentList = new List<VehicleCompartmentDTO>();
            VehicleProductTypeList = new List<VehicleProductDTO>();
        }

        [XmlElement(ElementName = "TransportVehicleList")]
        public List<VehicleDTO> TransportVehicleList { get; set; }

        [XmlElement(ElementName = "VehicleProductTypeList")]
        public List<VehicleProductDTO> VehicleProductTypeList { get; set; }

        [XmlElement(ElementName = "VehicleCompartmentList")]
        public List<VehicleCompartmentDTO> VehicleCompartmentList { get; set; }
        public string VehicleName { get; set; }
        public long TransportVehicleId { get; set; }
        public string VehicleRegistrationNumber { get; set; }
        public long TransporterId { get; set; }
        public long VehicleTypeId { get; set; }
        public string NumberOfCompartments { get; set; }
        public long TruckSizeId { get; set; }
        public long? SequenceNumber { get; set; }
        public long IsVehicleInsured { get; set; }

        public string CollectionLocationCode { get; set; }
        public DateTime LicenseEffectiveDate { get; set; }
        public DateTime LicenseExpiryDate { get; set; }
        public DateTime InsuranceValidityDate { get; set; }

        public string IsFitnessCertificateAvailed { get; set; }

        public DateTime FitnessCertificateDate { get; set; }

        public string VehicleOwnerName { get; set; }
        public string VehicleOwnerAddress1 { get; set; }
        public string VehicleOwnerAddress2 { get; set; }
        public string FormatType { get; set; }
        public string RegisteredVehicleCertificateBlob { get; set; }
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
        public bool? IsActive { get; set; }

        public long? CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public long UpdatedBy { get; set; }
        public string UpdatedDate { get; set; }
    }
}
