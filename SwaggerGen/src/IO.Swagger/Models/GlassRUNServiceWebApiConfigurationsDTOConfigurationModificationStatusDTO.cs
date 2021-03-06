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
    public partial class GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO : IEquatable<GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO>
    { 
        /// <summary>
        /// Gets or Sets ConfigurationModificationStatusId
        /// </summary>
        [DataMember(Name="configurationModificationStatusId")]
        public long? ConfigurationModificationStatusId { get; set; }

        /// <summary>
        /// Gets or Sets ConfigurationCode
        /// </summary>
        [DataMember(Name="configurationCode")]
        public string ConfigurationCode { get; set; }

        /// <summary>
        /// Gets or Sets ApiName
        /// </summary>
        [DataMember(Name="apiName")]
        public string ApiName { get; set; }

        /// <summary>
        /// Gets or Sets ApiUrl
        /// </summary>
        [DataMember(Name="apiUrl")]
        public string ApiUrl { get; set; }

        /// <summary>
        /// Gets or Sets CreatedDate
        /// </summary>
        [DataMember(Name="createdDate")]
        public DateTime? CreatedDate { get; set; }

        /// <summary>
        /// Gets or Sets CreatedBy
        /// </summary>
        [DataMember(Name="createdBy")]
        public long? CreatedBy { get; set; }

        /// <summary>
        /// Gets or Sets ModifiedDate
        /// </summary>
        [DataMember(Name="modifiedDate")]
        public DateTime? ModifiedDate { get; set; }

        /// <summary>
        /// Gets or Sets ModifiedBy
        /// </summary>
        [DataMember(Name="modifiedBy")]
        public long? ModifiedBy { get; set; }

        /// <summary>
        /// Gets or Sets AppType
        /// </summary>
        [DataMember(Name="appType")]
        public long? AppType { get; set; }

        /// <summary>
        /// Gets or Sets IsApiRequired
        /// </summary>
        [DataMember(Name="isApiRequired")]
        public bool? IsApiRequired { get; set; }

        /// <summary>
        /// Gets or Sets ConfigurationModificationStatusList
        /// </summary>
        [DataMember(Name="configurationModificationStatusList")]
        public Collection<GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO> ConfigurationModificationStatusList { get; set; }

        /// <summary>
        /// Returns the string presentation of the object
        /// </summary>
        /// <returns>String presentation of the object</returns>
        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.Append("class GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO {\n");
            sb.Append("  ConfigurationModificationStatusId: ").Append(ConfigurationModificationStatusId).Append("\n");
            sb.Append("  ConfigurationCode: ").Append(ConfigurationCode).Append("\n");
            sb.Append("  ApiName: ").Append(ApiName).Append("\n");
            sb.Append("  ApiUrl: ").Append(ApiUrl).Append("\n");
            sb.Append("  CreatedDate: ").Append(CreatedDate).Append("\n");
            sb.Append("  CreatedBy: ").Append(CreatedBy).Append("\n");
            sb.Append("  ModifiedDate: ").Append(ModifiedDate).Append("\n");
            sb.Append("  ModifiedBy: ").Append(ModifiedBy).Append("\n");
            sb.Append("  AppType: ").Append(AppType).Append("\n");
            sb.Append("  IsApiRequired: ").Append(IsApiRequired).Append("\n");
            sb.Append("  ConfigurationModificationStatusList: ").Append(ConfigurationModificationStatusList).Append("\n");
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
            return obj.GetType() == GetType() && Equals((GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO)obj);
        }

        /// <summary>
        /// Returns true if GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO instances are equal
        /// </summary>
        /// <param name="other">Instance of GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO to be compared</param>
        /// <returns>Boolean</returns>
        public bool Equals(GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO other)
        {
            if (ReferenceEquals(null, other)) return false;
            if (ReferenceEquals(this, other)) return true;

            return 
                (
                    ConfigurationModificationStatusId == other.ConfigurationModificationStatusId ||
                    ConfigurationModificationStatusId != null &&
                    ConfigurationModificationStatusId.Equals(other.ConfigurationModificationStatusId)
                ) && 
                (
                    ConfigurationCode == other.ConfigurationCode ||
                    ConfigurationCode != null &&
                    ConfigurationCode.Equals(other.ConfigurationCode)
                ) && 
                (
                    ApiName == other.ApiName ||
                    ApiName != null &&
                    ApiName.Equals(other.ApiName)
                ) && 
                (
                    ApiUrl == other.ApiUrl ||
                    ApiUrl != null &&
                    ApiUrl.Equals(other.ApiUrl)
                ) && 
                (
                    CreatedDate == other.CreatedDate ||
                    CreatedDate != null &&
                    CreatedDate.Equals(other.CreatedDate)
                ) && 
                (
                    CreatedBy == other.CreatedBy ||
                    CreatedBy != null &&
                    CreatedBy.Equals(other.CreatedBy)
                ) && 
                (
                    ModifiedDate == other.ModifiedDate ||
                    ModifiedDate != null &&
                    ModifiedDate.Equals(other.ModifiedDate)
                ) && 
                (
                    ModifiedBy == other.ModifiedBy ||
                    ModifiedBy != null &&
                    ModifiedBy.Equals(other.ModifiedBy)
                ) && 
                (
                    AppType == other.AppType ||
                    AppType != null &&
                    AppType.Equals(other.AppType)
                ) && 
                (
                    IsApiRequired == other.IsApiRequired ||
                    IsApiRequired != null &&
                    IsApiRequired.Equals(other.IsApiRequired)
                ) && 
                (
                    ConfigurationModificationStatusList == other.ConfigurationModificationStatusList ||
                    ConfigurationModificationStatusList != null &&
                    ConfigurationModificationStatusList.SequenceEqual(other.ConfigurationModificationStatusList)
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
                    if (ConfigurationModificationStatusId != null)
                    hashCode = hashCode * 59 + ConfigurationModificationStatusId.GetHashCode();
                    if (ConfigurationCode != null)
                    hashCode = hashCode * 59 + ConfigurationCode.GetHashCode();
                    if (ApiName != null)
                    hashCode = hashCode * 59 + ApiName.GetHashCode();
                    if (ApiUrl != null)
                    hashCode = hashCode * 59 + ApiUrl.GetHashCode();
                    if (CreatedDate != null)
                    hashCode = hashCode * 59 + CreatedDate.GetHashCode();
                    if (CreatedBy != null)
                    hashCode = hashCode * 59 + CreatedBy.GetHashCode();
                    if (ModifiedDate != null)
                    hashCode = hashCode * 59 + ModifiedDate.GetHashCode();
                    if (ModifiedBy != null)
                    hashCode = hashCode * 59 + ModifiedBy.GetHashCode();
                    if (AppType != null)
                    hashCode = hashCode * 59 + AppType.GetHashCode();
                    if (IsApiRequired != null)
                    hashCode = hashCode * 59 + IsApiRequired.GetHashCode();
                    if (ConfigurationModificationStatusList != null)
                    hashCode = hashCode * 59 + ConfigurationModificationStatusList.GetHashCode();
                return hashCode;
            }
        }

        #region Operators
        #pragma warning disable 1591

        public static bool operator ==(GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO left, GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO left, GlassRUNServiceWebApiConfigurationsDTOConfigurationModificationStatusDTO right)
        {
            return !Equals(left, right);
        }

        #pragma warning restore 1591
        #endregion Operators
    }
}
