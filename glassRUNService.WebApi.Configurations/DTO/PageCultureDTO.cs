using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.DTO
{
    public class PageCultureDTO
    {
     public long   CultureMasterId { get; set; }
        public string CultureName { get; set; }
        public string CultureCode { get; set; }
        public string Description { get; set; }
        public long CompanyId { get; set; }
    }
}
