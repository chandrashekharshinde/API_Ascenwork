using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using APIController.Framework.AppLogger;
using APIController.Framework.Controllers;
using APIController.Framework;
using glassRUNService.WebApi.ManageLogin.Business;
using glassRUNService.WebApi.ManageLogin.DTO;
using System.Net;
using Newtonsoft.Json;
using glassRUN.Framework.PasswordUtility;
using Newtonsoft.Json.Linq;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Dynamic;
using System.Net.Http;
using System.Net.Http.Headers;
using glassRUN.Framework.DataAccess;
using Newtonsoft.Json.Converters;
using glassRUN.Framework;
using glassRUNProduct.DataAccess.Common;
using System.IO;

namespace glassRUNService.WebApi.ManageLogin.Controllers
{
    public class ManageLoginController : BaseAPIController
    {
        protected override EnumLoggerType LoggerName
        {
            get { return EnumLoggerType.Login; }
        }

        //[GRAuthorize]

        [HttpPost]
        [Route("/api/[controller]/ValidateB2BLogin")]
        public IActionResult ValidateB2BLogin([FromBody] dynamic Json)
        {
            string Input = JsonConvert.SerializeObject(Json);
            JObject returnObject = new JObject();
            LoggerInstance.Information(Input, 5002);
            try
            {
                ILoginManager loginManager = new LoginManager(LoggerInstance);

                string output = loginManager.GetB2BLogin(Input);

                JObject obj = (JObject)JsonConvert.DeserializeObject(output);
                var UsersList = obj["Users"]["UsersList"].ToList();
                LoggerInstance.Information(UsersList.ToString(), 5002);
                if (UsersList != null && UsersList.Count > 0)
                {
                    foreach (var usersDto in UsersList)
                    {
                        var userPassword = Json["Json"]["userPassword"].ToString();
                        var PasswordSalt = int.Parse(Convert.ToString(usersDto["PasswordSalt"]));
                        string hasehedPassword = Password.HashPassword(userPassword, PasswordSalt);
                        if (usersDto["HashedPassword"].ToString() == hasehedPassword)
                        {
                            if (output != null)
                            {
                                var tokenHandler = new JwtSecurityTokenHandler();
                                var key = Encoding.ASCII.GetBytes("GQDstcKsx0NHjPwDVvVBrk");

                                var now = DateTime.UtcNow;
                                var claims = new Claim[]
                                    {
                                        new Claim(JwtRegisteredClaimNames.Sub, usersDto["IntUserId"].ToString()),
                                        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                                        new Claim(JwtRegisteredClaimNames.Iat, now.ToUniversalTime().ToString(), ClaimValueTypes.Integer64)
                                    };

                                var tokenValidationParameters = new TokenValidationParameters
                                {
                                    ValidateIssuerSigningKey = true,
                                    IssuerSigningKey = new SymmetricSecurityKey(key),
                                    ValidateIssuer = true,
                                    ValidIssuer = "glassRUN",
                                    ValidateAudience = true,
                                    ValidAudience = "enduser",
                                    ValidateLifetime = true,
                                    ClockSkew = TimeSpan.Zero,
                                    RequireExpirationTime = true,
                                };

                                var jwt = new JwtSecurityToken(
                                       issuer: "glassRUN",
                                       audience: "enduser",
                                       claims: claims,
                                       notBefore: now,
                                       expires: now.Add(TimeSpan.FromMinutes(240)),
                                       signingCredentials: new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256)
                                    );

                                var tokenString = tokenHandler.WriteToken(jwt);
                                LoggerInstance.Information("Token generated", 5002);

                                usersDto["Token"] = tokenString;
                                string op = loginManager.UpdateToken(Convert.ToInt64(usersDto["IntUserId"].ToString()), tokenString);
                                LoggerInstance.Information("Token updated", 5002);
                                string finaloutput = JsonConvert.SerializeObject(usersDto);
                                returnObject = (JObject)JsonConvert.DeserializeObject(finaloutput);
                                LoggerInstance.Information(returnObject.ToString(), 5002);
                                break;
                            }
                        }
                    }
                }
                return Ok(returnObject);
            }
            catch (Exception ex)
            {
                LoggerInstance.Error(ex.Message, 404);
                return new CustomErrorActionResult(HttpStatusCode.NotFound, "Not Found");
            }
        }

       
    }
}
