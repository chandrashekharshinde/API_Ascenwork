using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{
    public class EnquirySearchParameterDTO
    {


        public EnquirySearchParameterDTO()
        {

        }

        public string fieldName { get; set; }
        public string operatorName { get; set; }
        public string fieldValue { get; set; }
        public long Priority { get; set; } = 0;
        public string PriorityValue { get; set; } = "";
        public string fieldType { get; set; }

    }
}
