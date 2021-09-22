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
    public partial class GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO : IEquatable<GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO>
    { 
        /// <summary>
        /// Gets or Sets OrderId
        /// </summary>
        [DataMember(Name="orderId")]
        public long? OrderId { get; set; }

        /// <summary>
        /// Gets or Sets OrderProductMovementId
        /// </summary>
        [DataMember(Name="orderProductMovementId")]
        public long? OrderProductMovementId { get; set; }

        /// <summary>
        /// Gets or Sets OrderProductId
        /// </summary>
        [DataMember(Name="orderProductId")]
        public long? OrderProductId { get; set; }

        /// <summary>
        /// Gets or Sets LineNumber
        /// </summary>
        [DataMember(Name="lineNumber")]
        public long? LineNumber { get; set; }

        /// <summary>
        /// Gets or Sets OrderMovementId
        /// </summary>
        [DataMember(Name="orderMovementId")]
        public long? OrderMovementId { get; set; }

        /// <summary>
        /// Gets or Sets PlannedQuantity
        /// </summary>
        [DataMember(Name="plannedQuantity")]
        public double? PlannedQuantity { get; set; }

        /// <summary>
        /// Gets or Sets ActualQuantity
        /// </summary>
        [DataMember(Name="actualQuantity")]
        public double? ActualQuantity { get; set; }

        /// <summary>
        /// Gets or Sets DeliveryStartTime
        /// </summary>
        [DataMember(Name="deliveryStartTime")]
        public DateTime? DeliveryStartTime { get; set; }

        /// <summary>
        /// Gets or Sets DeliveryEndTime
        /// </summary>
        [DataMember(Name="deliveryEndTime")]
        public DateTime? DeliveryEndTime { get; set; }

        /// <summary>
        /// Gets or Sets IsPumped
        /// </summary>
        [DataMember(Name="isPumped")]
        public bool? IsPumped { get; set; }

        /// <summary>
        /// Gets or Sets IsDeliveredAll
        /// </summary>
        [DataMember(Name="isDeliveredAll")]
        public bool? IsDeliveredAll { get; set; }

        /// <summary>
        /// Gets or Sets IsActive
        /// </summary>
        [DataMember(Name="isActive")]
        public bool? IsActive { get; set; }

        /// <summary>
        /// Gets or Sets CreatedBy
        /// </summary>
        [DataMember(Name="createdBy")]
        public long? CreatedBy { get; set; }

        /// <summary>
        /// Gets or Sets CreatedDate
        /// </summary>
        [DataMember(Name="createdDate")]
        public DateTime? CreatedDate { get; set; }

        /// <summary>
        /// Gets or Sets UpdateBy
        /// </summary>
        [DataMember(Name="updateBy")]
        public long? UpdateBy { get; set; }

        /// <summary>
        /// Gets or Sets UpdatedDate
        /// </summary>
        [DataMember(Name="updatedDate")]
        public DateTime? UpdatedDate { get; set; }

        /// <summary>
        /// Gets or Sets OrderProductMovementGuid
        /// </summary>
        [DataMember(Name="orderProductMovementGuid")]
        public string OrderProductMovementGuid { get; set; }

        /// <summary>
        /// Gets or Sets OrderProductGuid
        /// </summary>
        [DataMember(Name="orderProductGuid")]
        public string OrderProductGuid { get; set; }

        /// <summary>
        /// Gets or Sets OmLotNumber
        /// </summary>
        [DataMember(Name="omLotNumber")]
        public string OmLotNumber { get; set; }

        /// <summary>
        /// Gets or Sets OrderProductMovementList
        /// </summary>
        [DataMember(Name="orderProductMovementList")]
        public Collection<GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO> OrderProductMovementList { get; set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO {\n");
            sb.Append("  OrderId: ").Append(OrderId).Append("\n");
            sb.Append("  OrderProductMovementId: ").Append(OrderProductMovementId).Append("\n");
            sb.Append("  OrderProductId: ").Append(OrderProductId).Append("\n");
            sb.Append("  LineNumber: ").Append(LineNumber).Append("\n");
            sb.Append("  OrderMovementId: ").Append(OrderMovementId).Append("\n");
            sb.Append("  PlannedQuantity: ").Append(PlannedQuantity).Append("\n");
            sb.Append("  ActualQuantity: ").Append(ActualQuantity).Append("\n");
            sb.Append("  DeliveryStartTime: ").Append(DeliveryStartTime).Append("\n");
            sb.Append("  DeliveryEndTime: ").Append(DeliveryEndTime).Append("\n");
            sb.Append("  IsPumped: ").Append(IsPumped).Append("\n");
            sb.Append("  IsDeliveredAll: ").Append(IsDeliveredAll).Append("\n");
            sb.Append("  IsActive: ").Append(IsActive).Append("\n");
            sb.Append("  CreatedBy: ").Append(CreatedBy).Append("\n");
            sb.Append("  CreatedDate: ").Append(CreatedDate).Append("\n");
            sb.Append("  UpdateBy: ").Append(UpdateBy).Append("\n");
            sb.Append("  UpdatedDate: ").Append(UpdatedDate).Append("\n");
            sb.Append("  OrderProductMovementGuid: ").Append(OrderProductMovementGuid).Append("\n");
            sb.Append("  OrderProductGuid: ").Append(OrderProductGuid).Append("\n");
            sb.Append("  OmLotNumber: ").Append(OmLotNumber).Append("\n");
            sb.Append("  OrderProductMovementList: ").Append(OrderProductMovementList).Append("\n");
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
            return obj.GetType() == GetType() && Equals((GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO)obj);
        }

        /// <summary>
        /// Returns true if GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO instances are equal
        /// </summary>
        /// <param name="other">Instance of GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    OrderId == other.OrderId ||
                    OrderId != null &&
                    OrderId.Equals(other.OrderId)
                ) && 
                (
                    OrderProductMovementId == other.OrderProductMovementId ||
                    OrderProductMovementId != null &&
                    OrderProductMovementId.Equals(other.OrderProductMovementId)
                ) && 
                (
                    OrderProductId == other.OrderProductId ||
                    OrderProductId != null &&
                    OrderProductId.Equals(other.OrderProductId)
                ) && 
                (
                    LineNumber == other.LineNumber ||
                    LineNumber != null &&
                    LineNumber.Equals(other.LineNumber)
                ) && 
                (
                    OrderMovementId == other.OrderMovementId ||
                    OrderMovementId != null &&
                    OrderMovementId.Equals(other.OrderMovementId)
                ) && 
                (
                    PlannedQuantity == other.PlannedQuantity ||
                    PlannedQuantity != null &&
                    PlannedQuantity.Equals(other.PlannedQuantity)
                ) && 
                (
                    ActualQuantity == other.ActualQuantity ||
                    ActualQuantity != null &&
                    ActualQuantity.Equals(other.ActualQuantity)
                ) && 
                (
                    DeliveryStartTime == other.DeliveryStartTime ||
                    DeliveryStartTime != null &&
                    DeliveryStartTime.Equals(other.DeliveryStartTime)
                ) && 
                (
                    DeliveryEndTime == other.DeliveryEndTime ||
                    DeliveryEndTime != null &&
                    DeliveryEndTime.Equals(other.DeliveryEndTime)
                ) && 
                (
                    IsPumped == other.IsPumped ||
                    IsPumped != null &&
                    IsPumped.Equals(other.IsPumped)
                ) && 
                (
                    IsDeliveredAll == other.IsDeliveredAll ||
                    IsDeliveredAll != null &&
                    IsDeliveredAll.Equals(other.IsDeliveredAll)
                ) && 
                (
                    IsActive == other.IsActive ||
                    IsActive != null &&
                    IsActive.Equals(other.IsActive)
                ) && 
                (
                    CreatedBy == other.CreatedBy ||
                    CreatedBy != null &&
                    CreatedBy.Equals(other.CreatedBy)
                ) && 
                (
                    CreatedDate == other.CreatedDate ||
                    CreatedDate != null &&
                    CreatedDate.Equals(other.CreatedDate)
                ) && 
                (
                    UpdateBy == other.UpdateBy ||
                    UpdateBy != null &&
                    UpdateBy.Equals(other.UpdateBy)
                ) && 
                (
                    UpdatedDate == other.UpdatedDate ||
                    UpdatedDate != null &&
                    UpdatedDate.Equals(other.UpdatedDate)
                ) && 
                (
                    OrderProductMovementGuid == other.OrderProductMovementGuid ||
                    OrderProductMovementGuid != null &&
                    OrderProductMovementGuid.Equals(other.OrderProductMovementGuid)
                ) && 
                (
                    OrderProductGuid == other.OrderProductGuid ||
                    OrderProductGuid != null &&
                    OrderProductGuid.Equals(other.OrderProductGuid)
                ) && 
                (
                    OmLotNumber == other.OmLotNumber ||
                    OmLotNumber != null &&
                    OmLotNumber.Equals(other.OmLotNumber)
                ) && 
                (
                    OrderProductMovementList == other.OrderProductMovementList ||
                    OrderProductMovementList != null &&
                    OrderProductMovementList.SequenceEqual(other.OrderProductMovementList)
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
                    if (OrderId != null)
                    hashCode = hashCode * 59 + OrderId.GetHashCode();
                    if (OrderProductMovementId != null)
                    hashCode = hashCode * 59 + OrderProductMovementId.GetHashCode();
                    if (OrderProductId != null)
                    hashCode = hashCode * 59 + OrderProductId.GetHashCode();
                    if (LineNumber != null)
                    hashCode = hashCode * 59 + LineNumber.GetHashCode();
                    if (OrderMovementId != null)
                    hashCode = hashCode * 59 + OrderMovementId.GetHashCode();
                    if (PlannedQuantity != null)
                    hashCode = hashCode * 59 + PlannedQuantity.GetHashCode();
                    if (ActualQuantity != null)
                    hashCode = hashCode * 59 + ActualQuantity.GetHashCode();
                    if (DeliveryStartTime != null)
                    hashCode = hashCode * 59 + DeliveryStartTime.GetHashCode();
                    if (DeliveryEndTime != null)
                    hashCode = hashCode * 59 + DeliveryEndTime.GetHashCode();
                    if (IsPumped != null)
                    hashCode = hashCode * 59 + IsPumped.GetHashCode();
                    if (IsDeliveredAll != null)
                    hashCode = hashCode * 59 + IsDeliveredAll.GetHashCode();
                    if (IsActive != null)
                    hashCode = hashCode * 59 + IsActive.GetHashCode();
                    if (CreatedBy != null)
                    hashCode = hashCode * 59 + CreatedBy.GetHashCode();
                    if (CreatedDate != null)
                    hashCode = hashCode * 59 + CreatedDate.GetHashCode();
                    if (UpdateBy != null)
                    hashCode = hashCode * 59 + UpdateBy.GetHashCode();
                    if (UpdatedDate != null)
                    hashCode = hashCode * 59 + UpdatedDate.GetHashCode();
                    if (OrderProductMovementGuid != null)
                    hashCode = hashCode * 59 + OrderProductMovementGuid.GetHashCode();
                    if (OrderProductGuid != null)
                    hashCode = hashCode * 59 + OrderProductGuid.GetHashCode();
                    if (OmLotNumber != null)
                    hashCode = hashCode * 59 + OmLotNumber.GetHashCode();
                    if (OrderProductMovementList != null)
                    hashCode = hashCode * 59 + OrderProductMovementList.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO left, GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO left, GlassRUNServiceWebApiManageOrderDTOOrderProductMovementDTO right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}
