using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace TV_Copier
{
    class FileProcessor
    {
        private const string DROP_FOLDER = "V:\\TV - Unsorted";
        private const string TV_KIDS = "V:\\TV - Kids";
        private const string TV = "V:\\TV";
        private const string TV_720P = "V:\\TV - 720p";

        public static void Process()
        {
            DirectoryInfo directoryInfo = new DirectoryInfo(DROP_FOLDER);
            FileInfo[] files = directoryInfo.GetFiles("*.avi", SearchOption.AllDirectories);

            foreach (FileInfo fileInfo in files)
            {
                if (!AttemptToCopy(fileInfo, TV))
                {
                    if (!AttemptToCopy(fileInfo, TV_KIDS))
                    {
                        if (!AttemptToCopy(fileInfo, TV_720P))
                        {
                            CreateFolderAndCopy(fileInfo, TV);
                        }
                    }
                }
            }
        }

        private static void LogError(FileInfo fileInfo, string message)
        {
            TextWriter writer = new StreamWriter(fileInfo.FullName + ".error");

            writer.WriteLine(DateTime.Now);
            writer.WriteLine("The file could not be copied. " + message);
            writer.Close();
        }

        private static bool AttemptToCopy(FileInfo fileInfo, string targetDir)
        {
            bool copied = false;
            if (IsEligible(fileInfo))
            {
                string target = FindTarget(Path.GetFileName(fileInfo.FullName), targetDir);

                if (!string.IsNullOrEmpty(target))
                {
                    copied = true;
                    string message = string.Empty;
                    try
                    {
                        message = string.Format("Copied {0} to {1}.", Path.GetFileName(fileInfo.FullName), target);
                        fileInfo.CopyTo(target);
                    }
                    catch (Exception ex)
                    {
                        message = ex.Message;

                        if (!(message.StartsWith("The file ") && message.EndsWith(" already exists.")))
                        {
                            LogError(fileInfo, message);
                        }
                    }
                    finally
                    {
                        Console.WriteLine(message);
                    }
                }
            }
            return copied;
        }

        private static bool IsEligible(FileInfo fileInfo)
        {
            return fileInfo.LastWriteTime.CompareTo(DateTime.Now.AddDays(-1)) >= 0; //file written in past day?
        }

        private static void CreateFolderAndCopy(FileInfo fileInfo, string tvFolder)
        {
            if (IsEligible(fileInfo))
            {
                string fileName = Path.GetFileName(fileInfo.FullName);
                string folder = GetTitle(fileName);
                string targetFolder = string.Format("{0}\\{1}", tvFolder, folder);
                string targetFileName = string.Format("{0}\\{1}", targetFolder, fileName);

                string message = string.Empty;
                try
                {
                    message = string.Format("Copied {0} to {1}.", Path.GetFileName(fileInfo.FullName), targetFileName);
                    Directory.CreateDirectory(targetFolder);
                    fileInfo.CopyTo(targetFileName);
                }
                catch (Exception ex)
                {
                    message = ex.Message;

                    LogError(fileInfo, message);
                }
                finally
                {
                    Console.WriteLine(message);
                }
            }
        }

        private static string FindTarget(string file, string directory)
        {
            string target = string.Empty;

            DirectoryInfo[] directories = GetDirectories(file, directory);

            if (directories.Length == 1)
            {
                target = directories[0].FullName + Path.DirectorySeparatorChar + file;
            }

            return target;
        }

        private static DirectoryInfo[] GetDirectories(string file, string directory)
        {
            DirectoryInfo directoryInfo = new DirectoryInfo(directory);
            string title = GetTitle(file);

            DirectoryInfo[] directories = directoryInfo.GetDirectories("*" + title + "*", SearchOption.TopDirectoryOnly);

            return directories;
        }

        private static string GetTitle(string file)
        {
            Regex regex = new Regex("S\\d\\dE\\d\\d", RegexOptions.IgnoreCase);
            string[] phrases = regex.Split(file, 2);

            if (phrases.Length == 1)
            {
                regex = new Regex("\\d\\d\\d\\d\\.?\\d\\d\\.?\\d\\d", RegexOptions.IgnoreCase);
                phrases = regex.Split(file, 2);
            }

            return phrases[0].Replace('.', ' ').Trim();
        }
    }
}
