using glassRUN.Framework.DataAccess;
using glassRUN.Framework.Serializer;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace glassRUN.Framework.Cache
{
    public class CacheManager
    {
        private IDatabase redis = RedisStore.RedisCache;

        public bool IfExists(string key, IMemoryCache cache)
        {
            bool returnCacheExistsValue = false;
            if (cache.TryGetValue(key, out _))
            {
                returnCacheExistsValue = true;
            }

            return returnCacheExistsValue;
        }

        public void Add(string cacheKey, double expirationInMinutes, object data, IMemoryCache cache)
        {
            #region Route Information Cache
            MemoryCacheEntryOptions cacheExpirationOptions = new MemoryCacheEntryOptions();
            cacheExpirationOptions.AbsoluteExpiration = DateTime.Now.AddMinutes(expirationInMinutes);
            cacheExpirationOptions.Priority = CacheItemPriority.Normal;

            cache.Set<object>(cacheKey, data, cacheExpirationOptions);

            #endregion
        }

        public object Get(string cacheKey, IMemoryCache cache)
        {
            #region Route Information Cache
            object returnObject = cache.Get<object>(cacheKey);
            return returnObject;
            #endregion
        }


        public void Add(string key, object value, string dummy)
        {
            TimeSpan interval = new TimeSpan(2, 0, 0, 0, 0);
            redis.StringSet(key, JsonConvert.SerializeObject(value), interval);
        }

        public string Get(string key)
        {
            var redisvalue = redis.StringGet((RedisKey)key);

            if (string.IsNullOrEmpty(key))
                throw new ApplicationException("Invalid Key.");

            return redisvalue;
        }


        public void KeyDelete(string key)
        {
            var redisvalue = redis.KeyDelete((RedisKey)key);
        }



        public void Remove(string cacheKey, IMemoryCache cache)
        {
            cache.Remove(cacheKey);


        }

        public dynamic GetCacheSetting(string key)
        {
            dynamic Json = new JObject();
            Json.SettingParameter = "";
            Json.SettingValue = "";
            string outputJson = "";
            try
            {
                var getCacheValue = Get("CacheSetting");
                if (string.IsNullOrEmpty(getCacheValue) || getCacheValue == "null")
                {
                    using (var connection = ConnectionManager.Create(ConnectionManager.ConnectTo.glassRUNDatabaseREADConnection))
                    {
                        IDbCommand command = new SqlCommand("SSP_GetCacheSetting", connection);
                        command.CommandType = CommandType.StoredProcedure;
                        connection.Open();
                        outputJson = JSONAndXMLSerializer.XMLtoJSON(DBHelper.Execute<string>(ref command));
                    }

                    dynamic cacheSetting = (JObject)JsonConvert.DeserializeObject(outputJson);
                    Add("CacheSetting", cacheSetting, "");
                    getCacheValue = Get("CacheSetting");
                }

                if (!string.IsNullOrEmpty(getCacheValue) && getCacheValue != "null")
                {
                    JObject objWorkFlowServiceAction = (JObject)JsonConvert.DeserializeObject(getCacheValue);
                    string jsonData = JsonConvert.SerializeObject(objWorkFlowServiceAction);
                    JObject obj = (JObject)JsonConvert.DeserializeObject(jsonData);
                    JObject jsonObj = JObject.Parse(jsonData);
                    var processToExecuteList = jsonObj["CacheSetting"]["CacheSettingList"].ToList();
                    if (processToExecuteList.Count > 0)
                    {
                        var FilterData = processToExecuteList.Where(n => n["CacheKey"].Value<string>() == key).ToList();
                        if (FilterData.Count > 0)
                        {
                            Json.SettingParameter = Convert.ToString(FilterData[0]["SettingParameter"]);
                            Json.SettingValue = Convert.ToString(FilterData[0]["SettingValue"]);
                        }
                    }
                }
                
            }
            catch (Exception ex)
            {

            }
            return Json;
        }


    }
}
