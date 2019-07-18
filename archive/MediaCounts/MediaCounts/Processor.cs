using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace MediaCounts
{
    public static class Processor
    {
        public static void UpdateDirectoryCounts(string path, bool removeCounts, bool verbose)
        {
            DirectoryInfo directoryInfo = new DirectoryInfo(path);
            DirectoryInfo[] directories;
            string format = removeCounts ? "{0}" : "{0} ({1})";

            directories = directoryInfo.GetDirectories("*", SearchOption.TopDirectoryOnly);

            foreach (DirectoryInfo directory in directories)
            {
                if (!directory.Name.StartsWith("."))
                {
	                FileInfo[] tsFiles = directory.GetFiles("*.ts", SearchOption.AllDirectories);
	                FileInfo[] aviFiles = directory.GetFiles("*.avi", SearchOption.AllDirectories);
	                FileInfo[] wtvFiles = directory.GetFiles("*.wtv", SearchOption.AllDirectories);
	                FileInfo[] mkvFiles = directory.GetFiles("*.mkv", SearchOption.AllDirectories);
	                FileInfo[] mpgFiles = directory.GetFiles("*.mpg", SearchOption.AllDirectories);
	                FileInfo[] mpegFiles = directory.GetFiles("*.mpeg", SearchOption.AllDirectories);
	                int fileCount = tsFiles.Count() + aviFiles.Count() + wtvFiles.Count() + mkvFiles.Count() + mpgFiles.Count() + mpegFiles.Count();
	
	                string dirName = string.Format(format
	                                               , ((directory.FullName.LastIndexOf(" (") != -1) ? directory.FullName.Substring(0, directory.FullName.LastIndexOf(" (")) : directory.FullName)
	                                               , fileCount);

                    if (fileCount == 0)
                    {
						Program.DisplayStatus("Removing directory: '" + directory.FullName + "'.");
                       	directory.Delete(true);
                    }
                    else if (dirName != directory.FullName)
                    {
                        try
                        {
							Program.DisplayStatus("Renaming: '" + directory.FullName + "' to: '" + dirName + "'.");
                            directory.MoveTo(dirName);
                        }
                        catch (IOException ex)
                        {
                            if (ex.Message.Contains("Cannot create a file when that file already exists."))
                            {
								Program.DisplayStatus("Combining: '" + dirName + "' and: '" + directory.FullName + "'.");
	                            CombineFolders(directory, dirName);
                            }
							else
							{
								Console.WriteLine(ex.Message);	
							}
                        }
                    }
                }
            }
        }

        private static void CombineFolders(DirectoryInfo directorySource, string dirNameTarget)
        {
            //move files from source to target
            foreach (FileInfo file in directorySource.EnumerateFiles())
            {
                try
                {
                    file.MoveTo(dirNameTarget + "\\" + file.Name);
                }
                catch (IOException ex)
				{
					Console.WriteLine(ex.Message);	
				}
			}

            //delete source dir
            try
            {
                directorySource.Delete(true);
            }
            catch (IOException ex)
			{
				Console.WriteLine(ex.Message);	
			}
        }
   }
}
