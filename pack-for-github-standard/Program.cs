using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PackForGithub
{
    class Program
    {
        static void Main(string[] args)
        {
			List<string> argList = new List<string>();

			if (args != null && args.Count() > 0)
			{
				argList = args.ToList();
			}

            FilePackager.Go(argList);
        }
    }
}
