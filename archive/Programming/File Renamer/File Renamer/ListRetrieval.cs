using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace File_Renamer
{
    public class ListRetrieval
    {
        public static List<string> LoadList(string fileName)
        {
            List<string> list = new List<string>();
            TextReader reader = new StreamReader(fileName);
            string line;

            do
            {
                line = reader.ReadLine();

                if (string.IsNullOrEmpty(line)) continue;

                list.Add(line);
            } while (!string.IsNullOrEmpty(line));

            reader.Close();

            return list;
        }
    }
}
