using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.Common.DataAccess
{
    public class CommonDataAccessManager
    {

        public static string ResourceDataForApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_ResourceDataForApp", connection);
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

        public static string UpdateLoginHistoryB2BApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("USP_UpdateLoginHistoryB2BApp", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = xmlDoc
                    });
                    command.CommandTimeout = 900;
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

        public static string LoadAllPagesMenuListB2BApp(string jsonString)
        {
            string outputJson = "";
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllPagesMenuListB2BApp", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = xmlDoc
                    });
                    connection.Open();
                    outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));

                }

            }
            catch (Exception ex)
            {


            }
            return outputJson;
        }

        public static string LoadAllCultureMaster(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_LoadAllCultureMaster", connection);
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

        public static string LoadLookupForApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllLookupForApp", connection);
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

        public static string GetAllSettingMasterList(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllSettingMasterList", connection);
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


        public static string UserDetailDeviceTokenMapping(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("ISP_UserDetailDeviceTokenMapping", connection);
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


        public static string GetSQLCurrentDatetimeAndZone(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetSQLCurrentDatetimeAndZone", connection);
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

        public static string GetAllNotificationB2BApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllNotificationB2BApp", connection);
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


        public static string InsertApplogging(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("ISP_LogApp", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc ?? DBNull.Value as object)
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

    }
}
