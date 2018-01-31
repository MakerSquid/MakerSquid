using System;
using System.Collections.Generic;
using System.Text;

using Microsoft.Extensions.FileProviders;

namespace MakeGithubSafe
{
	class FileIterator
	{
		private List<FileSelection> _fileList;

		internal List<FileSelection> GetFilesToPackage()
		{
			_fileList = new List<FileSelection>();
			var assembly = System.Reflection.Assembly.GetExecutingAssembly();
			var basePath = assembly.Location.Remove(assembly.Location.Length - 18);

#if DEVMODE
			basePath = "C:\\solomon\\notes\\";
#endif

			IFileProvider fileProvider = new PhysicalFileProvider(basePath);

			IteratePath(fileProvider, "");



			return _fileList;
		}

		private void IteratePath(IFileProvider provider, string path)
		{
			var directoryInfo = provider.GetDirectoryContents(path);

			foreach(var item in directoryInfo)
			{
				if (item.IsDirectory)
				{
					IteratePath(provider, item.Name);
				}
				else
				{
					if (item.Length > 41943040)//40 MB
					{
						_fileList.Add(new FileSelection { FileName = item.Name, FilePath = GetPathOnly(item.PhysicalPath, item.Name.Length) });
					}
				}
			}

		}

		private string GetPathOnly(string path, int nameLength)
		{
			return path.Remove(path.Length - nameLength);
		}
	}
}
