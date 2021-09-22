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
    public interface IManageEnquiryApiController
    { 
        /// <summary>
        /// API used to approve Sales Enquiry.
        /// </summary>
        /// <remarks>To approve a Sales Enquiry by the Order Manager</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ApproveEnquiry([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquiryDTO body);

        /// <summary>
        /// API used to check if any RPM Mapped to the Sales Enquiry.
        /// </summary>
        /// <remarks>To check if there is any Returnable Packaging Material enquiry mapped with Sales Enquiry</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult CheckRPMMapped([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquiryDTO body);

        /// <summary>
        /// API used to create a Sales Enquiry.
        /// </summary>
        /// <remarks>To create a Sales Enquiry</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult Create([FromBody] body);

        /// <summary>
        /// API used to create Sales Enquiry with Workflow.
        /// </summary>
        /// <remarks>To create a Sales Enquiry using the defined workflow instance</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult CreateEnquiryWithWorkflow([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquiryDTO body);

        /// <summary>
        /// API used to create a Sales Enquiry List.
        /// </summary>
        /// <remarks>To create the list of current Sales Enquiries</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult EnquiryList([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchDTO body);

        /// <summary>
        /// API used to get Sales Enquiry List by Enquiry Number.
        /// </summary>
        /// <remarks>To search the Sales Enquiry List by Enquiry Number</remarks>
        /// <param name="enquiryNumber"></param>
        /// <param name="roleId"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult EnquiryListById([FromQuery]string enquiryNumber, [FromQuery]int? roleId);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult GetConsolidatedProducts([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOConsolidatedProductsSearchDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryAppRejCustEnquiryPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquiryDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryCancelInquiryPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryEditEnquiryWithWorkFlowPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquiryDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryEditPost([FromBody] body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryEnquiryApprovalPost([FromBody] body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryExportToExcelForEnquiryListDetailsPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryExportToExcelForEnquiryListPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquiryRPMDraftEnquiryListPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchDTO body);

        /// <summary>
        /// 
        /// </summary>
        
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult ManageEnquirySearchEnquiryListPost([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquirySearchDTO body);

        /// <summary>
        /// API used to reject a Sales Enquiry.
        /// </summary>
        /// <remarks>To reject a Sales Enquiry by the Order Manager</remarks>
        /// <param name="body"></param>
        /// <response code="200">Success</response>
        /// <response code="0">successful operation</response>
        IActionResult RejectEnquiry([FromBody]GlassRUNServiceWebAPIManageEnquiryDTOEnquiryDTO body);
    }
}
