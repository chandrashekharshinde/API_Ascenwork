using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIController.Framework.AppLogger
{

    public class SchedulingLogger : BaseAppLogger
    {
        public SchedulingLogger() : base(EnumLoggerType.Scheduling)
        {

        }
    }
}
