using System;
using System.Collections.Generic;
using System.Text;

namespace PackForGithub
{
	class FilePackager
	{
		internal static void Go(List<string> argList)
		{
			var fileIterator = new FileIterator();
			var archiver = new FileArchiver();
			var ignorer = new FileIgnorer();
			var batcher = new GitBatchCreator();

			if (argList.Contains("-u"))
			{
				List<FileSelection> files = fileIterator.GetFilesToUnpack();

				Console.WriteLine($"Found {files.Count} files to extract.");

				archiver.ExtractArchives(files);
				//ignorer.Ignore(files);
			}
			else if (argList.Contains("-b"))
			{
				batcher.CreateBatch();
			}
			else
			{
				List<FileSelection> files = fileIterator.GetFilesToPack();

				Console.WriteLine($"Found {files.Count} files to package.");

				archiver.CreateArchives(files);
				ignorer.Ignore(files);
			}
		}
	}
}
