using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.DTO
{
    public class PageControlDTO
    {
        public long SortingParametersId  { get; set; }
        public string ControlName  { get; set; }
        public string ResourceKey  { get; set; }
        public long AccessId  { get; set; } 
        public string DataSource  { get; set; }
        public long RoleId  { get; set; } 
        public long LoginId  { get; set; } 
        public string PageName  { get; set; }
        public string PageURL  { get; set; }
        public bool? IsMandatory  { get; set; }
        public string ValidationExpression  { get; set; }
        public long ControlType  { get; set; }
        
    }
}
