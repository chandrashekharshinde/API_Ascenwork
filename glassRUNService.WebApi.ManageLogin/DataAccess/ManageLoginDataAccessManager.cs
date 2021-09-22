using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.ManageLogin.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageLogin.DataAccess
{
    public class ManageLoginDataAccessManager
    {
        public static string GetB2BLogin(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetB2BLogin", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = xmlDoc
                    });


                    connection.Open();

                    string outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));

                    return outputJson;


                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(string);
        }

        public static string UpdateToken(long userId, string tokenString)
        {
            try
            {
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("USP_UpdateLoginToken", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@userId", SqlDbType.BigInt)
                    {
                        Value = userId
                    });
                    command.Parameters.Add(new SqlParameter("@tokenString", SqlDbType.NVarChar, 250)
                    {
                        Value = tokenString
                    });

                    connection.Open();

                    string outputJson = DBHelper.Execute<string>(ref command);

                    return outputJson;
                }
            }
            catch (Exception ex)
            {
                return default(string);
            }
        }


    }
}
