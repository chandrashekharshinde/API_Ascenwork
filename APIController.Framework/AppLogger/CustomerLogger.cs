using System;

namespace APIController.Framework.AppLogger
{

    public class CustomerLogger : BaseAppLogger
    {
        public CustomerLogger() : base(EnumLoggerType.Customer)
        {

        }
    }
}
