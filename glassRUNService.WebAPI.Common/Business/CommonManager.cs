using APIController.Framework;
using APIController.Framework.AppLogger;
using glassRUN.Framework;
using glassRUN.Framework.Serializer;
using glassRUN.Framework.Utility;
using glassRUNProduct.DataAccess.Common;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using glassRUNService.WebAPI.Common.DataAccess;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using glassRUNService.WebAPI.Common.DataAccess;

namespace glassRUNService.WebAPI.Common.Business
{
    public class CommonManager : ICommonManager
    {
        BaseAppLogger _loggerInstance;
        public CommonManager(BaseAppLogger loggerInstance)
        {
            _loggerInstance = loggerInstance;
        }

        public string ResourceDataForApp(dynamic Json)
        {

            string output = CommonDataAccessManager.ResourceDataForApp(Json);

            return output;
        }

        public string UpdateLoginHistoryB2BApp(dynamic Json)
        {

            string output = CommonDataAccessManager.UpdateLoginHistoryB2BApp(Json);

            return output;
        }

        public string LoadAllPagesMenuListB2BApp(dynamic Json)
        {

            string output = CommonDataAccessManager.LoadAllPagesMenuListB2BApp(Json);

            return output;
        }

        public string LoadAllCultureMaster(dynamic Json)
        {

            string output = CommonDataAccessManager.LoadAllCultureMaster(Json);

            return output;
        }


        public string LoadLookupForApp(dynamic Json)
        {

            string output = CommonDataAccessManager.LoadLookupForApp(Json);

            return output;
        }


        public string GetAllSettingMasterList(dynamic Json)
        {
            string output = CommonDataAccessManager.GetAllSettingMasterList(Json);
            return output;
        }


        public string UserDetailDeviceTokenMapping(dynamic Json)
        {
            string output = CommonDataAccessManager.UserDetailDeviceTokenMapping(Json);
            return output;
        }

        public string GetSQLCurrentDatetimeAndZone(dynamic Json)
        {
            string output = CommonDataAccessManager.GetSQLCurrentDatetimeAndZone(Json);
            return output;
        }

        public string GetAllNotificationB2BApp(dynamic Json)
        {
            string output = CommonDataAccessManager.GetAllNotificationB2BApp(Json);
            return output;
        }


        public string InsertApplogging(dynamic Json)
        {
            string output = CommonDataAccessManager.InsertApplogging(Json);
            return output;
        }


        public CommonManager()
        {

        }

    }
}
