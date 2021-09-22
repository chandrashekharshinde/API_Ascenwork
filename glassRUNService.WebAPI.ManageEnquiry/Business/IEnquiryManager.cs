using glassRUNService.WebAPI.ManageEnquiry.DTO;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.ManageEnquiry.Business
{

    public interface IEnquiryManager
    {
        EnquiryDTO Save(EnquiryDTO enquiryDto);
        JObject SaveGratisOrder(dynamic Json);

    }
}
