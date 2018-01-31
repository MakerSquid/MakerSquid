using System;
using System.Collections.Generic;
using System.Text;

namespace MakeGithubSafe
{
	class FilePackager
	{
		internal static void Go()
		{
			var fileIterator = new FileIterator();
			var archiver = new FileArchiver();
			var ignorer = new FileIgnorer();

			List<FileSelection> files = fileIterator.GetFilesToPackage();

			archiver.CreateArchives(files);
			ignorer.Ignore(files);
		}
	}
}
