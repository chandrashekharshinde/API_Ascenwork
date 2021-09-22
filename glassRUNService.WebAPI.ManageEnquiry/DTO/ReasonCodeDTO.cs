using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{
    public class ReasonCodeDTO
    {

        public long? ReasonCodeId { get; set; }

        public string ReasonDescription { get; set; }

        public long? ObjectId { get; set; }

        public string ObjectType { get; set; }

        public string EventName { get; set; }

        public bool? IsActive { get; set; }

        public long? CreatedBy { get; set; }

        public ReasonCodeDTO()
        {

        }
    }
}
