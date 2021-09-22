using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using glassRUNService.WebAPI.ManageCustomer.DataAccess;

namespace glassRUNService.WebAPI.ManageCustomer.Business
{
    public class CustomerManager : ICustomerManager
    {
        public string GetAllSupplierDetailsB2BApp(dynamic Json)
        {

            string output = ManageCustomerDataAccessManager.GetAllSupplierDetailsB2BApp(Json);

            return output;
        }

        public string GetAllCustomerListB2BApp(dynamic Json)
        {

            string output = ManageCustomerDataAccessManager.GetAllCustomerListB2BApp(Json);

            return output;
        }

        public string GetCustomerDetailsBySupplier(dynamic Json)
        {

            string output = ManageCustomerDataAccessManager.GetCustomerDetailsBySupplier(Json);

            return output;
        }

        public string UpdateManageCusomerDetailsB2BApp(dynamic Json)
        {

            string output = ManageCustomerDataAccessManager.UpdateManageCusomerDetailsB2BApp(Json);

            return output;
        }

        public string SaveCustomerGroup(dynamic Json)
        {

            string output = ManageCustomerDataAccessManager.SaveCustomerGroup(Json);

            return output;
        }

        public CustomerManager()
        {

        }
    }
}
