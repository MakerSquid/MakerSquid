using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace PortSetter
{
	public class TargetSetter
	{
		private static string _filename;
		private static StringBuilder _fileData;
		private const string PORT_MATCH = "\\:?\\d?\\d?\\d?\\d?";

		public static void Open(string filename)
		{
			Console.WriteLine(string.Format("Processing {0}.", filename));
			string[] sourceFileData = File.ReadAllLines(filename);

			_fileData = new StringBuilder();
			_filename = filename;

			foreach (string line in sourceFileData)
			{
				_fileData.Append(line + Environment.NewLine);
			}
		}

		public static void Replace(string original, string replacement)
		{
			string toReplace = PatternMatch(original);
			Regex regex = new Regex(toReplace, RegexOptions.IgnoreCase);

			Console.WriteLine(string.Format("Setting services to {0}.", replacement));

			if (regex.IsMatch(_fileData.ToString()))
			{
				StringBuilder newFileData = new StringBuilder();

				newFileData.Append(regex.Replace(_fileData.ToString(), replacement));
				_fileData = newFileData;
			}
		}

		//public static void StringReplace(string original, string replacement)
		//{
		//    Regex regex = new Regex(original, RegexOptions.IgnoreCase);

		//    if (regex.IsMatch(_fileData.ToString()))
		//    {
		//        StringBuilder newFileData = new StringBuilder();

		//        newFileData.Append(regex.Replace(_fileData.ToString(), replacement));
		//        _fileData = newFileData;
		//    }
		//}

		private static string PatternMatch(string original)
		{
			string result = original;

			if (result.EndsWith("x"))
			{
				string[] parts = result.Split(':');

				result = string.Format("{0}:{1}{2}", parts[0], parts[1], PORT_MATCH);
			}
			else //not using a port, but we need to find lines that do to fix them
			{
				result += PORT_MATCH;
			}

			return result;
		}

		public static void Close()
		{
			File.WriteAllText(_filename, _fileData.ToString());

			Console.WriteLine(string.Format("Completed {0}.", _filename));

			_filename = string.Empty;
			_fileData = null;
		}

		public static void GenerateFile(List<string> configs)
		{
			StringBuilder newFileData = new StringBuilder();
			foreach (string config in configs)
			{
				newFileData.Append(config + Environment.NewLine);
			}
			_fileData = newFileData;
		}
	}
}
