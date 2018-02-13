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
			foreach(var item in files)
			{
				ZipAFile(item);
			}
		}

		private void ZipAFile(FileSelection file)
		{

			System.IO.FileInfo existCheck = new System.IO.FileInfo($"{file.FilePath}{file.FileName}.zip.001");
			if (!existCheck.Exists)
			{
				Console.WriteLine($"Archiving {file.FilePath}{file.FileName}...");

				var process = new Process()
				{
					StartInfo = new ProcessStartInfo
					{
						FileName = "7z.exe",
						Arguments = $"a -v40m \"{file.FilePath}{file.FileName}.zip\" \"{file.FilePath}{file.FileName}\"",
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
}
