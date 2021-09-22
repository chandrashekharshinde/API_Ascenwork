using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebApi.Configurations.DTO
{
    [Serializable]
    [XmlRoot(ElementName = "AppLatestVersion", IsNullable = false)]
    public class AppLatestVersionDTO
    {
        public string AppLatestVersionNo { get; set; }
        public string AppLatestBuildNo { get; set; }
        public string AppLatestDownloadLinkForAndroid { get; set; }
        public string AppLatestDownloadLinkForIOS { get; set; }
        public string AppLatestDownloadLinkForWindows { get; set; }
        public bool AppLatestVersionMandatory { get; set; }

        public string AppLatestVersionIsMandatory { get; set; }
        public long AppType { get; set; }

        public string IsAppNeedToUpdate { get; set; }

        [XmlElement(ElementName = "AppLatestVersionList")]
        public List<AppLatestVersionDTO> AppLatestVersionList { get; set; }

        public AppLatestVersionDTO()
        {
            AppLatestVersionList = new List<AppLatestVersionDTO>();
        }

    }
}
