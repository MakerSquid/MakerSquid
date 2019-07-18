using System.Linq;
using System.Text;

namespace TV_Copier
{
	public static class StringUtility
	{
		public static string RemoveExtraQuotes(string directory)
		{
			if (directory.StartsWith("\"") && directory.EndsWith("\""))
			{
				directory = directory.Substring(1, directory.Length - 2);
			}

			return directory;
		}

		public static string StripNonAlphaNumerics(string input)
		{
			StringBuilder result = new StringBuilder();

			if (!string.IsNullOrEmpty(input))
			{
				foreach (char character in input.Where(character => char.IsLetterOrDigit(character)))
				{
					result.Append(character);
				}
			}

			return result.ToString();
		}
	}
}
