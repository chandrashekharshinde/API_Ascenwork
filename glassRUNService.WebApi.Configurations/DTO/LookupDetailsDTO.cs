using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.DTO
{
    public class LookupDetailsDTO
    {
        public long LookUpId { get; set; }
 public string Name{ get; set; }
 public string  Code{ get; set; }
 public string  Description{ get; set; }
  public long ParentId{ get; set; }
 public long  CompanyId{ get; set; }
    }
}
