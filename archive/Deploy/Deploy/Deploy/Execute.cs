using System;
using System.Diagnostics;
using System.Threading;

namespace Deploy
{
	public class Execute
	{
		public static void Command(string command, string args)
		{
			try
			{
				ProcessStartInfo processInfo = new ProcessStartInfo { UseShellExecute = false, Arguments = args, FileName = command };

				Process launchedExe = Process.Start(processInfo);

				launchedExe.WaitForExit();

				Thread.Sleep(500);

			}
			catch (Exception ex)
			{
				if (command.Contains("7z"))
				{
					Display.Error("7-zip could not be launched, please check that the path is correct in the config.txt file.", false);
					Display.Error("Install the 64 bit version if applicable.");
				}
				else
				{
					Display.Error(ex.Message);
				}
			}
		}
	}
}
