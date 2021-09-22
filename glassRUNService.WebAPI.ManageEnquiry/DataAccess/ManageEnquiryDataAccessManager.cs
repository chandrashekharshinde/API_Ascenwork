using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using glassRUNService.WebAPI.ManageEnquiry.DTO;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.ManageEnquiry.DataAccess
{

    public class ManageEnquiryDataAccessManager
    {
        public static T SaveEnquiry<T>(string jsonString)

        {
            //test
            //string outputJson = "";
            //return outputJson;
            string xmlDoc = jsonString;
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseWriteConnection))
            {
                IDbCommand command = new SqlCommand("ISP_EnquiryV2", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
                {
                    Value = xmlDoc
                });
                connection.Open();


                return DBHelper.Execute<T>(ref command);
            }
        }

        public static T SearchEnquiryList<T>(EnquirySearchDTO enquirySearchDTO)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_SearchEnquiryDetailsV2", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.CommandTimeout = 300;
                #region Parameter

                command.Parameters.Add(new SqlParameter("@RoleId", SqlDbType.BigInt)
                {
                    Value = (enquirySearchDTO.RoleId == null ? DBNull.Value as object : enquirySearchDTO.RoleId)
                });
                command.Parameters.Add(new SqlParameter("@PageIndex", SqlDbType.Int)
                {
                    Value = (enquirySearchDTO.PageIndex == null ? DBNull.Value as object : enquirySearchDTO.PageIndex)
                });
                command.Parameters.Add(new SqlParameter("@PageSize", SqlDbType.Int)
                {
                    Value = (enquirySearchDTO.PageSize == null ? DBNull.Value as object : enquirySearchDTO.PageSize)
                });
                command.Parameters.Add(new SqlParameter("@PageName", SqlDbType.NVarChar)
                {
                    Value = (enquirySearchDTO.PageName == null ? DBNull.Value as object : enquirySearchDTO.PageName)
                });
                command.Parameters.Add(new SqlParameter("@OrderBy", SqlDbType.NVarChar)
                {
                    Value = (enquirySearchDTO.OrderBy == null ? DBNull.Value as object : enquirySearchDTO.OrderBy)
                });
                command.Parameters.Add(new SqlParameter("@OrderByCriteria", SqlDbType.NVarChar)
                {
                    Value = (enquirySearchDTO.OrderByCriteria == null ? DBNull.Value as object : enquirySearchDTO.OrderByCriteria)
                });
                command.Parameters.Add(new SqlParameter("@PageControlName", SqlDbType.NVarChar)
                {
                    Value = (enquirySearchDTO.PageControlName == null ? DBNull.Value as object : enquirySearchDTO.PageControlName)
                });
                command.Parameters.Add(new SqlParameter("@LoginId", SqlDbType.BigInt)
                {
                    Value = (enquirySearchDTO.LoginId == null ? DBNull.Value as object : enquirySearchDTO.LoginId)
                });
                command.Parameters.Add(new SqlParameter("@whereClause", SqlDbType.NVarChar)
                {
                    Value = (enquirySearchDTO.whereClause == null ? DBNull.Value as object : enquirySearchDTO.whereClause)
                });
                command.Parameters.Add(new SqlParameter("@IsExportToExcel", SqlDbType.Bit)
                {
                    Value = (enquirySearchDTO.IsExportToExcel == null ? DBNull.Value as object : enquirySearchDTO.IsExportToExcel)
                });

                #endregion
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        public static T InsertEnquiryForGratisOrder<T>(string jsonString)
        {
            try
            {
                // string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                string xmlDoc = jsonString;
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseWriteConnection))
                {
                    IDbCommand command = new SqlCommand("ISP_EnquiryForGraticOrder", connection);
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


        //public static T InsertEnquiryForGratisOrder<T>(string jsonString)
        //{
        //    try
        //    {
        //        // string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
        //        string xmlDoc = jsonString;
        //        using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseWriteConnection))
        //        {
        //            IDbCommand command = new SqlCommand("ISP_EnquiryForGraticOrder", connection);
        //            command.CommandType = CommandType.StoredProcedure;
        //            command.Parameters.Add(new SqlParameter("@xmlDoc", SqlDbType.Xml)
        //            {
        //                Value = (xmlDoc ?? DBNull.Value as object)
        //            });

        //            connection.Open();
        //            return DBHelper.Execute<T>(ref command);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        //DataAccessExceptionHandler.HandleException(ref ex);
        //    }
        //    return default(T);
        //}


    }
}
