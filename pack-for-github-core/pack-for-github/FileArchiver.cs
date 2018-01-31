using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace MakeGithubSafe
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
			//check if zip exists first...

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
