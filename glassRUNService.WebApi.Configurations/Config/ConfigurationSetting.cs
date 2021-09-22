using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.Config
{
    public class ConfigurationSettings
    { 
        public List<ConfigurationSetting> Configurations { get; set; }
    }
    public class ConfigurationSetting
    {
        public string ServiceName { get; set; }
        public string ID { get; set; }
        public string ServiceHost { get; set; }
        public int ServicePort { get; set; }
        public string ConsulAddresss { get; set; }
        public DatabaseSettings DatabaseSettings { get; set; }
    }

    public partial class DatabaseSettings
    {
        public string ConnectionString { get; set; }
        public string DatabaseName { get; set; }
    }
}
