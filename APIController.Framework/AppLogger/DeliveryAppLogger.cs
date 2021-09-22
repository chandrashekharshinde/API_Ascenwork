using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIController.Framework.AppLogger
{

    public class DeliveryAppLogger : BaseAppLogger
    {
        public DeliveryAppLogger() : base(EnumLoggerType.DeliveryApp)
        {

        }
    }
}
