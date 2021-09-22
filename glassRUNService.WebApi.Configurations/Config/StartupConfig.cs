using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace glassRUNService.WebApi.Configurations.Config
{
    public static class StartupConfig
    {
        public static List<ConfigurationSetting> RegisterConfiguration(this IServiceCollection services, IConfiguration configuration)
        {

            var subSettings = configuration.GetSection("Configuration").Get<List<ConfigurationSetting>>();
            services.Configure<List<ConfigurationSetting>>(configuration.GetSection("Configuration"));
            //services.Configure<ConfigurationSetting>(configuration.GetSection("Configuration"));


            var serviceProvider = services.BuildServiceProvider();
            var iop = serviceProvider.GetService<IOptions<List<ConfigurationSetting>>>();
            return iop.Value;
        }
    }
}
