using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;


namespace glassRUNService.WebApi.ManageProduct.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "OrderProduct", IsNullable = false)]
    public class ProductDTO
    {
        /// <summary>
        /// Gets or Sets ItemId
        /// </summary>
        public long? ItemId { get; set; }

        /// <summary>
        /// Gets or Sets ItemName
        /// </summary>
        public string ItemName { get; set; }


        public string ItemNameInDefaultLanguage { get; set; }

        /// <summary>
        /// Gets or Sets ItemNameEnglishLanguage
        /// </summary>
        public string ItemNameEnglishLanguage { get; set; }

        /// <summary>
        /// Gets or Sets ItemCode
        /// </summary>

        public string ItemCode { get; set; }

        /// <summary>
        /// Gets or Sets ItemShortCode
        /// </summary>

        public string ItemShortCode { get; set; }

        /// <summary>
        /// Gets or Sets PrimaryUnitOfMeasure
        /// </summary>

        public string PrimaryUnitOfMeasure { get; set; }

        /// <summary>
        /// Gets or Sets SecondaryUnitOfMeasure
        /// </summary>

        public string SecondaryUnitOfMeasure { get; set; }

        /// <summary>
        /// Gets or Sets ProductType
        /// </summary>

        public string ProductType { get; set; }

        /// <summary>
        /// Gets or Sets BussinessUnit
        /// </summary>

        public string BussinessUnit { get; set; }

        /// <summary>
        /// Gets or Sets DangerGoods
        /// </summary>

        public bool? DangerGoods { get; set; }

        /// <summary>
        /// Gets or Sets Description
        /// </summary>

        public string Description { get; set; }

        /// <summary>
        /// Gets or Sets StockInQuantity
        /// </summary>

        public int? StockInQuantity { get; set; }

        /// <summary>
        /// Gets or Sets WeightPerUnit
        /// </summary>

        public int? WeightPerUnit { get; set; }

        /// <summary>
        /// Gets or Sets ImageUrl
        /// </summary>

        public string ImageUrl { get; set; }

        /// <summary>
        /// Gets or Sets PackSize
        /// </summary>

        public long? PackSize { get; set; }

        /// <summary>
        /// Gets or Sets BranchPlant
        /// </summary>

        public string BranchPlant { get; set; }

        /// <summary>
        /// Gets or Sets CreatedBy
        /// </summary>

        public long? CreatedBy { get; set; }

        /// <summary>
        /// Gets or Sets CreatedDate
        /// </summary>

        public DateTime? CreatedDate { get; set; }

        /// <summary>
        /// Gets or Sets ModifiedBy
        /// </summary>

        public long? ModifiedBy { get; set; }

        /// <summary>
        /// Gets or Sets ModifiedDate
        /// </summary>

        public DateTime? ModifiedDate { get; set; }

        /// <summary>
        /// Gets or Sets IsActive
        /// </summary>

        public bool? IsActive { get; set; }

        /// <summary>
        /// Gets or Sets SequenceNo
        /// </summary>

        public long? SequenceNo { get; set; }

        /// <summary>
        /// Gets or Sets PricingUnit
        /// </summary>

        public string PricingUnit { get; set; }

        /// <summary>
        /// Gets or Sets ShippingUnit
        /// </summary>

        public string ShippingUnit { get; set; }

        /// <summary>
        /// Gets or Sets ComponentUnit
        /// </summary>

        public string ComponentUnit { get; set; }

        /// <summary>
        /// Gets or Sets ItemClass
        /// </summary>

        public string ItemClass { get; set; }

        /// <summary>
        /// Gets or Sets ShelfLife
        /// </summary>

        public string ShelfLife { get; set; }

        /// <summary>
        /// Gets or Sets BBD
        /// </summary>

        public string BBD { get; set; }

        /// <summary>
        /// Gets or Sets Barcode
        /// </summary>

        public string Barcode { get; set; }

        /// <summary>
        /// Gets or Sets ItemOwner
        /// </summary>

        public long? ItemOwner { get; set; }

        /// <summary>
        /// Gets or Sets Field1
        /// </summary>

        public string Field1 { get; set; }

        /// <summary>
        /// Gets or Sets Field2
        /// </summary>

        public string Field2 { get; set; }

        /// <summary>
        /// Gets or Sets Field3
        /// </summary>

        public string Field3 { get; set; }

        /// <summary>
        /// Gets or Sets Field4
        /// </summary>

        public string Field4 { get; set; }

        /// <summary>
        /// Gets or Sets Field5
        /// </summary>

        public string Field5 { get; set; }

        /// <summary>
        /// Gets or Sets Field6
        /// </summary>

        public string Field6 { get; set; }

        /// <summary>
        /// Gets or Sets Field7
        /// </summary>

        public string Field7 { get; set; }

        /// <summary>
        /// Gets or Sets Field8
        /// </summary>

        public string Field8 { get; set; }

        /// <summary>
        /// Gets or Sets Field9
        /// </summary>

        public string Field9 { get; set; }

        /// <summary>
        /// Gets or Sets Field10
        /// </summary>

        public string Field10 { get; set; }

        /// <summary>
        /// Gets or Sets ItemType
        /// </summary>

        public string ItemType { get; set; }

        /// <summary>
        /// Gets or Sets AutomatedWareHouseUOM
        /// </summary>

        public long? AutomatedWareHouseUOM { get; set; }

        /// <summary>
        /// Gets or Sets Tax
        /// </summary>

        public string Tax { get; set; }

        /// <summary>
        /// Gets or Sets Length
        /// </summary>

        public int? Length { get; set; }

        /// <summary>
        /// Gets or Sets Breadth
        /// </summary>

        public int? Breadth { get; set; }

        /// <summary>
        /// Gets or Sets Height
        /// </summary>

        public int? Height { get; set; }

        /// <summary>
        /// Gets or Sets Brand
        /// </summary>

        public string Brand { get; set; }


        public DateTime? OrderDate { get; set; }

        public decimal Price { get; set; }

        public int? NumberOfVariations { get; set; }

        public long SoldTo { get; set; }

        public string UOM { get; set; }


        [XmlElement(ElementName = "ProductList")]
        public List<ProductDTO> ProductList { get; set; }


        public ProductDTO()
        {
            ProductList = new List<ProductDTO>();
        }


    }
}
