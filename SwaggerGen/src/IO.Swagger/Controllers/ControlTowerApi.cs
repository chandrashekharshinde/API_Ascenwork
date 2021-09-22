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
    public class ControlTowerApiController : ControllerBase, IControlTowerApiController
    { 
        /// <summary>
        /// 
        /// </summary>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/ControlTower/ControlTowerConfiguration")]
        [ValidateModelState]
        [SwaggerOperation("ControlTowerControlTowerConfigurationPost")]
        public virtual IActionResult ControlTowerControlTowerConfigurationPost([FromBody]GlassRUNServiceWebApiControlTowerDTOControlTowerSnapshotWorkflowStepRoleMappingDTO body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/ControlTower/ControlTowerGlobalCount")]
        [ValidateModelState]
        [SwaggerOperation("ControlTowerControlTowerGlobalCountPost")]
        public virtual IActionResult ControlTowerControlTowerGlobalCountPost([FromBody]GlassRUNServiceWebApiControlTowerDTOControlTowerSnapshotGlobalDTO body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/ControlTower/SellerDashboard")]
        [ValidateModelState]
        [SwaggerOperation("ControlTowerSellerDashboardPost")]
        public virtual IActionResult ControlTowerSellerDashboardPost([FromBody]GlassRUNServiceWebApiControlTowerDTOControlTowerSnapshotGlobalDTO body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }
    }
}
