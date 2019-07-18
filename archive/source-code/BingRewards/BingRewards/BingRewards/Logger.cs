using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace BingRewards
{
    public class Logger
    {
        private Logger()
        {

        }

        private static Logger _logger = null;

        public bool IsVerbose { get; set; }

        public static Logger Instance
        {
            get
            {
                return _logger ?? (_logger = new Logger { IsVerbose = false });
            }
        }

        public void LogMethodStart([CallerMemberName] string callerMemberName = "")
        {
            if (!string.IsNullOrEmpty(callerMemberName) && IsVerbose)
            {
                Console.WriteLine("Method Start: {0}", callerMemberName);
            }
        }

        public void Log(Exception exception)
        {
            string message = string.Format("Type: {0} Message: {1}", exception.GetType(), exception.Message);
            
            Log(message, ConsoleColor.DarkRed);

            LogFile.Open();
            LogFile.Log(message);
            LogFile.Close();
        }

        public void Log(string message, ConsoleColor messageColor)
        {
            ConsoleColor previousColor = Console.ForegroundColor;
            Console.ForegroundColor = messageColor;
            Log(message);
            Console.ForegroundColor = previousColor;
        }

        public void Log(string message)
        {
            Console.WriteLine(message);
        }

    }
}
