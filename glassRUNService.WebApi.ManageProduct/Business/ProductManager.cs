using APIController.Framework;
using glassRUNService.WebApi.ManageProduct.DTO;
using glassRUNService.WebApi.ManageProduct.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using glassRUN.Framework.Serializer;

namespace glassRUNService.WebApi.ManageProduct.Business
{
    public class ProductManager : IProductManager
    {
        /// <summary>
        /// Business logic for the Save Product and call data access layer
        /// </summary>
        /// <param name="saveProduct"></param>
        /// <returns></returns>
        public List<ProductDTO> SaveProduct(ProductDTO saveProduct)
        {
            // Call data access class to Save the product 
            DataTable dtSaveProduct = new DataTable();
            dtSaveProduct = ProductDataAccessManager.SaveProduct<DataTable>(saveProduct);
            List<ProductDTO> lstSaveProduct = Extension.DataTableToList<ProductDTO>(dtSaveProduct);
            return lstSaveProduct;

        }


    }
}
