using Consul;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;

namespace glassRUNService.WebApi.Configurations.Config
{
    public static class ServiceRegistryAppExtension
    {
        public static IServiceCollection AddConsulConfig(this IServiceCollection services, ConfigurationSetting configurationSetting)
        {
         
                services.AddSingleton<IConsulClient, ConsulClient>(p => new ConsulClient(consulConfig =>
                {
                    consulConfig.Address = new Uri(configurationSetting.ConsulAddresss);
                }));
           
            return services;
        }

        public static IApplicationBuilder UseConsul(this IApplicationBuilder app, List<ConfigurationSetting> configurationSetting)
        {

            var consulClient = app.ApplicationServices.GetRequiredService<IConsulClient>();
            var logger = app.ApplicationServices.GetRequiredService<ILoggerFactory>().CreateLogger("AppExtensions");
            var lifetime = app.ApplicationServices.GetRequiredService<IHostApplicationLifetime>();

            for (int i = 0; i < configurationSetting.Count; i++)
            {
               
                //var uri = new Uri(address);
                var registration = new AgentServiceRegistration()
                {
                    ID = configurationSetting[i].ID, //{uri.Port}",
                    // servie name  
                    Name = configurationSetting[i].ServiceName,
                    Address = configurationSetting[i].ServiceHost, //$"{uri.Host}",
                    Port = configurationSetting[i].ServicePort,  // uri.Port
                };

                logger.LogInformation("Registering with Consul");
                consulClient.Agent.ServiceDeregister(registration.ID).ConfigureAwait(true);
                consulClient.Agent.ServiceRegister(registration).ConfigureAwait(true);

              
            }


            lifetime.ApplicationStopping.Register(() =>
            {
                logger.LogInformation("Unregistering from Consul");
            });

            return app;
        }
    }
}
