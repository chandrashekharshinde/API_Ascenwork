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
using Swashbuckle.AspNetCore.Annotations;
using Swashbuckle.AspNetCore.SwaggerGen;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using IO.Swagger.Attributes;

using Microsoft.AspNetCore.Authorization;
using IO.Swagger.Models;

namespace IO.Swagger.Controllers
{ 
    /// <summary>
    /// 
    /// </summary>
    [ApiController]
    public class RouteApiController : ControllerBase, IRouteApiController
    { 
        /// <summary>
        /// API to retrieve route information.
        /// </summary>
        /// <remarks>This API is used by gRUN to retreive route information. (Developer to reconfirm).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/Route/RouteInformation")]
        [ValidateModelState]
        [SwaggerOperation("RouteInformation")]
        public virtual IActionResult RouteInformation([FromBody]GlassRUNServiceWebApiManagerouteDTORouteDTO body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }
    }
}
