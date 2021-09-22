using System;
using System.Collections.Generic;
using System.Xml.Serialization;
using glassRUN.Framework.Utility;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{
    [Serializable, XmlRoot(ElementName = "Enquiry", IsNullable = false)]
    public class EnquiryDTO
    {

        public EnquiryDTO()
        {
            EnquiryList = new List<EnquiryDTO>();
            ProductList = new List<EnquiryProductDTO>();
            NoteList = new List<NoteDTO>();
            ReturnPakageMaterialList = new List<ReturnPakageMaterialDTO>();
            ReasonCodeList = new List<ReasonCodeDTO>();
        }
        public string CopyEnquiryGuid { get; set; }
        public string ReferenceGUIDRPM { get; set; }

        public string WorkFlowCode { get; set; }

        public string EnquiryGuid { get; set; }
        public string InquiryDescription { get; set; }

        public string IsOrderSelfCollect { get; set; }

        public string ActivityStartTime { get; set; }

        public long? PriorityRating { get; set; }

        [XmlElement(ElementName = "EnquiryList")]
        public List<EnquiryDTO> EnquiryList { get; set; }

        [XmlElement(ElementName = "ProductList")]
        public List<EnquiryProductDTO> ProductList { get; set; }

        [XmlElement(ElementName = "NoteList")]
        public List<NoteDTO> NoteList { get; set; }

        [XmlElement(ElementName = "ReturnPakageMaterialList")]
        public List<ReturnPakageMaterialDTO> ReturnPakageMaterialList { get; set; }

        public bool IsCancelEnquiry { get; set; } = false;
        public bool IsRejectEnquiry { get; set; } = false;
        public long? EnquiryId { get; set; }
        public long? ObjectId { get; set; } = 0;
        public string ObjectNumber { get; set; } = "";
        public string OrderNumber { get; set; }
        public long? CompanyId { get; set; }
        public long? RelatedEnquiryId { get; set; }

        public bool? FileAttached { get; set; }

        public bool? FileAttachedDownload { get; set; }
        public string CompanyCode { get; set; }
        public string IsDifferentSKU { get; set; }

        public string TypeOfWay { get; set; }

        public string DocumentName { get; set; }

        public string DocumentFormat { get; set; }
        public string SKUPhoto { get; set; }
        public string File { get; set; }
        public string FileFormat { get; set; }
        public string DocumentExtension { get; set; }
        public string EditCompanyCode { get; set; }

        public bool? IsExportToExcel { get; set; }

        public long EditRoleId { get; set; } = 0;
        public long Priority { get; set; } = 0;
        public string PriorityValue { get; set; } = "";
        public string CompanyName { get; set; }
        public string EnquiryGroupNumber { get; set; }
        public string EnquiryAutoNumber { get; set; }

        public string EnquiryType { get; set; }
        public long? SoldTo { get; set; }
        public string SoldToCode { get; set; }
        public string SoldToName { get; set; }
        public long? ShipTo { get; set; }
        public string ShipToCode { get; set; }
        public string ShipToName { get; set; }

        public string ShipToLocationAddress { get; set; }
        public long? BillTo { get; set; }
        public string BillToCode { get; set; }
        public string BillToName { get; set; }
        public DateTime? PickDateTime { get; set; }
        public DateTime? EnquiryDate { get; set; }

        public DateTime? RequestDate { get; set; }
        public long? PrimaryAddressId { get; set; }
        public long? SecondaryAddressId { get; set; }
        public string PrimaryAddress { get; set; }
        public string SecondaryAddress { get; set; }
        public string OrderProposedETD { get; set; }
        public string Remarks { get; set; }
        public long? PreviousState { get; set; }
        public long? CurrentState { get; set; }
        
        public long? PreviousProcess { get; set; }
        public long? CurrentProcess { get; set; }
        public long? TruckSizeId { get; set; }

        public string TruckSize { get; set; }
        public long? CollectionDateFromSettingValue { get; set; }
        public decimal? PalletSpace { get; set; }
        public decimal? NumberOfPalettes { get; set; }
        public decimal? TruckWeight { get; set; }
        public long? OrderedBy { get; set; }
        public string GratisCode { get; set; }
        public string Province { get; set; }
        public string Description1 { get; set; }
        public string Description2 { get; set; }
        public string IsRecievingLocationCapacityExceed { get; set; }
        public long? StockLocationId { get; set; }
        public DateTime? CreatedDate { get; set; }

        public DateTime? ModifiedDate { get; set; }
        public string IsActive { get; set; }

        public bool IsAdhoc { get; set; } = false;

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
        public string RelatedEnquiryNumber { get; set; }

        public int? ReturnableItemCheck { get; set; }
        public int? ReceivingLocationCapacityCheck { get; set; }
        public int? StockCheck { get; set; }
        //public bool? IsProcess { get; set; }
        public DateTime? PromisedDate { get; set; }
        public string PONumber { get; set; }
        public long? PaymentType { get; set; }
        public decimal? DiscountPercent { get; set; }
        public decimal? DiscountAmount { get; set; }
        public decimal? PaymentDiscountPercent { get; set; }
        public decimal? TotalDepositeAmount { get; set; }
        public decimal? TotalDiscountAmount { get; set; }
        public decimal? TotalOrderAmount { get; set; }
        public decimal? TotalAmount { get; set; }
        public string IsSynced { get; set; }
        public string PresellerCode { get; set; }
        public string PresellerName { get; set; }
        public decimal? TotalTaxAmount { get; set; }
        public decimal? TotalQuantity { get; set; }
        public decimal? TotalPrice { get; set; }
        public decimal? TotalVolume { get; set; }
        public decimal? TotalWeight { get; set; }
        public long? NumberOfCrate { get; set; }

        public long? NoOfDays { get; set; }

        public string SONumber { get; set; }
        public bool IsSelfCollect { get; set; }
        public long? CarrierId { get; set; }//long?
        public string CarrierCode { get; set; }
        public string CarrierName { get; set; }

        public long? CollectionLocationId { get; set; }
        public string CollectionLocationCode { get; set; }
        public string CollectionLocationName { get; set; }

        public DateTime? OriginalCollectionDate { get; set; }
        public long? BillToId { get; set; }
        public long? LoginId { get; set; } = 0;
        public long? CreatedBy { get; set; }
        public long? ModifiedBy { get; set; }
        public string StatusResourceKey { get; set; }
        public string StatusClass { get; set; }

        public long ExternalSystemStatus { get; set; }

        public string ExternalSystemStatusText { get; set; }

        public string Region { get; set; }
        public string ProvinceDesc { get; set; }

        public DateTime? ExternalSystemStatusSyncTime { get; set; }

        public long? TotalCount { get; set; } = 0;

        public bool IsSOAttached { get; set; } = false;

        #region Extra Input parameter for SSP_GetEnquiryDetailsOfCustomerV2 
        public DateTime? PickDateTimeFrom { get; set; }
        public DateTime? PickDateTimeTo { get; set; }
        public DateTime? EnquiryDateFrom { get; set; }
        public DateTime? EnquiryDateTo { get; set; }
        public DateTime? RequestDateFrom { get; set; }
        public DateTime? RequestDateTo { get; set; }

        public DateTime? LastSyncDate { get; set; }
        //public string Status { get; internal set; } // resonse from Sp
        public string RPMValue { get; set; }

        public long? EmptiesLimit { get; set; }
        public long? ActualEmpties { get; set; }
        public string Empties { get; set; }

        public long? ReceivedCapacityPalettes { get; set; }

        public string Area { get; set; }
        public string ZoneName { get; set; }

        public string AssociatedOrder { get; set; }

        public string TotalPriceWithCurreny { get; set; }

        public string IsAvailableStock { get; set; }

        public string ReceivedCapacityPalettesCheck { get; set; }

        public bool CheckedEnquiry { get; set; }

        public long? Capacity { get; set; }

        public long? RoleId { get; set; } = 0;

        public long? CultureId { get; set; }


        public long? IsAnyItemPriceZero { get; set; }

        public string Status { get; set; }
        public string Class { get; set; }

        public string ShortName { get; set; }

        public string ExternalSystemRefID { get; set; }

        public string ErrorMessage { get; set; }

        public string SubChannel { get; set; }

        #endregion
        #region extra parameter for USP_EnquiryV2
        //public long? ReasonCodeId { get; set; } = 0;
        [XmlElement(ElementName = "ReasonCodeList")]
        public List<ReasonCodeDTO> ReasonCodeList { get; set; }

        #endregion
    }

}