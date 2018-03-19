using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace PackForGithub
{
	class FileArchiver
	{
		internal void CreateArchives(List<FileSelection> files)
		{
			foreach (var file in files)
			{
				ZipAFile(file);
			}
		}

		internal void ExtractArchives(List<FileSelection> files)
		{
			foreach (var file in files)
			{
				ExtractAFile(file);
			}
		}

		private void ExtractAFile(FileSelection file)
		{
			string targetFile = $"{file.FilePath}{file.FileName}".Replace(".zip.001", "");

			System.IO.FileInfo existCheck = new System.IO.FileInfo(targetFile);
			if (!existCheck.Exists)
			{
				Exec7Zip(file, $"e -o\"{file.FilePath}\"", $"\"{file.FilePath}{file.FileName}\"");
			}
		}

		private void ZipAFile(FileSelection file)
		{
			string pathArgs = $"\"{file.FilePath}{file.FileName}.zip\" \"{file.FilePath}{file.FileName}\"";

			System.IO.FileInfo existCheck = new System.IO.FileInfo($"{file.FilePath}{file.FileName}.zip.001");
			if (!existCheck.Exists)
			{
				Console.WriteLine($"Archiving {file.FilePath}{file.FileName}...");

				Exec7Zip(file, "a -v40m", pathArgs);
			}
			else
			{
				Console.WriteLine($"Updating {file.FilePath}{file.FileName}...");

				Exec7Zip(file, "u -v40m", pathArgs);
			}
		}

		private static void Exec7Zip(FileSelection file, string switches, string paths)
		{
			var process = new Process()
			{
				StartInfo = new ProcessStartInfo
				{
					FileName = "7z.exe",
					Arguments = $"{switches} {paths}",
					RedirectStandardOutput = true,
					UseShellExecute = false,
					CreateNoWindow = true,
				}
			};
			process.Start();
			string result = process.StandardOutput.ReadToEnd();
			process.WaitForExit();
		}
	}
}
