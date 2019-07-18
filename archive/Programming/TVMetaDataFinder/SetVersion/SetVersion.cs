using System;
using System.IO;
using System.Text;

namespace SetVersion
{
    /// <summary>
    /// Summary description for Class1.
    /// </summary>
    class SetVersion
    {
        private static bool increaseBuild = false;

        private static string assemblyFileName = "";

        private static string versionStr = null;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            for (int i = 0; i < args.Length; i++)
            {
                if (args[i] == "-incbuild")
                    increaseBuild = true;
                else if (args[i].StartsWith("-setver:"))
                {
                    versionStr = args[i].Substring("-setver:".Length);
                }
                else
                    assemblyFileName = args[i];
            }

            if (assemblyFileName == "")
            {
                System.Console.WriteLine("Usage: AssemblyInfoUtil <path to AssemblyInfo.cs file> [options]");
                System.Console.WriteLine("Options: ");
                System.Console.WriteLine("  -setver:<version number>    - set new version number (in NN.NN.NN.NN format)");
                System.Console.WriteLine("  -incbuild                   - increases build number");
                System.Console.WriteLine("");
                System.Console.WriteLine("Refrence: http://www.codeproject.com/KB/cs/AssemblyInfoUtils.aspx");
                return;
            }

            if (!File.Exists(assemblyFileName))
            {
                System.Console.WriteLine("Error: Can not find file \"" + assemblyFileName + "\"");
                return;
            }

            System.Console.Write("Processing \"" + assemblyFileName + "\"...");
            StreamReader reader = new StreamReader(assemblyFileName);
            StreamWriter writer = new StreamWriter(assemblyFileName + ".out");
            String line;

            while ((line = reader.ReadLine()) != null)
            {
                line = ProcessLine(line);
                writer.WriteLine(line);
            }
            reader.Close();
            writer.Close();

            File.Delete(assemblyFileName);
            File.Move(assemblyFileName + ".out", assemblyFileName);
            System.Console.WriteLine("Done!");
        }


        private static string ProcessLine(string line)
        {
            line = ProcessLinePart(line, "[assembly: AssemblyVersion(\"");
            line = ProcessLinePart(line, "[assembly: AssemblyFileVersion(\"");
            return line;
        }

        private static string ProcessLinePart(string line, string part)
        {
            int spos = line.IndexOf(part);
            if (spos >= 0)
            {
                spos += part.Length;
                int epos = line.IndexOf('"', spos);
                string oldVersion = line.Substring(spos, epos - spos);
                string newVersion = "";
                bool performChange = false;

                if (increaseBuild)
                {
                    string[] nums = oldVersion.Split('.');
                    if (nums.Length > 3 && nums[3] != "*")
                    {
                        Int64 buildNum = Int64.Parse(nums[3]);
                        buildNum++;
                        newVersion = nums[0] + "." + nums[1] + "." + nums[2] + "." + buildNum;
                        performChange = true;
                    }

                }
                else if (versionStr != null)
                {
                    newVersion = versionStr;
                    performChange = true;
                }

                if (performChange)
                {
                    StringBuilder str = new StringBuilder(line);
                    str.Remove(spos, epos - spos);
                    str.Insert(spos, newVersion);
                    line = str.ToString();
                }
            }
            return line;
        }
    }
}
