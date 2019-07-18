using System.IO;

namespace BingRewards
{
    public class LogFile
    {
        private static StreamWriter _writer;

        public static void Open()
        {
            if (_writer == null)
            {
                _writer = new StreamWriter(".\\bingSearchResults.log", true);
            }
        }

        public static void Log(string message)
        {
            if (_writer == null)
            {
                Open();
            }

            if (_writer != null)
            {
                _writer.WriteLine(message);
            }
        }

        public static void Close()
        {
            if (_writer != null)
            {
                _writer.Close();
                _writer = null;
            }
        }
    }
}
