/*
 * WebAPIBuild
 *
 * This is glassRUN web api library for 3rd party and internal reference
 *
 * OpenAPI spec version: 1.0
 * 
 * Generated by: https://github.com/swagger-api/swagger-codegen.git
 */
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using IO.Swagger.Models;

namespace IO.Swagger.Controllers
{ 
    /// <summary>
    /// 
    /// </summary>
    public interface IManageCustomerApiController
    { 
        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        IActionResult ManageCustomerGetAllCustomerListB2BAppPost([FromBody] body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        IActionResult ManageCustomerGetAllSupplierDetailsB2BAppPost([FromBody] body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        IActionResult ManageCustomerGetCustomerDetailsBySupplierPost([FromBody] body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        IActionResult ManageCustomerSaveCustomerGroupPost([FromBody] body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        IActionResult ManageCustomerUpadateManageCusomerDetailsB2BAppPost([FromBody] body);
    }
}
