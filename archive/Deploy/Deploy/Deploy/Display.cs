using System;

namespace Deploy
{
	public class Display
	{
		public static void Header(string message)
		{
			string spacing = string.Empty;
			const string SEPARATOR = "========================================";

			for (int index = 0; index < ((SEPARATOR.Length / 2) - (message.Length / 2)); index++)
			{
				spacing += " ";
			}

			Output(string.Empty);
			Output(SEPARATOR);
			Output(spacing + message);
			Output(SEPARATOR);
			Output(string.Empty);
		}

		public static void Output(string message)
		{
			Console.WriteLine(message);
		}

		public static void Pause()
		{
			Output("Press any key to continue . . .");
			Console.ReadKey(true);
		}

		public static void Error(string message)
		{
			Error(message, true);
		}

		public static void Error(string message, bool pause)
		{
			ConsoleColor color = Console.ForegroundColor;
			Console.ForegroundColor = ConsoleColor.Red;
			Output(message);
			Console.ForegroundColor = color;
			if (pause)
			{
				Output(string.Empty);
				Pause();
			}
		}
	}
}
