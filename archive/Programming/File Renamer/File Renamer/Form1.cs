using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;

namespace File_Renamer
{
    public partial class Form1 : Form
    {
        private const string DELETE_LIST = "delete-list.txt";
        private const string REPLACE_LIST = "replace-list.txt";
        private bool IsCommandLineSession;

        public Form1()
            : this(null)
        {
        }

        public Form1(string[] args)
        {
            InitializeComponent();
            
            if (args != null && args.Length > 0)
            {
                if (args[0] == "-process")
                {
                    IsCommandLineSession = true;
                }
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            PopulateDeleteList(ListRetrieval.LoadList(DELETE_LIST));
            PopulateReplaceLists(ListRetrieval.LoadList(REPLACE_LIST));

            if (IsCommandLineSession)
            {
                ProcessFiles();
                Application.Exit();               
            }
        }

        private void PopulateDeleteList(List<string> deleteList)
        {
            deleteList.ForEach(x => RemoveText.Text += x + Environment.NewLine);
        }

        private void PopulateReplaceLists(List<string> replaceList)
        {
            replaceList.ForEach(x =>
                {
                    string[] tokens = x.Split('|');
                    FromText.Text += string.Format("{0}{1}", tokens[0], Environment.NewLine);
                    ToText.Text += string.Format("{0}{1}", tokens[1], Environment.NewLine);
                });
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            SaveDeleteList();
            SaveReplaceList();
        }

        private void SaveReplaceList()
        {
            ListStorage.SaveList(GetReplaceList(), REPLACE_LIST);
        }

        private List<string> GetReplaceList()
        {
            string[] fromList = TextBoxToArray(FromText);
            string[] toList = TextBoxToArray(ToText);
            List<string> replaceList = new List<string>();

            for (int index = 0; index < fromList.Count(); index++)
            {
                replaceList.Add(string.Format("{0}|{1}", fromList[index], toList[index]));
            }
            return replaceList;
        }

        private void SaveDeleteList()
        {
            ListStorage.SaveList(GetDeleteList(), DELETE_LIST);
        }

        private List<string> GetDeleteList()
        {
            return TextBoxToList(RemoveText);
        }

        private static List<string> TextBoxToList(TextBox box)
        {
            char[] splitParam = new[] { '\r', '\n' };
            return box.Text.Split(splitParam).Where(item => !string.IsNullOrEmpty(item)).ToList();
        }

        private static string[] TextBoxToArray(TextBox box)
        {
            return TextBoxToList(box).ToArray();
        }

        private void ProcessNames_Click(object sender, EventArgs e)
        {
            ProcessFiles();
        }

        private void ProcessFiles()
        {
            string path = Application.StartupPath;
            List<string> toDelete = GetDeleteList();
            List<string> toReplace = GetReplaceList();
            List<string> filesToRename = new List<string>();

            Cursor = Cursors.WaitCursor;

            DirectoryInfo directoryInfo = new DirectoryInfo(path);
            FileInfo[] files = directoryInfo.GetFiles("*.avi", SearchOption.AllDirectories);

            foreach (FileInfo fileInfo in files)
            {
                filesToRename.Add(fileInfo.FullName);
            }

            RenameFiles(toDelete, toReplace, filesToRename);

            Cursor = Cursors.Arrow;
        }

        private static void RenameFiles(List<string> toDelete, List<string> toReplace, List<string> filesToRename)
        {
            filesToRename.ForEach(x =>
                                      {
                                          string path = Path.GetDirectoryName(x);
                                          string file = Path.GetFileName(x).ToLower();

                                          TemporaryWork(path, file);
                                          //toDelete.ForEach(y => file = file.Replace(y.ToLower(), string.Empty));
                                          //file = ReplaceTokens(toReplace, file);
                                          //file = SetInitialCaps(file);
                                          //file = FixExtension(file);
                                          //file = string.Format("{0}{1}{2}", path, Path.DirectorySeparatorChar, file);

                                          //if (x.CompareTo(file) != 0)
                                          //{
                                          //    try
                                          //    {
                                          //    if (File.Exists(file))
                                          //    {
                                          //        if (File.Exists(x))
                                          //        {
                                          //            File.Delete(x);
                                          //        }
                                          //    }
                                          //    else
                                          //    {
                                          //         File.Move(x, file);
                                          //    }
                                          //    }
                                          //    catch (IOException)
                                          //    {
                                          //        //todo: add logging
                                          //    }
                                          //}
                                      });
        }

        private static void TemporaryWork(string path, string file)
        {
            //get folder name
            //string currentFolder = path.Substring(Path.GetDirectoryName(path).Length + 1);
            //string shorterPath = path.Replace("\\" + currentFolder, string.Empty);
            //string parentFolder = shorterPath.Substring(Path.GetDirectoryName(shorterPath).Length + 1);

            //if (currentFolder.ToLower().Contains("season"))
            //{
            //    File.Move(path + "\\" + file, "v:\\TV - Kids\\" + parentFolder + " " + file);
            //}
            //else
            //{
            //    File.Move(path + "\\" + file, "v:\\TV - Kids\\" + currentFolder + " " + file);
            //}
        }

        private static string ReplaceTokens(List<string> toReplace, string file)
        {
            toReplace.ForEach(x =>
                                  {
                                      string[] tokens = x.Split('|');

                                      file = file.Replace(tokens[0].ToLower(), tokens[1]);
                                  });

            return file;
        }

        private static string FixExtension(string file)
        {
            if (file.ToLower().EndsWith(" avi"))
            {
                file = file.Remove(file.Length - 4);
                file += ".avi";
            }
            return file;
        }

        private static string SetInitialCaps(string name)
        {
            string pattern = @"\w+";
            return Regex.Replace(name, pattern,
                  new MatchEvaluator(CapText));


        }

        private static string CapText(Match m)
        {
            // get the matched string
            string x = m.ToString();
            // if the first char is lower case
            if (char.IsLower(x[0]))
                // capitalize it
                return char.ToUpper(x[0]) + x.Substring(1, x.Length - 1);
            return x;
        }

    }
}
