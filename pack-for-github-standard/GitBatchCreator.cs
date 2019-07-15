using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PackForGithub
{
	public class GitBatchCreator
	{
		private long MAX_SIZE = 512000;

		public void CreateBatch( )
		{
			var files = new List<FileSelection>();

			//run git to get file list manually...

			//using(Process git = new Process())
			//{
			//	git.StartInfo.FileName = "git.exe";
			//	git.StartInfo.Arguments = "add -A -n > pending.txt";
			//	git.StartInfo.UseShellExecute = false;
			//	git.Start();

			//	git.WaitForExit();
			//}

			//iterate list and get file sizes
			string data = File.ReadAllText("pending.txt");
			var statements = data.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
			long totalSize = 0;
			List<string> output = new List<string>();

			foreach(var item in statements)
			{
				var filename = item.Remove(0, 5).TrimEnd(new char[] { '\'' });

				//write filename to batch
				output.Add("git " + item);

				var file = new FileInfo(filename);

				var fileSize = file.Length;
				totalSize += fileSize;

				if (totalSize >= MAX_SIZE)
				{
					//WRITE commit and push
					output.Add("git commit -m'batch add'");
					output.Add("git push");
					totalSize = 0;
				}

			}

			output.Add("git commit -m'batch add'");
			output.Add("git push");

			//batch files by making a command file to run each set of files...

			using (TextWriter writer = new StreamWriter("process.bat"))
			{
				foreach(string item in output)
				{
					writer.WriteLine(item);
				}
			}
		}
	}
}
