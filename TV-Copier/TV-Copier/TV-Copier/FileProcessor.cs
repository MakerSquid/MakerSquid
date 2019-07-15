using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;

namespace TV_Copier
{
    public static class FileProcessor
    {
        private static readonly List<string> _configs;
        private const string TV_FOLDERS = "[TVFolders]";
        private const string MOVIE_FOLDERS = "[MovieFolders]";
        private const string SHOW_NAMES = "[ShowNames]";

        static FileProcessor()
        {
            _configs = ConfigFileHandler.LoadConfiguration();
        }

        public static void Process(string[] args)
        {
            try
            {
                List<string> targetFolders = ListParser.GetSection(TV_FOLDERS, _configs);

                Console.WriteLine(args.Count() + " arguments");
                if (args.Count() > 0)
                {
                    args = StripExtraQuotes(args);

                    foreach (string item in args)
                    {
                        Console.WriteLine(item);
                    }
                }

                if (!IsArgFound(args, "skip"))
                {

                    if (IsArgFound(args, "re-copy"))
                    {
                        CopyAllFilesInADirectory("N:\\Torrents\\complete", targetFolders);
                    }

                    bool? isSingleFile = IsSingleFile(args);

                    if (isSingleFile.HasValue)
                    {
                        if (isSingleFile.Value)
                        {
                            string filename = string.Format("{0}\\{1}", args[0], args[1]);
                            FileInfo file = new FileInfo(filename);

                            ProcessAFile(file, targetFolders);
                        }
                        else
                        {
                            CopyAllFilesInADirectory(args[0], targetFolders);
                        }
                    }

                    if (IsArgFound(args, "pause"))
                    {
                        Pause();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.ToString());
                Console.WriteLine(ex.StackTrace);
                Pause();
            }
        }

        private static bool IsArgFound(string[] args, string target)
        {
            bool isFound = false;

            foreach (string arg in args)
            {
                isFound = string.Compare(arg, target, true) == 0;

                if (isFound)
                {
                    break;
                }
            }

            return isFound;
        }

        internal static void CopyAllFilesInADirectory(string source, List<string> targetFolders)
        {
            DirectoryInfo directoryInfo = new DirectoryInfo(source);
            FileInfo[] files = directoryInfo.GetFiles("*.*", SearchOption.AllDirectories);

            foreach (FileInfo fileInfo in files)
            {
                if ((fileInfo.Name.ToLower().EndsWith(".avi")) || (fileInfo.Name.ToLower().EndsWith(".mkv")))
                {
                    ProcessAFile(fileInfo, targetFolders);
                }
            }
        }

        private static string[] StripExtraQuotes(string[] input)
        {
            string[] result = new string[input.Length];

            for (int index = 0; index < input.Length; index++)
            {
                result[index] = StringUtility.RemoveExtraQuotes(input[index]);
            }

            return result;
        }

        private static void ProcessAFile(FileInfo file, List<string> targetFolders)
        {
            bool copied = false;
            Console.WriteLine("Processing: " + file.FullName);

            foreach (string targetFolder in targetFolders)
            {
                copied = AttemptToCopy(file, targetFolder);

                if (copied)
                {
                    break;
                }
            }

            if (!copied)
            {
                CreateFolderAndCopy(file, targetFolders[0]);
            }
        }

        private static bool? IsSingleFile(string[] args)
        {
            //3 arguments if it's a single file (or 4 if pause is added)
            //N:\_Unsorted-TV
            //Robot.Chicken.S04.Special.Star.Wars.Episode.III.HDTV.XviD-2HD.avi
            //Robot.Chicken.S04.Special.Star.Wars.Episode.III.HDTV.XviD-2HD.avi

            //2 arguments if it's a multi-file (or 3 if pause is added)
            //N:\_Unsorted-TV\Chuck - Season 1 (720p .mkv) [TvT]
            //Chuck - Season 1 (720p .mkv) [TvT]

            bool? isSingleFile = null;

            if (args.Length >= 2)
            {
                //using logic that ignores counts, and therefore should be accurate no matter what
                if (args[0].Contains(args[1]))
                {
                    isSingleFile = false;
                }
                else if (args[1] == args[2])
                {
                    isSingleFile = true;
                }
            }

            return isSingleFile;
        }

        private static void Pause()
        {
            Console.WriteLine("Press ENTER to continue.");
            Console.ReadLine();
        }

        public static void ProcessMovies(string path)
        {
            const string unused = MOVIE_FOLDERS;
            Debug.WriteLine(unused);

            DirectoryInfo directoryInfo = new DirectoryInfo(path);

            FileInfo[] files = directoryInfo.GetFiles("*.*", SearchOption.TopDirectoryOnly);

            foreach (FileInfo fileInfo in files)
            {
                if ((fileInfo.Name.ToLower().EndsWith(".avi"))
                        || (fileInfo.Name.ToLower().EndsWith(".mpeg"))
                        || (fileInfo.Name.ToLower().EndsWith(".dvr-ms")))
                {
                    CreateFolderAndCopy(fileInfo, path, false);
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
            return copied;
        }

        private static void CreateFolderAndCopy(FileInfo fileInfo, string tvFolder, bool copy = true)
        {
            string fileName = Path.GetFileName(fileInfo.FullName);
            string folder = GetTitle(fileName);
            string targetFolder = string.Format("{0}\\{1}", tvFolder, folder);
            string targetFileName = string.Format("{0}\\{1}", targetFolder, fileName);

            string message = string.Empty;
            try
            {
                Directory.CreateDirectory(targetFolder);
                if (copy)
                {
                    message = string.Format("Copied {0} to {1}.", Path.GetFileName(fileInfo.FullName), targetFileName);
                    fileInfo.CopyTo(targetFileName);
                }
                else
                {
                    message = string.Format("Moved {0} to {1}.", Path.GetFileName(fileInfo.FullName), targetFileName);
                    fileInfo.MoveTo(targetFileName);
                }
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

        public static string GetTitle(string file)
        {
            Regex regex = new Regex("S\\d\\dE\\d\\d", RegexOptions.IgnoreCase);
            string[] phrases = regex.Split(file, 2);

            if (phrases.Length == 1)//break on dates
            {
                regex = new Regex("\\d\\d.*\\d\\d", RegexOptions.IgnoreCase);
                phrases = regex.Split(file, 2);
            }

            if (phrases.Length == 1)//break on episode numbers like 2x03
            {
                regex = new Regex("\\d\\d?x\\d?\\d", RegexOptions.IgnoreCase);
                phrases = regex.Split(file, 2);
            }

            phrases[0] = phrases[0].Replace(".dvr-ms", "");
            phrases[0] = phrases[0].Replace(".avi", "");
            phrases[0] = phrases[0].Replace(".mpeg", "");

            string title = phrases[0].Replace('.', ' ').Trim();

            if (title.EndsWith("-"))
            {
                title = title.Substring(0, title.Length - 1).Trim();
            }

            string correctedTitle = LookupSeriesFolder(title);

            return (string.IsNullOrEmpty(correctedTitle)) ? title : correctedTitle;
        }

        private static string LookupSeriesFolder(string seriesName)
        {
            List<string> targetFolders = ListParser.GetSection(SHOW_NAMES, _configs);
            string compactName = StringUtility.StripNonAlphaNumerics(seriesName).ToLower();
            string foundName = ListParser.Get(compactName, targetFolders);

            return foundName;
        }
    }
}
