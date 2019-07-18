using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace File_Renamer
{
    public class ListStorage
    {
        public static void SaveList(List<string> stringList, string fileName)
        {
            TextWriter writer = new StreamWriter(fileName);

            stringList.ForEach(writer.WriteLine);

            writer.Close();
        }
    }
}
