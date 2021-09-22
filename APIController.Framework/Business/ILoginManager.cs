using APIController.Framework.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIController.Framework.Business
{

    public interface ILoginManager
    {
        List<LoginDTO> GetLoginDetailsById(LoginDTO loginDTO);
    }
}
