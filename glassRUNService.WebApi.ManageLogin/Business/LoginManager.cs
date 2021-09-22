using APIController.Framework;
using APIController.Framework.AppLogger;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.ManageLogin.DataAccess;
using glassRUNService.WebApi.ManageLogin.DTO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageLogin.Business
{
    public class LoginManager : ILoginManager
    {
        BaseAppLogger _loggerInstance;
        public LoginManager(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }

        public string GetB2BLogin(string Input)
        {
            string output = ManageLoginDataAccessManager.GetB2BLogin(Input);
            return output;
        }

        public string UpdateToken(long userId, string tokenString)
        {
            string output = ManageLoginDataAccessManager.UpdateToken(userId, tokenString);
            return output;
        }



    }
}
