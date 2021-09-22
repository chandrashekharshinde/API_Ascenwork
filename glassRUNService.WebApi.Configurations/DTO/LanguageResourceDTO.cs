using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.DTO
{
    public class LanguageResourceDTO
    {
         public long ResourceId  { get; set; }
         public long CultureId { get; set; }
         public string PageName { get; set; }
         public string ResourceType { get; set; }
         public string ResourceKey { get; set; }
         public string ResourceValue { get; set; }
         public bool? IsAPP { get; set; }
         public string VersionNo { get; set; }
}
}
