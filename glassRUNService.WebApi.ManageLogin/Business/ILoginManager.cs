using glassRUNService.WebApi.ManageLogin.DTO;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageLogin.Business
{
    public interface ILoginManager
    {

        string GetB2BLogin(string json);

        string UpdateToken(long userId, string tokenString);

    }
}
