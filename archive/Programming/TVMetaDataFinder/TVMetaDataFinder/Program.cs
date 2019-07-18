using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace TVMetaDataFinder
{
    static class Program
    {
        public static bool WebThreadDone = false;
        public static DateTime DateTimeStopTimer { get; set; }
        public static DateTime DateTimeStartTimer { get; set; }
        public static string AppendToLog { get; set; }
        public static int FileFormatRenameSelectedIndex { get; set; }


        public static void AddToLog(string text)
        {
            Program.AppendToLog = DateTime.Now + ":  " + text + "\r\n" + Program.AppendToLog;

            Application.DoEvents();
        }

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Program.AppendToLog = string.Empty;
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new frmMain());
        }
    }
}
