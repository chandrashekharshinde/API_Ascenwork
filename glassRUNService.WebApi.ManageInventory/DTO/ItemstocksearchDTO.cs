using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DTO
{
    public class ItemstocksearchDTO
    {
		public string search { get; set; }
		public string Brand { get; set; }
		public string SortBy { get; set; }
		public int PageIndex { get; set; }
		public int PageSize { get; set; }
		public string Day { get; set; }
		public string FromDate { get; set; }
		public string ToDate { get; set; }
		public string TransationType { get; set; }


	}
}
