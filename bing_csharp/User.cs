using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BingRewards
{
    public class User
    {
        public string UserName { get; set; }
        public string AccountName { get; set; }
        public string Password { get; set; }
        public int SearchLimit { get; set; }
        public int AvailablePoints { get; set; }
        public int LifetimePoints { get; set; }
    }
}
