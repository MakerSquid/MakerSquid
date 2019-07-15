using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace PackForGithub
{
	class FileIterator
	{
		private List<FileSelection> _fileList;

		private delegate bool ConditionDelegate(FileInfo item);

		internal List<FileSelection> GetFilesToPack()
		{
			_fileList = new List<FileSelection>();
			string basePath = GetBasepath();

			IteratePath(basePath, IsLargeFile);

			return _fileList;
		}

		private static string GetBasepath()
		{
			var assembly = System.Reflection.Assembly.GetExecutingAssembly();
			var basePath = assembly.Location.Remove(assembly.Location.Length - assembly.ManifestModule.Name.Length);

#if DEVMODE
			basePath = "C:\\solomon\\flac\\";
#endif
			return basePath;
		}

		internal List<FileSelection> GetFilesToUnpack()
		{
			_fileList = new List<FileSelection>();

			string basePath = GetBasepath();

			IteratePath(basePath, IsArchivedFile);

			return _fileList;
		}

		private void IteratePath(string path, ConditionDelegate condition)
		{
            var dirInfo = new DirectoryInfo(path);

            var dirList = dirInfo.EnumerateDirectories();
			var fileList = dirInfo.EnumerateFiles();

			foreach (var item in dirList)
			{
				if (!item.Name.StartsWith("."))
				{
					IteratePath(item.FullName, condition);
				}
			}

			foreach (var item in fileList)
			{
				if (condition(item))
				{
					_fileList.Add(new FileSelection { FileName = item.Name, FilePath = GetPathOnly(item.FullName, item.Name.Length) });
				}
			}

		}

		private string GetPathOnly(string path, int nameLength)
		{
			return path.Remove(path.Length - nameLength);
		}

		private bool IsLargeFile(FileInfo item)
		{
			return item.Length > 41943040;  //40 MB
		}

		private bool IsArchivedFile(FileInfo item)
		{
			return item.Name.EndsWith(".zip.001");
		}
	}
}
