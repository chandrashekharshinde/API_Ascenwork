using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.DTO
{
    public class SettingDTO
    {
        public long SettingId { get; set; }
        public string SettingParameter { get; set; }
        public string Description { get; set; }
        public string SettingValue { get; set; }
        public long CompanyId { get; set; }
 
    }
}
