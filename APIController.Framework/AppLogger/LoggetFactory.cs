using APIController.Framework.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIController.Framework.AppLogger
{

    /// <summary>
    /// Factory to return the respective logger instance
    /// </summary>
    public static class gRLoggerFactory
    {
        public static BaseAppLogger GetLogger(EnumLoggerType LoggerType)
        {
            BaseAppLogger baseLogger = null;
            switch (LoggerType.ToString())
             {
                case LoggingConstants.Customer:
                    baseLogger = new CustomerLogger();
                    break;
                case LoggingConstants.Enquiry:
                    baseLogger = new EnquiryLogger();
                    break;
                case LoggingConstants.Order:
                    baseLogger = new OrderLogger();
                    break;
                case LoggingConstants.Product:
                    baseLogger = new ProductLogger();
                    break;
                case LoggingConstants.Route:
                    baseLogger = new RouteLogger();
                    break;
                case LoggingConstants.Rules:
                    baseLogger = new RulesLogger();
                    break;
                case LoggingConstants.Workflow:
                    baseLogger = new WorkflowLogger();
                    break;
                case LoggingConstants.Supplier:
                    baseLogger = new SupplierLogger();
                    break;
                case LoggingConstants.NotificationSettings:
                    baseLogger = new NotificationSettingsLogger();
                    break;
                case LoggingConstants.Configurations:
                    baseLogger = new ConfigurationsLogger();
                    break;
                case LoggingConstants.User:
                    baseLogger = new UserLogger();
                    break;
                case LoggingConstants.Scheduling:
                    baseLogger = new SchedulingLogger();
                    break;
                case LoggingConstants.Login:
                    baseLogger = new LoginLogger();
                    break;
                case LoggingConstants.DeliveryApp:
                    baseLogger = new OrderLogger();
                    break;
                case LoggingConstants.Inventory:
                    baseLogger = new InverntoryLogger();
                    break;
                default:
                    break;
            }
            return baseLogger;
        }
    }
}
