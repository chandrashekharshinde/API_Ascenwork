using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using APIController.Framework;
using APIController.Framework.AppLogger;
using APIController.Framework.Controllers;
using glassRUNService.WebApi.ManageProduct.Business;
using glassRUNService.WebApi.ManageProduct.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace glassRUNService.WebApi.ManageProduct.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get
            {
                return EnumLoggerType.Product;
            }
        }
        /// <summary>
        /// Call the business logic for the implemtation of the save products
        /// </summary>
        /// <param name="saveProduct"></param>
        /// <returns></returns>

        [HttpPost]
        [Route("SaveProduct")]
        public IActionResult SaveProduct(ProductDTO saveProduct) // Error code: 5001
        {
            try
            {
               
                IProductManager objProductManager = new ProductManager();
                //LoggerInstance.Information("Save Product List", 5001);              
                List<ProductDTO> output = objProductManager.SaveProduct(saveProduct);                          
                return Ok(output);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 5001);
                return new CustomErrorActionResult(HttpStatusCode.InternalServerError, "Inernal Server Error");
            }
        }




    }
}
