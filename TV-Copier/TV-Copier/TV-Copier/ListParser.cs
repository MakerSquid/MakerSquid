using System.Collections.Generic;
using System.Linq;

namespace TV_Copier
{
	public class ListParser
	{
		public static string Get(string setting, List<string> parms)
		{
			string result = string.Empty;
			List<string> found = FindInList(parms, setting, true);

			if (found.Count > 0)
			{
				result = found.First().Split('=')[1];
			}

			return result;
		}

		private static List<string> FindInList(List<string> configs, string match, bool condition)
		{
			return (from config in configs
					where config.StartsWith(match) == condition
					select config).ToList();
		}

		public static List<string> Set(string settingName, string settingValue, List<string> configs)
		{
			List<string> localConfigs = new List<string>();

			foreach (string setting in configs)
			{
				string settingCopy = setting;

				if (settingCopy.StartsWith(settingName))
				{
					settingCopy = string.Format("{0}={1}", settingName, settingValue);
				}

				localConfigs.Add(settingCopy);
			}

			return localConfigs;
		}

		public static List<string> GetSection(string section, List<string> configs)
		{
			List<string> result = new List<string>();

			for (int index = 0; index < configs.Count; index++)
			{
				if (configs[index] != section) continue;

				//read until a new section or end of file
				for (int index2 = index + 1; index2 < configs.Count; index2++)
				{
					if (!configs[index2].StartsWith("#") && !string.IsNullOrEmpty(configs[index2]))
					{
						if (configs[index2].StartsWith("["))
						{
							break;
						}

						result.Add(configs[index2]);
					}
				}
			}

			return result;
		}
	}
}
