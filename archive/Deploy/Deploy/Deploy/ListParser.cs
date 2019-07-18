using System;
using System.Collections.Generic;
using System.Linq;

namespace Deploy
{
	public class ListParser
	{
		public static string Get(string setting, List<string> parms)
		{
			return FindInList(parms, setting, true).First().Split('=')[1];
		}

		public static List<string> FindInList(List<string> configs, string match, bool condition)
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
	}
}
