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
    public partial class GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO : IEquatable<GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO>
    { 
        /// <summary>
        /// Gets or Sets FieldName
        /// </summary>
        [DataMember(Name="fieldName")]
        public string FieldName { get; set; }

        /// <summary>
        /// Gets or Sets OperatorName
        /// </summary>
        [DataMember(Name="operatorName")]
        public string OperatorName { get; set; }

        /// <summary>
        /// Gets or Sets FieldValue
        /// </summary>
        [DataMember(Name="fieldValue")]
        public string FieldValue { get; set; }

        /// <summary>
        /// Gets or Sets Priority
        /// </summary>
        [DataMember(Name="priority")]
        public long? Priority { get; set; }

        /// <summary>
        /// Gets or Sets PriorityValue
        /// </summary>
        [DataMember(Name="priorityValue")]
        public string PriorityValue { get; set; }

        /// <summary>
        /// Gets or Sets FieldType
        /// </summary>
        [DataMember(Name="fieldType")]
        public string FieldType { get; set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO {\n");
            sb.Append("  FieldName: ").Append(FieldName).Append("\n");
            sb.Append("  OperatorName: ").Append(OperatorName).Append("\n");
            sb.Append("  FieldValue: ").Append(FieldValue).Append("\n");
            sb.Append("  Priority: ").Append(Priority).Append("\n");
            sb.Append("  PriorityValue: ").Append(PriorityValue).Append("\n");
            sb.Append("  FieldType: ").Append(FieldType).Append("\n");
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
            return obj.GetType() == GetType() && Equals((GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO)obj);
        }

        /// <summary>
        /// Returns true if GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO instances are equal
        /// </summary>
        /// <param name="other">Instance of GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    FieldName == other.FieldName ||
                    FieldName != null &&
                    FieldName.Equals(other.FieldName)
                ) && 
                (
                    OperatorName == other.OperatorName ||
                    OperatorName != null &&
                    OperatorName.Equals(other.OperatorName)
                ) && 
                (
                    FieldValue == other.FieldValue ||
                    FieldValue != null &&
                    FieldValue.Equals(other.FieldValue)
                ) && 
                (
                    Priority == other.Priority ||
                    Priority != null &&
                    Priority.Equals(other.Priority)
                ) && 
                (
                    PriorityValue == other.PriorityValue ||
                    PriorityValue != null &&
                    PriorityValue.Equals(other.PriorityValue)
                ) && 
                (
                    FieldType == other.FieldType ||
                    FieldType != null &&
                    FieldType.Equals(other.FieldType)
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
                    if (FieldName != null)
                    hashCode = hashCode * 59 + FieldName.GetHashCode();
                    if (OperatorName != null)
                    hashCode = hashCode * 59 + OperatorName.GetHashCode();
                    if (FieldValue != null)
                    hashCode = hashCode * 59 + FieldValue.GetHashCode();
                    if (Priority != null)
                    hashCode = hashCode * 59 + Priority.GetHashCode();
                    if (PriorityValue != null)
                    hashCode = hashCode * 59 + PriorityValue.GetHashCode();
                    if (FieldType != null)
                    hashCode = hashCode * 59 + FieldType.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO left, GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO left, GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchParameterDTO right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}
