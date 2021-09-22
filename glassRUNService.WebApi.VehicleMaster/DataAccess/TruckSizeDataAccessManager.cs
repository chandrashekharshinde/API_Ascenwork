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
    public class TruckSizeDataAccessManager
    {
        #region SELECT METHODS

        public static string GetAllTruckSizeList(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllTruckSizeList", connection);
                    command.CommandType = CommandType.StoredProcedure;


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



        public static string GetAllTruck(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllTruckByLookup", connection);
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



        public static string Insert(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("ISP_TruckSize", connection);
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



        public static string Update(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("USP_TruckSize", connection);
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

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("DSP_TruckSize", connection);
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




        public static string LoadTruckDetails_getPagging(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllTruckList", connection);
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



        public static string GetTruckDetailsById(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetTruckDetailsByTruckId", connection);
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




        public static string GetAllTruckSizeListByTruckSizeName(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllTruckSizeByTruckSizeName", connection);
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






        ///<summary>
        ///Static method to return a TruckSize instance by TruckSizeId.
        ///</summary>
        ///<param name="truckSizeId">The truckSizeId of the TruckSize to be retrieved.</param>
        ///<returns>A TruckSize Object populated with the data relevant to the supplied truckSizeId.</returns>
        ///<remarks>If the requested id cannot be found in the database the TruckSize will have a value of null.</remarks>
        ///<remarks>Based on the underlying SSP_TruckSize_SelectByPrimaryKey stored procedure.</remarks>
        public static T GetTruckSizeById<T>(long truckSizeId)
        {

            try
            {
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_TruckSize_ByTruckSizeId", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@TruckSizeId", SqlDbType.BigInt)
                    {
                        Value = (truckSizeId == null ? DBNull.Value as object : truckSizeId)
                    });
                    connection.Open();
                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }

            return default(T);
        }


        ///<summary>
        ///Static method to return a generic list of all TruckSize objects.
        ///</summary>
        /// <returns>A generic List of all the TruckSize objects in the database.</returns>
        ///<remarks>Based on the underlying SSP_TruckSize_SelectAll stored procedure.</remarks>
        public static T GetAllTruckSize<T>()
        {
            try
            {
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllTruckSizes", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    connection.Open();

                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }

            return default(T);
        }



        ///<summary>
        ///Static method to return a generic list of paged TruckSize objects.
        ///</summary>
        ///<param name="pageIndex">The page index to be retrieved.</param>
        ///<param name="pageSize">The number of rows in the page to be retrieved.</param>
        ///<param name="whereExpression">A valid Sql WHERE expression e.g. 'IsEnabled = 1' or null if no filter is required.</param>
        ///<param name="sortExpression">A valid Sql ORDER BY expression e.g. 'EntityId, EntityName ASC' or null if default sorting by PK is required.</param>
        /// <returns>A generic List of paged TruckSize objects in the database.</returns>
        /// <param name="totalRowCount">The total row count that would be returned by the WHERE expression.</param>
        ///<remarks>Based on the underlying SSP_TruckSize_SelectPaged stored procedure.</remarks>
        public static T GetPaging<T>(int pageSize, int pageIndex, string xmlDoc)
        {
            try
            {
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_TruckSizeDataAccessManager_SelectPaged", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = xmlDoc
                    });
                    command.Parameters.Add(new SqlParameter("@pageIndex", SqlDbType.Int)
                    {
                        Value = pageIndex
                    });
                    command.Parameters.Add(new SqlParameter("@pageSize", SqlDbType.Int)
                    {
                        Value = pageSize
                    });

                    connection.Open();

                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(T);
        }

        ///<summary>
        ///Static method to return a generic list of TruckSize objects by criteria expression.
        ///</summary>
        ///<param name="whereExpression">A valid Sql WHERE expression e.g. 'IsEnabled = 1' or null if no filter is required.</param>
        ///<param name="sortExpression">A valid Sql ORDER BY expression e.g. 'EntityId, EntityName ASC' or null if default sorting by PK is required.</param>
        /// <returns>A generic List of TruckSize objects filtered by the criteria expressions.</returns>
        ///<remarks>Based on the underlying SSP_TruckSize_SelectByCriteria stored procedure.</remarks>
        public static T GetByCriteria<T>(String whereExpression, String sortExpression)
        {
            try
            {
                if (String.IsNullOrEmpty(whereExpression))
                    whereExpression = String.Empty;

                //Set default sort expression if necessary
                if (String.IsNullOrEmpty(sortExpression))
                    sortExpression = "[TruckSizeId] Asc";

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_TruckSize_SelectByCriteria", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@whereExpression", SqlDbType.Xml)
                    {
                        Value = whereExpression
                    });
                    command.Parameters.Add(new SqlParameter("@sortExpression", SqlDbType.NVarChar)
                    {
                        Value = sortExpression
                    });

                    connection.Open();

                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(T);
        }


        public static string LoadTruckDetailByLocationIdAndCompanyId(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetTruckByLocationIdAndCompanyId", connection);
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




        public static string LoadAllTruckSizeLisByDropDown(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_TruckSizeList_SelectByDropDown", connection);
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
        #endregion


        #region UDPATE METHODS

        ///<summary>
        ///Static method to update a TruckSize.
        ///</summary>
        ///<param name="truckSize">The TruckSize to be updated.</param>
        ///<param name="transactionManager">The relevant <see cref="TransactionManager"/> to be used during a transactional process.</param>
        ///<returns>The number of records updated in the underlying database.</returns>
        ///<remarks>Based on the underlying USP_TruckSize_Update stored procedure.</remarks>
        public static T Update<T>(string xmlDoc)
        {
            try
            {
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("USP_TruckSize_Update", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc == null ? DBNull.Value as object : xmlDoc)
                    });

                    connection.Open();

                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(T);
        }

        #endregion


        #region INSERT METHODS

        ///<summary>
        ///Static method to insert a TruckSize.
        ///</summary>
        ///<param name="truckSize">The TruckSize to be inserted.</param>
        ///<param name="transactionManager">The relevant <see cref="TransactionManager"/> to be used during a transactional process.</param>
        ///<returns>The number of rows affected or zero if no rows were inserted.</returns>
        ///<remarks>Based on the underlying ISP_TruckSize_Insert stored procedure.</remarks>
        public static T Insert<T>(string xmlDoc)
        {
            try
            {
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("ISP_TruckSize_Insert", connection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                    {
                        Value = (xmlDoc ?? DBNull.Value as object)
                    });

                    connection.Open();

                    return DBHelper.Execute<T>(ref command);
                }
            }
            catch (Exception ex)
            {
                //DataAccessExceptionHandler.HandleException(ref ex);
            }
            return default(T);
        }

        #endregion

        #region CUSTOM METHODS
        public static string LoadTruckSizeDetails(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_TruckSize_Paging", connection);
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

        public static string SaveTruckSizeDetails(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNProductConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_TruckSize_Paging", connection);
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





        public static string GetAllTruckSizeListByVehicleId(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_AllTruckSizeListByVehicleId", connection);
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







        #endregion
    }
}
