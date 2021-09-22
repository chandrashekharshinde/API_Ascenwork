using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIController.Framework.AppLogger
{

    public class RouteLogger:BaseAppLogger
    {
        public RouteLogger() : base(EnumLoggerType.Route)
        {

        }
    }
}
