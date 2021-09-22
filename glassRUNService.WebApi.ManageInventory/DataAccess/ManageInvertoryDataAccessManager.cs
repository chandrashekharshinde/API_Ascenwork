using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using glassRUNService.WebApi.ManageInventory.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.ManageInventory.DataAccess
{
    public class ManageInvertoryDataAccessManager
    {
        public static T SaveInvertoryStock<T>(string jsonString)

        {
            //test
            //string outputJson = "";
            //return outputJson;
            string xmlDoc = jsonString;
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseWriteConnection))
            {
                IDbCommand command = new SqlCommand("ISP_InventoryStock", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                {
                    Value = xmlDoc
                });
                connection.Open();


                return DBHelper.Execute<T>(ref command);
            }
        }
        public static string GetStockDetail(SearchItemstockDTO searchItemstockDTO)
        {
            try
            {
              
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetStockDetailList", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@ItemCode", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.ItemCode ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@LocationCode", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.LocationCode ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@DeliveryLocationCode", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.DeliveryLocationCode ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@CompanyCode", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.CompanyCode ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@BusinessUnitCode", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.BusinessUnitCode ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@Aisle", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.Aisle ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@LotNumber", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.LotNumber ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@Rack", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.Rack ?? DBNull.Value as object)
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

        public static string GetDeliveryLocitemStockDetail(SearchItemstockDTO searchItemstockDTO)
        {
            try
            {

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetDeliverylocItemStockList", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@ItemCode", SqlDbType.VarChar)
                    {
                        Value = (searchItemstockDTO.ItemCode ?? DBNull.Value as object)
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

        public static string GetItemStockDetail(ItemstocksearchDTO ItemstocsearchkDTO)
        {
            try
            {

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetItemStockList", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@search", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.search ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@Brand", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.Brand ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@SortBy", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.SortBy ?? DBNull.Value as object)
                    });
                    
                    command.Parameters.Add(new SqlParameter("@PageIndex", SqlDbType.Int)
                    {
                        Value = (ItemstocsearchkDTO.PageIndex  as object)
                    });
                    command.Parameters.Add(new SqlParameter("@PageSize", SqlDbType.Int)
                    {
                        Value = (ItemstocsearchkDTO.PageSize as object)
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

        public static string GetTransactionDetail(ItemstocksearchDTO ItemstocsearchkDTO)
        {
            try
            {

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetTransactionlist", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@search", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.search ?? DBNull.Value as object)
                    });
                   
                    command.Parameters.Add(new SqlParameter("@SortBy", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.SortBy ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@Day", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.Day ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@TrasactionType", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.TransationType ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@FromDate", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.FromDate ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@ToDate", SqlDbType.VarChar)
                    {
                        Value = (ItemstocsearchkDTO.ToDate ?? DBNull.Value as object)
                    });
                    command.Parameters.Add(new SqlParameter("@PageIndex", SqlDbType.Int)
                    {
                        Value = (ItemstocsearchkDTO.PageIndex as object)
                    });
                    command.Parameters.Add(new SqlParameter("@PageSize", SqlDbType.Int)
                    {
                        Value = (ItemstocsearchkDTO.PageSize as object)
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

        public static string GetReasonCodeDetails(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllReasonCodeDeatils", connection);
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
        public static string GetRackandAisleDetails(string jsonString)

        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetRackandAisleList", connection);
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
        public static string GetLocationcodeDetails(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetLocationcodeList", connection);
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
