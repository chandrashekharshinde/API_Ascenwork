using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.ManageCustomer.Business
{
    public interface ICustomerManager
    {
        string GetAllSupplierDetailsB2BApp(dynamic Json);

        string GetAllCustomerListB2BApp(dynamic Json);

        string GetCustomerDetailsBySupplier(dynamic Json);

        string UpdateManageCusomerDetailsB2BApp(dynamic Json);

        string SaveCustomerGroup(dynamic Json);
    }
}
