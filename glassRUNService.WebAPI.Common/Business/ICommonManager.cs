
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebAPI.Common.Business
{
    public interface ICommonManager
    {
        string ResourceDataForApp(dynamic Json);
        string UpdateLoginHistoryB2BApp(dynamic Json);

        string LoadAllPagesMenuListB2BApp(dynamic Json);

        string LoadAllCultureMaster(dynamic Json);

        string LoadLookupForApp(dynamic Json);

        string GetAllSettingMasterList(dynamic Json);

        string UserDetailDeviceTokenMapping(dynamic Json);

        string GetSQLCurrentDatetimeAndZone(dynamic Json);

        string GetAllNotificationB2BApp(dynamic Json);

        string InsertApplogging(dynamic Json);
    }
}
