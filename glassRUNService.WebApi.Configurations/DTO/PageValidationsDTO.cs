using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.DTO
{
    public class PageValidationsDTO
    {
        public long ? PageID { get; set; }
        public string    PageName { get; set; }
        public string PageURL { get; set; }
        public long? RoleId { get; set; }
        public long? LoginId { get; set; }
        public string SettingName { get; set; }
        public string SettingValue { get; set; }

        public string DisplayName { get; set; }

        public string ValidationExpression { get; set; }

    }
}
