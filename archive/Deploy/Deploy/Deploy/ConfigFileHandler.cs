using System.Collections.Generic;
using System.IO;
using PortSetter;

namespace Deploy
{
	public class ConfigFileHandler
	{
		private const string CONFIG_FILE = "Config.txt";

		public static List<string> LoadConfiguration()
		{
			List<string> configs = new List<string>();

			PopulateConfigs(configs);

			return configs;
		}

		private static void PopulateConfigs(List<string> configs)
		{
			TextReader reader = new StreamReader(CONFIG_FILE);

			do
			{
				configs.Add(reader.ReadLine());
			} while (reader.Peek() != -1);

			reader.Close();
		}

		public static void SaveConfiguration(List<string> configs)
		{
			TargetSetter.Open(CONFIG_FILE);
			try
			{
				TargetSetter.GenerateFile(configs);
			}
			finally
			{
				TargetSetter.Close();
			}
		}
	}
}
