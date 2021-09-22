using System;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "ReturnPakageMaterial", IsNullable = false)]
    public class ReturnPakageMaterialDTO
    {


        public long? ReturnPakageMaterialId { get; set; }

        public long? EnquiryId { get; set; }

        public string ProductCode { get; set; }

        public string ParentProductCode { get; set; }

        public string ProductType { get; set; }

        public decimal? ProductQuantity { get; set; }

        public decimal? ItemPricesPerUnit { get; set; }

        public string Remarks { get; set; }

        public long? ItemType { get; set; }
        public long? CreatedBy { get; set; }
        public long? AssociatedOrder { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool IsActive { get; set; }

        public long? SequenceNo { get; set; }

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


    }
}
