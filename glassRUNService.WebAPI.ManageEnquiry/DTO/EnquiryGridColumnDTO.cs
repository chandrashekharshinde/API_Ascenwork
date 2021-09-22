using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.ManageEnquiry.DTO
{

    public class EnquiryGridColumnDTO
    {

        public EnquiryGridColumnDTO()
        {

        }
        public string PropertyName { get; set; }
        public string ResourceValue { get; set; }
        public string SequenceNumber { get; set; }

        public string IsMandatory { get; set; }
    }


}
