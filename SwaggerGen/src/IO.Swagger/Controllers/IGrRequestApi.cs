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
    public interface IGrRequestApiController
    { 
        /// <summary>
        /// (Need developer help).
        /// </summary>
        /// <remarks>(Need developer help).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ProcessRequest([FromBody]GlassRUNServiceWebApiProcessRequestControllersRequestData body);
    }
}