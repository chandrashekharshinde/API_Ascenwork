using APIController.Framework;
using glassRUN.Framework.Serializer;

using APIController.Framework.DTO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using APIController.Framework.DataAccess;

namespace APIController.Framework.Business
{

    public class LoginManager : ILoginManager
    {
        public bool ValidateData(LoginDTO loginDTO)
        {
            if (loginDTO.Username == "" && loginDTO.UserId == 0)
            {
                return false;
            }
            return true;
        }

        public List<LoginDTO> GetLoginDetailsById(LoginDTO loginDTO)
        {
            List<LoginDTO> getAprroved = new List<LoginDTO>();
            try
            {
                if (ValidateData(loginDTO))
                {
                    DataTable dt = new DataTable();
                    string a = ManageLoginDataAccessManager.GetLoginDetailsById<string>(loginDTO);
                    if (a != null)
                    {
                        a = JSONAndXMLSerializer.XMLtoJSON(a);
                        JObject servicesConfiguartionURL = (JObject)JsonConvert.DeserializeObject(a);
                        string accessKey = servicesConfiguartionURL["Login"]["LoginList"]["AccessKey"].ToString();
                        string isActive = servicesConfiguartionURL["Login"]["LoginList"]["IsActive"].ToString();
                        loginDTO.AccessKey = accessKey;
                        loginDTO.IsActive = isActive == "1" ? true : false;
                    }
                    getAprroved.Add(loginDTO);
                    return getAprroved;
                }
                else
                {
                    return getAprroved;
                }
            }
            catch (Exception ex)
            {
                return getAprroved;
            }
        }
    }
}
