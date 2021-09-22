using glassRUN.Framework.DataAccess;
using System;
using glassRUNService.WebApi.Configurations.DTO;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using glassRUN.Framework.Serializer;

namespace glassRUNService.WebApi.Configurations.DataAccess
{
    public class ConfigurationsDataAccessManager
    {    //Find get setting information 
        public static T GetSetting<T>(int? CompanyId)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetSettingV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@CompanyId", SqlDbType.BigInt)
                {
                    Value = (CompanyId == null ? DBNull.Value as object : CompanyId)
                });

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }
        /// <summary>
        /// get lookup details data sccess layer 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static T GetLookUpDetails<T>()
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetLookupDetailsV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }
        /// <summary>
        /// Get data for get language resource 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static T GelLanguageResource<T>()
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GETLANGUAGERESOURCESV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }
        /// <summary>
        /// get the data from data acceess for the page controls configurations
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="RoleMasterId"></param>
        /// <returns></returns>
        public static T GetPageControlConfigurations<T>(long? RoleId)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetPageControlsV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@Roleid", SqlDbType.BigInt)
                {
                    Value = (RoleId == null ? DBNull.Value as object : RoleId)
                });

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }
        /// <summary>
        /// Data Access implementation for the get page validation
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="RoleMasterId"></param>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        public static T GetPageValidations<T>(long? CompanyId)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetPageValidationsV2", connection);
                command.CommandType = CommandType.StoredProcedure;


                command.Parameters.Add(new SqlParameter("@CompanyId", SqlDbType.BigInt)
                {
                    Value = (CompanyId == null ? DBNull.Value as object : CompanyId)
                });

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        /// <summary>
        /// Data Access implementation for the get page validation
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="CompanyId"></param>
        /// <returns></returns>
        public static T GetPageValidationsV3<T>(long? CompanyId)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetPageValidationsV3", connection);
                command.CommandType = CommandType.StoredProcedure;


                command.Parameters.Add(new SqlParameter("@CompanyId", SqlDbType.BigInt)
                {
                    Value = (CompanyId == null ? DBNull.Value as object : CompanyId)
                });

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        /// <summary>
        /// implementation of get data for the Get Culture Configuration
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static T GetCultureConfigurations<T>()
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetCultureConfigurationsV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        public static T StatusWiseColorList<T>(ColorStatusDTO colorStatusDTO)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetRoleWiseStatusV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@RoleId", SqlDbType.BigInt)
                {
                    Value = (colorStatusDTO.RoleId == null ? DBNull.Value as object : colorStatusDTO.RoleId)
                });
                command.Parameters.Add(new SqlParameter("@CultureId", SqlDbType.BigInt)
                {
                    Value = (colorStatusDTO.CultureId == null ? DBNull.Value as object : colorStatusDTO.CultureId)
                });
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }


        public static T AdvertisingBannerList<T>(AdvertisingBannerDTO advertisingBannerDTO)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetAdvertisingBannerV2", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@RoleId", SqlDbType.BigInt)
                {
                    Value = (advertisingBannerDTO.RoleId == null ? DBNull.Value as object : advertisingBannerDTO.RoleId)
                });
                command.Parameters.Add(new SqlParameter("@UserId", SqlDbType.BigInt)
                {
                    Value = (advertisingBannerDTO.UserId == null ? DBNull.Value as object : advertisingBannerDTO.UserId)
                });
                command.Parameters.Add(new SqlParameter("@CompanyId", SqlDbType.BigInt)
                {
                    Value = (advertisingBannerDTO.CompanyId == null ? DBNull.Value as object : advertisingBannerDTO.CompanyId)
                });
                command.Parameters.Add(new SqlParameter("@Field1", SqlDbType.NVarChar)
                {
                    Value = (advertisingBannerDTO.Field1 == null ? DBNull.Value as object : advertisingBannerDTO.Field1)
                });
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        public static T BrandList<T>(BrandDTO brandDTO)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetBrandListV2", connection);
                command.CommandType = CommandType.StoredProcedure;
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        public static T GetAppLatestVersionList<T>(AppLatestVersionDTO appLatestVersionDTO)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_AppLatestVersionListV2", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AppType", SqlDbType.BigInt)
                {
                    Value = (appLatestVersionDTO.AppType == null ? DBNull.Value as object : appLatestVersionDTO.AppType)
                });
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }


        public static string GetAllFilterParametersByPageId(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllFilterParametersByPageId", connection);
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

        public static string GetAllSortingParametersByPageId(string jsonString)
        {
            try
            {
                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);
                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAllSortingParametersByPageId", connection);
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

        public static string GetAppPageControlAccessByPageIdAndRoleAndUserID(string jsonString)
        {


            string outputJson = "";



            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_GetAppPageControlAccessByPageIdAndRoleAndUserID", connection);
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
        public static string PageLevelConfigurationForApp(string jsonString)
        {


            string outputJson = "";



            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_PageLevelConfigurationForApp", connection);
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



        public static T GetConfigurationModifyAPIList<T>(ConfigurationModificationStatusDTO configurationModificationStatusDTO)
        {
            using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
            {
                IDbCommand command = new SqlCommand("SSP_GetConfigurationModifyAPIV2", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@AppType", SqlDbType.BigInt)
                {
                    Value = (configurationModificationStatusDTO.AppType == null ? DBNull.Value as object : configurationModificationStatusDTO.AppType)
                });

                command.Parameters.Add(new SqlParameter("@ConfigurationCode", SqlDbType.NVarChar)
                {
                    Value = (configurationModificationStatusDTO.ConfigurationCode == null ? DBNull.Value as object : configurationModificationStatusDTO.ConfigurationCode)
                });
                connection.Open();
                return DBHelper.Execute<T>(ref command);
            }

        }

        public static string LoadAllAppFormList(string jsonString)
        {
            try
            {

                string xmlDoc = JSONAndXMLSerializer.JSONtoXML(jsonString);

                using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                {
                    IDbCommand command = new SqlCommand("SSP_LoadAppFormList", connection);
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
