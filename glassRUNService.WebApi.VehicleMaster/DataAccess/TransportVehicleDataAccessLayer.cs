using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.IO;
using glassRUNProduct.DataAccess;
using glassRUN.Framework.Serializer;
using glassRUN.Framework.DataAccess;
using System.Data.SqlClient;

namespace glassRUNService.WebApi.VehicleMaster.DataAccess
{
    public class TransportVehicleDataAccessLayer
    {
        public static string LoadTransportVehicleDetails_getPagging(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllTransportVehicleList", connection);
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



        public static T Insert<T>(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                //string xmlDoc = jsonString;
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    //IDbCommand command = new SqlCommand("ISP_TransporterVehicle", connection);
                    IDbCommand command = new SqlCommand("ISP_TransportVehicle", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc ?? DBNull.Value as object)
                    });

                    connection.Open();

                    //var outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));

                    //return outputJson;
                    return DBHelper.Execute<T>(ref command);
                }
                
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            // return default(string);
            return default(T);
        }



        public static T Update<T>(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                //string xmlDoc = jsonString;
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("USP_TransportVehicle", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc ?? DBNull.Value as object)
                    });

                    connection.Open();

                    //var outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));

                    //return outputJson;
                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(T);
        }

        public static string CheckDuplicateTransportVehicale(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_DuplicateTransportVehicleCheck", connection);
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



        public static T GetAllTransportVehicle_Paging<T>(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllTransportVehicle_Paging", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc ?? DBNull.Value as object)
                    });
                    connection.Open();
                    //string outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));
                    //return outputJson;
                    //StringReader theReader = new StringReader(DBHelper.Execute<string>(ref command));

                    //DataSet ds = new DataSet();
                    //ds.ReadXml(theReader);
                    return DBHelper.Execute<T>(ref command);





                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(T);
        }



        public object DataTableToJsonObject(DataTable dt)
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return rows;
        }


        public static string GetTransportVehicleById(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetTransportVehicleById", connection);
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

        public static string DeleteTransportVehicleById(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("DSP_TransportVehicleById", connection);
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
        
        public static string Delete(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("DSP_TruckVehicle", connection);
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



        public static string LoadTransportVehicleByTransportVehicleId(string jsonString)
        {

            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_LoadTransportVehicleByTransportVehicleId", connection);
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
            }

            return default(string);
        }




        public static string GetTransportVehicleDetailsById(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetTransportVehicleDetailsByTransportVehicleId", connection);
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



        public static string GetPlateNumberByCarrierId(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllPlateNumberByCarrierId", connection);
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



        public static string GetDriverByPlateNoId(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllDriverNamrByPlateNumber", connection);
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


        public static string GetAllPlateNumberForSecurityApp(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllPlateNumberForSecurityApp", connection);
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

        public static string GetCountryDetails()
        {
            try
            {
                //string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("GetCountry", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    //command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    //{
                    //    Value = (xmlDoc ?? DBNull.Value as object)
                    //});

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

        public static string GetAllTransportVehicleToSync()
        {
            try
            {
                //string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("GetAllTransportVehicleToSync", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    //command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    //{
                    //    Value = (xmlDoc ?? DBNull.Value as object)
                    //});

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
