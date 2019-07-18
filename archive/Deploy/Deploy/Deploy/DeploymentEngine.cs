using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PortSetter;

namespace Deploy
{
	public class DeploymentEngine
	{
		public static void Process(string[] args)
		{
			bool initialPause = !ArgExists(args, "-nowait");

			//read configs
			List<string> configs = ConfigFileHandler.LoadConfiguration();
			string release = ListParser.Get("RELEASE=", configs);
			string build = ListParser.Get("BUILD=", configs);

			if (initialPause)
			{
				Display.Output("You are about to deploy SMART build " + release + "." + build + ".  Close this window to abort.");
				Display.Pause();
			}

			Display.Header("Starting deployment of " + release + "." + build);


			//backup
			Deploy.Backup(configs);

			//configure ports
			PortSetter.Process(configs);

			//deploy
			Deploy.Process(configs);

			Display.Header("Deployment complete");

			Display.Pause();
		}

		private static bool ArgExists(string[] args, string testFor)
		{
			bool result = false;

			foreach (string arg in args)
			{
				if (arg == testFor)
				{
					result = true;
				}
			}

			return result;
		}
	}
}
