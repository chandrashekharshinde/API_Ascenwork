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
    public interface IRouteApiController
    { 
        /// <summary>
        /// API to retrieve route information.
        /// </summary>
        /// <remarks>This API is used by gRUN to retreive route information. (Developer to reconfirm).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        IActionResult RouteInformation([FromBody]GlassRUNServiceWebApiManagerouteDTORouteDTO body);
    }
}