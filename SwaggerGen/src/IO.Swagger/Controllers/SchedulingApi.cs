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
    public class SchedulingApiController : ControllerBase, ISchedulingApiController
    { 
        /// <summary>
        /// API for Order scheduling by Transporter.
        /// </summary>
        /// <remarks>This API is used by gRUN for Order scheduling done by Transporter. (Developer to reconfirm).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/Scheduling/OrderScheduling")]
        [ValidateModelState]
        [SwaggerOperation("OrderScheduling")]
        public virtual IActionResult OrderScheduling([FromBody]GlassRUNServiceWebApiManageOrderDTOOrderSchedulingDTO body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }

        /// <summary>
        /// API for Order scheduling flow.
        /// </summary>
        /// <remarks>This API is used by gRUN for Order scheduling flow. (Developer to reconfirm).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/Scheduling/OrderSchedulingFromFlow")]
        [ValidateModelState]
        [SwaggerOperation("OrderSchedulingFlow")]
        public virtual IActionResult OrderSchedulingFlow([FromBody] body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }

        /// <summary>
        /// API for auto update of Order sequencing during scheduling.
        /// </summary>
        /// <remarks>This API is used by gRUN for auto order sequencing during scheduling. (Developer to reconfirm).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/Scheduling/AutomaticOrderScheduling")]
        [ValidateModelState]
        [SwaggerOperation("UpdateSequenceAuto")]
        public virtual IActionResult UpdateSequenceAuto([FromBody] body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }

        /// <summary>
        /// API for Manual updating of Order sequencing by transporter.
        /// </summary>
        /// <remarks>This API is used by gRUN for manual order sequencing done by transporter. (Developer to reconfirm).</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        [HttpPost]
        [Route("/Scheduling/UpdateSequence")]
        [ValidateModelState]
        [SwaggerOperation("UpdateSequenceManual")]
        public virtual IActionResult UpdateSequenceManual([FromBody]GlassRUNServiceWebApiManageOrderDTOOrderSchedulingDTO body)
        { 
            //TODO: Uncomment the next line to return response 200 or use other options such as return this.NotFound(), return this.BadRequest(..), ...
            // return StatusCode(200);

            throw new NotImplementedException();
        }
    }
}
