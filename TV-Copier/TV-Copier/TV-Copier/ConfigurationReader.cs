using System.Collections.Generic;
using System.IO;

namespace TV_Copier
{
	public class ConfigFileHandler
	{
		private const string CONFIG_FILE = "n:\\settings.conf";
		//private const string CONFIG_FILE = "settings.conf";

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
	}
}