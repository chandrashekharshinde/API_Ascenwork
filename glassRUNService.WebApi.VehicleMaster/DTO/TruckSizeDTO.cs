using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.VehicleMaster.DTO
{
    public class TruckSizeDTO
    {
		//[TruckSizeId] [bigint] IDENTITY(1,1) NOT NULL,
	public long VehicleType { get; set; }
	public string TruckSize { get; set; }
	public decimal TruckCapacityPalettes { get; set; }
	public decimal TruckCapacityWeight { get; set; }
	public bool IsActive { get; set; }
	public decimal Height { get; set; }
	public decimal Width { get; set; }
	public decimal Length { get; set; }
	public long CreatedBy { get; set; }
	public DateTime CreatedDate { get; set; }
	public long UpdatedBy { get; set; }
	public DateTime UpdatedDate { get; set; }
    }
}
