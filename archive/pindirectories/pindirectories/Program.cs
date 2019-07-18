using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace pindirectories
{
    class Program
    {
        private static readonly List<string> Directories = new List<string>{"01", "02", "03", "04", "05", "06", "07", "08", "09", "10"};
        private const int MAX_LEVEL = 4;

        static void Main(string[] args)
        {
            const int level = 1;
            const string sourcePath = "V:\\tv - Archive\\Various";

            CreateDirectories(sourcePath, level);

        }

        private static void CreateDirectories(string sourcePath, int level)
        {
            foreach (string dir in Directories)
            {
                Console.WriteLine("Creating: " + sourcePath + "\\" + dir);
                Directory.CreateDirectory(sourcePath + "\\" + dir);
                if (level < MAX_LEVEL)
                {
                    CreateDirectories(sourcePath + "\\" + dir, level + 1);
                }            
            }
        }
    }
}
