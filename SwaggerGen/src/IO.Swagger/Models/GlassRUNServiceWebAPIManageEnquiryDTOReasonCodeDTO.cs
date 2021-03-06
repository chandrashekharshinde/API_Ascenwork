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
    public partial class GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO : IEquatable<GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO>
    { 
        /// <summary>
        /// Gets or Sets ReasonCodeId
        /// </summary>
        [DataMember(Name="reasonCodeId")]
        public long? ReasonCodeId { get; set; }

        /// <summary>
        /// Gets or Sets ReasonDescription
        /// </summary>
        [DataMember(Name="reasonDescription")]
        public string ReasonDescription { get; set; }

        /// <summary>
        /// Gets or Sets ObjectId
        /// </summary>
        [DataMember(Name="objectId")]
        public long? ObjectId { get; set; }

        /// <summary>
        /// Gets or Sets ObjectType
        /// </summary>
        [DataMember(Name="objectType")]
        public string ObjectType { get; set; }

        /// <summary>
        /// Gets or Sets EventName
        /// </summary>
        [DataMember(Name="eventName")]
        public string EventName { get; set; }

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
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO {\n");
            sb.Append("  ReasonCodeId: ").Append(ReasonCodeId).Append("\n");
            sb.Append("  ReasonDescription: ").Append(ReasonDescription).Append("\n");
            sb.Append("  ObjectId: ").Append(ObjectId).Append("\n");
            sb.Append("  ObjectType: ").Append(ObjectType).Append("\n");
            sb.Append("  EventName: ").Append(EventName).Append("\n");
            sb.Append("  IsActive: ").Append(IsActive).Append("\n");
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
            return obj.GetType() == GetType() && Equals((GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO)obj);
        }

        /// <summary>
        /// Returns true if GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO instances are equal
        /// </summary>
        /// <param name="other">Instance of GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    ReasonCodeId == other.ReasonCodeId ||
                    ReasonCodeId != null &&
                    ReasonCodeId.Equals(other.ReasonCodeId)
                ) && 
                (
                    ReasonDescription == other.ReasonDescription ||
                    ReasonDescription != null &&
                    ReasonDescription.Equals(other.ReasonDescription)
                ) && 
                (
                    ObjectId == other.ObjectId ||
                    ObjectId != null &&
                    ObjectId.Equals(other.ObjectId)
                ) && 
                (
                    ObjectType == other.ObjectType ||
                    ObjectType != null &&
                    ObjectType.Equals(other.ObjectType)
                ) && 
                (
                    EventName == other.EventName ||
                    EventName != null &&
                    EventName.Equals(other.EventName)
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
                    if (ReasonCodeId != null)
                    hashCode = hashCode * 59 + ReasonCodeId.GetHashCode();
                    if (ReasonDescription != null)
                    hashCode = hashCode * 59 + ReasonDescription.GetHashCode();
                    if (ObjectId != null)
                    hashCode = hashCode * 59 + ObjectId.GetHashCode();
                    if (ObjectType != null)
                    hashCode = hashCode * 59 + ObjectType.GetHashCode();
                    if (EventName != null)
                    hashCode = hashCode * 59 + EventName.GetHashCode();
                    if (IsActive != null)
                    hashCode = hashCode * 59 + IsActive.GetHashCode();
                    if (CreatedBy != null)
                    hashCode = hashCode * 59 + CreatedBy.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO left, GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO left, GlassRUNServiceWebAPIManageEnquiryDTOReasonCodeDTO right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}
