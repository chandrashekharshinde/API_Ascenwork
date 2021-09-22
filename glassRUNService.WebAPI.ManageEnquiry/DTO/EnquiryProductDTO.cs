using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{

    [Serializable]
    [XmlRoot(ElementName = "EnquiryProduct", IsNullable = false)]
    public class EnquiryProductDTO
    {
        public string EnquiryAutoNumber { get; set; }
        public string AssociatedOrderNumber { get; set; }
        public string EnquiryGuid { get; set; }
        public long? EnquiryProductId { get; set; }
        public long? ItemId { get; set; }
        public long? TotalEnquiriesCount { get; set; } = 0;
        public long? ParentItemId { get; set; }
        public long? CompanyId { get; set; }
        public string CompanyCode { get; set; }
        public long? EnquiryId { get; set; }
        public string ProductCode { get; set; }
        public string PrimaryUnitOfMeasure { get; set; }
        public string ProductName { get; set; }

        public string ItemNameInDefaultLanguage { get; set; }

        public string UOM { get; set; }
        public string ParentProductCode { get; set; }
        public string ProductType { get; set; }
        public decimal? ProductQuantity { get; set; }//long?
        public decimal? WeightPerUnit { get; set; }
        public decimal? AvailableQuantity { get; set; }
        public decimal? DepositeAmount { get; set; }   
        public string Remarks { get; set; }
        public string AssociatedOrder { get; set; }
        public decimal? ItemPricesPerUnit { get; set; }//long?
        public DateTime? EffectiveDate { get; set; }    
        public decimal? Price { get; set; }             
        public decimal? UnitPrice { get; set; }         
        public decimal? TotalUnitPrice { get; set; }    
        public long? CurrentStockPosition { get; set; } 
        public DateTime? CreatedDate { get; set; }

        public DateTime? ModifiedDate { get; set; }
        public long? ItemType { get; set; }
        public decimal? CurrentItemPalettesCorrectWeight { get; set; }
        public decimal? CurrentItemTruckCapacityFullInTon { get; set; }
        public string IsActive { get; set; }
        public long? NumberOfExtraPallet { get; set; }
        public int? PriorityRating { get; set; } = 0;
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
        public decimal? DiscountPercent { get; set; }
        public decimal? DiscountAmount { get; set; } 
        public long? PaymentType { get; set; }       
        public long? ReplacementParentProductId { get; set; }          
        public string IsReplaceable { get; set; }//Missing
        public long? LastStatus { get; set; }
        public long? NextStatus { get; set; }
        public string StockLocationCode { get; set; }
        public string StockLocationName { get; set; }
        public decimal? TotalVolume { get; set; }
        public decimal? TotalWeight { get; set; }
        public string CollectionLocationCode { get; set; }
        public decimal? PackingItemCount { get; set; }
        public string PackingItemCode { get; set; }
        public string IsPackingItem { get; set; }
        public long? NumberOfExtraPalettes { get; set; }
        public decimal? DepositeAmountPerUnit { get; set; }
        public string AllocationExists { get; set; }
        public long? AllocationQty { get; set; }
        public string ImageUrl { get; set; }
        public long? CreatedBy { get; set; }
        public long? ModifiedBy { get; set; }

        public long? NumberOfPromotions { get; set; }
        public decimal? AdditionalQuantity { get; set; }

        public long? AvailableNumberOfPromotions { get; set; }
        public decimal? AvailableAdditionalQuantity { get; set; }

        public string PromotionRefId { get; set; }
    }
  
}
