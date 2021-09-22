using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DataAccess
{
    public class ManageLotDataAccessManager
    {
        public static T SaveLotMaster<T>(string jsonString)

        {
            //test
            //string outputJson = "";
            //return outputJson;
            string xmlDoc = jsonString;
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseWriteConnection))
            {
                IDbCommand command = new SqlCommand("ISP_LotMaster", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                {
                    Value = xmlDoc
                });
                connection.Open();

                 
                return DBHelper.Execute<T>(ref command);
            }
        }
        public static string GetLotDetails(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetLotDetailsList", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc ?? DBNull.Value as object)
                    });
                    connection.Open();
                    var outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));
                    return outputJson;
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(string);
        }
    }
}
