/*
 * WebAPIBuild
 *
 * This is glassRUN web api library for 3rd party and internal reference
 *
 * OpenAPI spec version: 1.0
 * 
 * Generated by: https://github.com/swagger-api/swagger-codegen.git
 */
using System;
using System.Linq;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using Newtonsoft.Json;

namespace IO.Swagger.Models
{ 
    /// <summary>
    /// 
    /// </summary>
    [DataContract]
    public partial class GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO : IEquatable<GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO>
    { 
        /// <summary>
        /// Gets or Sets OrderFeedbackId
        /// </summary>
        [DataMember(Name="orderFeedbackId")]
        public long? OrderFeedbackId { get; set; }

        /// <summary>
        /// Gets or Sets OrderId
        /// </summary>
        [DataMember(Name="orderId")]
        public long? OrderId { get; set; }

        /// <summary>
        /// Gets or Sets OrderProductId
        /// </summary>
        [DataMember(Name="orderProductId")]
        public long? OrderProductId { get; set; }

        /// <summary>
        /// Gets or Sets FeedbackId
        /// </summary>
        [DataMember(Name="feedbackId")]
        public long? FeedbackId { get; set; }

        /// <summary>
        /// Gets or Sets Field1
        /// </summary>
        [DataMember(Name="field1")]
        public string Field1 { get; set; }

        /// <summary>
        /// Gets or Sets Field2
        /// </summary>
        [DataMember(Name="field2")]
        public string Field2 { get; set; }

        /// <summary>
        /// Gets or Sets IsActive
        /// </summary>
        [DataMember(Name="isActive")]
        public bool? IsActive { get; set; }

        /// <summary>
        /// Gets or Sets Attachment
        /// </summary>
        [DataMember(Name="attachment")]
        public string Attachment { get; set; }

        /// <summary>
        /// Gets or Sets Quantity
        /// </summary>
        [DataMember(Name="quantity")]
        public double? Quantity { get; set; }

        /// <summary>
        /// Gets or Sets ActualReceiveDate
        /// </summary>
        [DataMember(Name="actualReceiveDate")]
        public DateTime? ActualReceiveDate { get; set; }

        /// <summary>
        /// Gets or Sets Comment
        /// </summary>
        [DataMember(Name="comment")]
        public string Comment { get; set; }

        /// <summary>
        /// Gets or Sets HvblComment
        /// </summary>
        [DataMember(Name="hvblComment")]
        public string HvblComment { get; set; }

        /// <summary>
        /// Gets or Sets ProductCode
        /// </summary>
        [DataMember(Name="productCode")]
        public string ProductCode { get; set; }

        /// <summary>
        /// Gets or Sets ActualReceiveQuantity
        /// </summary>
        [DataMember(Name="actualReceiveQuantity")]
        public double? ActualReceiveQuantity { get; set; }

        /// <summary>
        /// Gets or Sets ItemFeedbackName
        /// </summary>
        [DataMember(Name="itemFeedbackName")]
        public long? ItemFeedbackName { get; set; }

        /// <summary>
        /// Gets or Sets ParentOrderFeedbackReplyId
        /// </summary>
        [DataMember(Name="parentOrderFeedbackReplyId")]
        public long? ParentOrderFeedbackReplyId { get; set; }

        /// <summary>
        /// Gets or Sets CreatedBy
        /// </summary>
        [DataMember(Name="createdBy")]
        public long? CreatedBy { get; set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO {\n");
            sb.Append("  OrderFeedbackId: ").Append(OrderFeedbackId).Append("\n");
            sb.Append("  OrderId: ").Append(OrderId).Append("\n");
            sb.Append("  OrderProductId: ").Append(OrderProductId).Append("\n");
            sb.Append("  FeedbackId: ").Append(FeedbackId).Append("\n");
            sb.Append("  Field1: ").Append(Field1).Append("\n");
            sb.Append("  Field2: ").Append(Field2).Append("\n");
            sb.Append("  IsActive: ").Append(IsActive).Append("\n");
            sb.Append("  Attachment: ").Append(Attachment).Append("\n");
            sb.Append("  Quantity: ").Append(Quantity).Append("\n");
            sb.Append("  ActualReceiveDate: ").Append(ActualReceiveDate).Append("\n");
            sb.Append("  Comment: ").Append(Comment).Append("\n");
            sb.Append("  HvblComment: ").Append(HvblComment).Append("\n");
            sb.Append("  ProductCode: ").Append(ProductCode).Append("\n");
            sb.Append("  ActualReceiveQuantity: ").Append(ActualReceiveQuantity).Append("\n");
            sb.Append("  ItemFeedbackName: ").Append(ItemFeedbackName).Append("\n");
            sb.Append("  ParentOrderFeedbackReplyId: ").Append(ParentOrderFeedbackReplyId).Append("\n");
            sb.Append("  CreatedBy: ").Append(CreatedBy).Append("\n");
            sb.Append("}\n");
            return sb.ToString();
        }

        /// <summary>
        /// Returns the JSON string presentation of the object
        /// </summary>
        /// <returns>JSON string presentation of the object</returns>
        public string ToJson()
        {
            return JsonConvert.SerializeObject(this, Formatting.Indented);
        }

        /// <summary>
        /// Returns true if objects are equal
        /// </summary>
        /// <param name="obj">Object to be compared</param>
        /// <returns>Boolean</returns>
        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            return obj.GetType() == GetType() && Equals((GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO)obj);
        }

        /// <summary>
        /// Returns true if GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO instances are equal
        /// </summary>
        /// <param name="other">Instance of GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    OrderFeedbackId == other.OrderFeedbackId ||
                    OrderFeedbackId != null &&
                    OrderFeedbackId.Equals(other.OrderFeedbackId)
                ) && 
                (
                    OrderId == other.OrderId ||
                    OrderId != null &&
                    OrderId.Equals(other.OrderId)
                ) && 
                (
                    OrderProductId == other.OrderProductId ||
                    OrderProductId != null &&
                    OrderProductId.Equals(other.OrderProductId)
                ) && 
                (
                    FeedbackId == other.FeedbackId ||
                    FeedbackId != null &&
                    FeedbackId.Equals(other.FeedbackId)
                ) && 
                (
                    Field1 == other.Field1 ||
                    Field1 != null &&
                    Field1.Equals(other.Field1)
                ) && 
                (
                    Field2 == other.Field2 ||
                    Field2 != null &&
                    Field2.Equals(other.Field2)
                ) && 
                (
                    IsActive == other.IsActive ||
                    IsActive != null &&
                    IsActive.Equals(other.IsActive)
                ) && 
                (
                    Attachment == other.Attachment ||
                    Attachment != null &&
                    Attachment.Equals(other.Attachment)
                ) && 
                (
                    Quantity == other.Quantity ||
                    Quantity != null &&
                    Quantity.Equals(other.Quantity)
                ) && 
                (
                    ActualReceiveDate == other.ActualReceiveDate ||
                    ActualReceiveDate != null &&
                    ActualReceiveDate.Equals(other.ActualReceiveDate)
                ) && 
                (
                    Comment == other.Comment ||
                    Comment != null &&
                    Comment.Equals(other.Comment)
                ) && 
                (
                    HvblComment == other.HvblComment ||
                    HvblComment != null &&
                    HvblComment.Equals(other.HvblComment)
                ) && 
                (
                    ProductCode == other.ProductCode ||
                    ProductCode != null &&
                    ProductCode.Equals(other.ProductCode)
                ) && 
                (
                    ActualReceiveQuantity == other.ActualReceiveQuantity ||
                    ActualReceiveQuantity != null &&
                    ActualReceiveQuantity.Equals(other.ActualReceiveQuantity)
                ) && 
                (
                    ItemFeedbackName == other.ItemFeedbackName ||
                    ItemFeedbackName != null &&
                    ItemFeedbackName.Equals(other.ItemFeedbackName)
                ) && 
                (
                    ParentOrderFeedbackReplyId == other.ParentOrderFeedbackReplyId ||
                    ParentOrderFeedbackReplyId != null &&
                    ParentOrderFeedbackReplyId.Equals(other.ParentOrderFeedbackReplyId)
                ) && 
                (
                    CreatedBy == other.CreatedBy ||
                    CreatedBy != null &&
                    CreatedBy.Equals(other.CreatedBy)
                );
        }

        /// <summary>
        /// Gets the hash code
        /// </summary>
        /// <returns>Hash code</returns>
        public override int GetHashCode()
        {
            unchecked // Overflow is fine, just wrap
            {
                var hashCode = 41;
                // Suitable nullity checks etc, of course :)
                    if (OrderFeedbackId != null)
                    hashCode = hashCode * 59 + OrderFeedbackId.GetHashCode();
                    if (OrderId != null)
                    hashCode = hashCode * 59 + OrderId.GetHashCode();
                    if (OrderProductId != null)
                    hashCode = hashCode * 59 + OrderProductId.GetHashCode();
                    if (FeedbackId != null)
                    hashCode = hashCode * 59 + FeedbackId.GetHashCode();
                    if (Field1 != null)
                    hashCode = hashCode * 59 + Field1.GetHashCode();
                    if (Field2 != null)
                    hashCode = hashCode * 59 + Field2.GetHashCode();
                    if (IsActive != null)
                    hashCode = hashCode * 59 + IsActive.GetHashCode();
                    if (Attachment != null)
                    hashCode = hashCode * 59 + Attachment.GetHashCode();
                    if (Quantity != null)
                    hashCode = hashCode * 59 + Quantity.GetHashCode();
                    if (ActualReceiveDate != null)
                    hashCode = hashCode * 59 + ActualReceiveDate.GetHashCode();
                    if (Comment != null)
                    hashCode = hashCode * 59 + Comment.GetHashCode();
                    if (HvblComment != null)
                    hashCode = hashCode * 59 + HvblComment.GetHashCode();
                    if (ProductCode != null)
                    hashCode = hashCode * 59 + ProductCode.GetHashCode();
                    if (ActualReceiveQuantity != null)
                    hashCode = hashCode * 59 + ActualReceiveQuantity.GetHashCode();
                    if (ItemFeedbackName != null)
                    hashCode = hashCode * 59 + ItemFeedbackName.GetHashCode();
                    if (ParentOrderFeedbackReplyId != null)
                    hashCode = hashCode * 59 + ParentOrderFeedbackReplyId.GetHashCode();
                    if (CreatedBy != null)
                    hashCode = hashCode * 59 + CreatedBy.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO left, GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO left, GlassRUNServiceWebApiManageOrderDTOOrderFeedbackDTO right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}
