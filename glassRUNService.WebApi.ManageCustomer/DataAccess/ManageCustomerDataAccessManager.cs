using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.ManageCustomer.DataAccess
{
    public class ManageCustomerDataAccessManager
    {
        public static string GetAllSupplierDetailsB2BApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllSupplierB2BApp", connection);
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

        public static string GetAllCustomerListB2BApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllCustomerListforB2BApp", connection);
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

        public static string GetCustomerDetailsBySupplier(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllCustomerFromHierarchy", connection);
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

        public static string UpdateManageCusomerDetailsB2BApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("USP_UpdateManageCustomerB2BApp", connection);
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


        public static string SaveCustomerGroup(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("ISP_CustomerGroupForPricing", connection);
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

    }
}
