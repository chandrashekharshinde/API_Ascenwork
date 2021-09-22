using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{

    [Serializable]
    [XmlRoot(ElementName = "Enquiry", IsNullable = false)]
    public class EnquirySearchDTO
    {
        public EnquirySearchDTO()
        {
            EnquirySearchParameterList = new List<EnquirySearchParameterDTO>();
            ReasonCodeList = new List<ReasonCodeDTO>();
        }

        public string EnquiryDescription { get; set; }
        public long? EnquiryId { get; set; }
        public long? ObjectId { get; set; } = 0;

        public bool IsCancelEnquiry { get; set; } = false;
        public bool IsRejectEnquiry { get; set; } = false;
        public long Priority { get; set; } = 0;
        public string PriorityValue { get; set; } = "";
        public string ObjectNumber { get; set; } = "";
        public string EnquiryAutoNumber { get; set; }
        public string OrderNumber { get; set; }
        public string Region { get; set; }
        public string ProvinceDesc { get; set; }
        public string EnquiryType { get; set; }
        public string ShipToCode { get; set; }
        public string ShipToName { get; set; }
        public string SoldToCode { get; set; }
        public string SoldToName { get; set; }
        public string BillToCode { get; set; }
        public string BillToName { get; set; }
        public long? CompanyId { get; set; }
        public string CompanyCode { get; set; }
        public string CompanyName { get; set; }
        public string CarrierCode { get; set; }
        public string CarrierName { get; set; }
        public string CollectionLocationCode { get; set; }
        public string CollectionLocationName { get; set; }
        public string TruckSize { get; set; }
        public string PONumber { get; set; }
        public string SONumber { get; set; }
        public string CurrentState { get; set; }
        public DateTime? PickDateTimeFrom { get; set; }
        public DateTime? PickDateTimeTo { get; set; }
        public DateTime? EnquiryDateFrom { get; set; }
        public DateTime? EnquiryDateTo { get; set; }
        public DateTime? RequestDateFrom { get; set; }
        public DateTime? RequestDateTo { get; set; }
        public int? PageIndex { get; set; } = 0;
        public int? PageSize { get; set; } = 1;
        public long? RoleId { get; set; } = 0;
        public long? CultureId { get; set; }
        public DateTime? LastSyncDate { get; set; }
        public string OrderBy { get; set; }
        public string OrderByCriteria { get; set; }
        public string PageName { get; set; }
        public string PageControlName { get; set; }
        public string whereClause { get; set; }
        public long? LoginId { get; set; } = 0;
        public string RelatedEnquiryNumber { get; set; }
        public string Area { get; set; }
        public string TypeOfWay { get; set; }

        public long ExternalSystemStatus { get; set; }

        public string ExternalSystemStatusText { get; set; }

        public DateTime? ExternalSystemStatusSyncTime { get; set; }


        public bool? FileAttached { get; set; }

        public bool? FileAttachedDownload { get; set; }

        public string DocumentFormat { get; set; }

        public string DocumentName { get; set; }

        public bool? IsExportToExcel { get; set; }
        public string Status { get; set; }

        [XmlElement(ElementName = "EnquirySearchParameterList")]
        public List<EnquirySearchParameterDTO> EnquirySearchParameterList { get; set; }

        [XmlElement(ElementName = "ReasonCodeList")]
        public List<ReasonCodeDTO> ReasonCodeList { get; set; }

        [XmlElement(ElementName = "EnquirySearchParameterDTO")]
        public List<EnquiryGridColumnDTO> EnquiryGridColumnList { get; set; }

        public string SubChannel { get; set; }

    }
}
