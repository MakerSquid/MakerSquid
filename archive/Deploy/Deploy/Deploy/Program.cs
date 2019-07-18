using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Deploy
{
	class Program
	{
		static void Main(string[] args)
		{
			Console.BufferHeight = 9999;

			DeploymentEngine.Process(args);
		}
	}
}
