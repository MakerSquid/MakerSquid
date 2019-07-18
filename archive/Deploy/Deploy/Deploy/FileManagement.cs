using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Deploy
{
	public class FileManagement
	{
		public static void RenameFile(string sourcename, string destname)
		{
			if (sourcename.Contains("*") && destname.Contains("*"))
			{
				string directory = sourcename.Substring(0, sourcename.IndexOf("*") - 1);
				string sourcePattern = sourcename.Substring(sourcename.IndexOf("*"));
				string destPattern = destname.Substring(destname.IndexOf("*"));

				RenameGroup(directory, sourcePattern, destPattern);
			}
			else
			{
				try
				{
					File.Move(sourcename, destname);
				}
				catch (Exception ex)
				{
					Display.Error(ex.Message);
				}
			}
		}

		private static void RenameGroup(string directory, string sourcePattern, string destPattern)
		{
			try
			{
				string[] files = Directory.GetFiles(directory, sourcePattern, SearchOption.TopDirectoryOnly);

				foreach (string file in files)
				{
					string oldValue = sourcePattern.Substring(sourcePattern.IndexOf("."));
					string newValue = destPattern.Substring(destPattern.IndexOf("."));
					string targetName = file.Replace(oldValue, newValue);
					RenameFile(file, targetName);
				}
			}
			catch (Exception ex)
			{
				Display.Error(ex.Message);
			}
		}

		public static void CopyFile(string sourceFile, string destFile, bool overwrite)
		{
			try
			{
				File.Copy(sourceFile, destFile, overwrite);
			}
			catch (Exception ex)
			{
				Display.Error(ex.Message);
			}
		}

		public static void DeleteDirectory(string directory, bool recursive)
		{
			try
			{
				Directory.Delete(directory, recursive);
			}
			catch (Exception ex)
			{
				Display.Error(ex.Message);
			}
		}
	}
}
