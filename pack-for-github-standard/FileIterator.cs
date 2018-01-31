using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace PackForGithub
{
	class FileIterator
	{
		private List<FileSelection> _fileList;

		internal List<FileSelection> GetFilesToPackage()
		{
			_fileList = new List<FileSelection>();
			var assembly = System.Reflection.Assembly.GetExecutingAssembly();
			var basePath = assembly.Location.Remove(assembly.Location.Length - assembly.ManifestModule.Name.Length);

#if DEVMODE
			basePath = "C:\\solomon\\notes\\";
#endif


			IteratePath(basePath);



			return _fileList;
		}

		private void IteratePath(string path)
		{
            var dirInfo = new DirectoryInfo(path);

            var dirList = dirInfo.EnumerateDirectories();
			var fileList = dirInfo.EnumerateFiles();

			foreach (var item in dirList)
			{
				if (!item.Name.StartsWith("."))
				{
					IteratePath(item.FullName);
				}
			}

			foreach (var item in fileList)
			{
				if (item.Length > 41943040)//40 MB
				{
					_fileList.Add(new FileSelection { FileName = item.Name, FilePath = GetPathOnly(item.FullName, item.Name.Length) });
				}
			}

		}

		private string GetPathOnly(string path, int nameLength)
		{
			return path.Remove(path.Length - nameLength);
		}
	}
}
