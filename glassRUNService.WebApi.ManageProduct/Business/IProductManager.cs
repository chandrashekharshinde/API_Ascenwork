using glassRUNService.WebApi.ManageProduct.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageProduct.Business
{
    public interface IProductManager
    {
        List<ProductDTO> SaveProduct(ProductDTO saveProduct);
    }
}
