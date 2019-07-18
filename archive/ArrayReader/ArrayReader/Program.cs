using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace ArrayReader
{
    class Program
    {
        static void Main(string[] args)
        {
            string arrayIni = File.ReadAllText("array.ini");
            string[] arrayLines = arrayIni.Split(new char[] { '\r', '\n' });
            //List<string> newLines = new List<string>();

            using (StreamWriter file = new StreamWriter("formattedArray.txt"))
            {
                foreach (var line in arrayLines)
                {
                    string newLine = line.Replace("|", ",");
                    //newLines.Add(newLine);
                    file.WriteLine(newLine);
                }

                //   File.WriteAllText("array.ini", newLines.ToArray());
            }
        }


        //array loader action script:
        /*
    var _loc5 = dat.split("\r\n");
    if (_loc5.length == 1)
    {
        _loc5 = dat.split("\n");
    } // end if
    var _loc6 = _loc5.length;
    for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
    {
        var _loc3 = _loc5[_loc2].split("|");
        array_list[_loc2] = new Array();
        array_list[_loc2].template = _loc3[0];
        var _loc4 = templates_arr[_loc3[0]].length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            array_list[_loc2][templates_arr[_loc3[0]][_loc1]] = _loc3[_loc1 + 1];
        } // end of for
    } // end of for
    show_load_status();
    load_stat = load_stat + ("Array.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
*/
    }
}
