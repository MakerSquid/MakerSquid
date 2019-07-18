using System;
using System.Collections.Generic;
using PortSetter;

namespace Deploy
{
	public class PortSetter
	{
		private const string TARGET = "TARGET=";

		public static void Process(List<string> configs)
		{
			Display.Header("Setting Ports");
			ProcessTheTargets(GetTargets(configs), GetParams(configs));
		}

		private static void ProcessTheTargets(List<string> targets, List<string> parms)
		{
			targets.ForEach(x => ProcessATarget(x, parms));
		}

		private static void ProcessATarget(string target, List<string> parms)
		{
			string siteId = ListParser.Get("SITE-ID=", parms);
			string serviceUrl = ListParser.Get("SERVICE-URL=", parms);
			string servicePort = ListParser.Get("SERVICE-PORT=", parms);
			string crmUrl = ListParser.Get("CRM-URL=", parms);
			string crmPort = ListParser.Get("CRM-PORT=", parms);

			TargetSetter.Open(target);
			try
			{
				TargetSetter.Replace(BuildUrl(serviceUrl, servicePort, "0"), BuildUrl(serviceUrl, servicePort, siteId));
				TargetSetter.Replace(BuildUrl(crmUrl, crmPort, "0"), BuildUrl(crmUrl, crmPort, siteId));
			}
			finally
			{
				TargetSetter.Close();
			}
		}

		private static string BuildUrl(string url, string port, string siteId)
		{
			string formattedPort = FormatPort(port, siteId);

			return string.Format("{0}{1}", url, formattedPort);
		}

		private static string FormatPort(string port, string siteId)
		{
			string formatted = string.Empty;

			if (port != "80")
			{
				formatted = ":" + port;
				if (formatted.Contains("x"))
				{
					int site = Convert.ToInt32(siteId) - 1;

					if (site >= 0)
					{
						formatted = formatted.Replace("x", site.ToString());
					}
				}
			}

			return formatted;
		}

		private static List<string> GetTargets(List<string> configs)
		{
			List<string> targets = ListParser.FindInList(configs, TARGET, true);
			List<string> result = new List<string>();

			targets.ForEach(x => result.Add(x.Replace(TARGET, string.Empty)));

			return result;
		}

		private static List<string> GetParams(List<string> configs)
		{
			return ListParser.FindInList(configs, TARGET, false);
		}
	}
}