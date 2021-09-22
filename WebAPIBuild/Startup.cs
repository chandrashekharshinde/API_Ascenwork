using System;
using System.IO;
using System.Linq;
using System.Reflection;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Prometheus;

namespace WebAPIBuild
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

        public IConfiguration Configuration { get; }
     

        //public static string ConnectionString { get; private set; }
        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            string IsUseCors = GetConfigSettings("IsUseCors");
            string CorsSites = GetConfigSettings("CorsSites");
            if (IsUseCors == "true")
            {
                services.AddCors(options =>
                {
                    options.AddPolicy(MyAllowSpecificOrigins,
                    builder =>
                    {
                        builder.WithOrigins(CorsSites).AllowAnyHeader().AllowAnyMethod();
                    });
                });
            }


            services.AddMvc();
            //services.AddSingleton<IConfiguration>(Configuration);
            services.AddControllers();
            services.AddControllers().AddNewtonsoftJson();
            //services.AddMvc().AddJsonOptions(options => options.JsonSerializerOptions.PropertyNamingPolicy = null);
            //services.AddControllers().AddJsonOptions(options => options.JsonSerializerOptions.PropertyNamingPolicy = null);
            services.AddControllers().AddNewtonsoftJson(options => { options.UseMemberCasing(); });
            services.AddSwaggerGen(options => 
            {
                options.ResolveConflictingActions(apiDescriptions => apiDescriptions.First());
                options.CustomSchemaIds(type => type.ToString());
                }
            );
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger();

            // Enable middleware to serve swagger-ui (HTML, JS, CSS, etc.),
            // specifying the Swagger JSON endpoint.
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "glassRUN APIs");
            });

            app.UseHttpsRedirection();

            app.UseRouting();
            app.UseHttpMetrics();

            string IsUseCors = GetConfigSettings("IsUseCors");
            if (IsUseCors == "true")
            {
                app.UseCors(MyAllowSpecificOrigins);
            }

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();//.RequireCors(MyAllowSpecificOrigins);
                endpoints.MapMetrics();
            });

  





            //Assembly asm = Assembly.GetExecutingAssembly();

            //var gg = asm.GetTypes()
            //     .Where(type => typeof(Controller).IsAssignableFrom(type)) //filter controllers
            //     .SelectMany(type => type.GetMethods())
            //     .Where(method => method.IsPublic && !method.IsDefined(typeof(NonActionAttribute)));




            //var controlleractionlist = asm.GetTypes()
            //        .Where(type => typeof(Controller).IsAssignableFrom(type)) //filter cont
            //        .SelectMany(type => type.GetMethods(BindingFlags.Instance | BindingFlags.DeclaredOnly | BindingFlags.Public))
            //        //.Where(m => !m.GetCustomAttributes(typeof(System.Runtime.CompilerServices.CompilerGeneratedAttribute), true).Any())
            //        .Select(x => new { Controller = x.DeclaringType.Name, Action = x.Name, ReturnType = x.ReturnType.Name, Attributes = String.Join(",", x.GetCustomAttributes().Select(a => a.GetType().Name.Replace("Attribute", ""))) })
            //        .OrderBy(x => x.Controller).ThenBy(x => x.Action).ToList();
        }

        private string GetConfigSettings(string configValue)
        {
            var configurationBuilder = new ConfigurationBuilder();
            var path = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
            configurationBuilder.AddJsonFile(path, false);


            var root = configurationBuilder.Build();
            var ConfigSettings = root.GetSection(configValue).Value;

            return ConfigSettings;
        }

    }
}
