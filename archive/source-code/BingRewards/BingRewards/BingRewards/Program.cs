
using System;

namespace BingRewards
{
    class Program
    {
        const string SLOW = "-slow";
        const string VERBOSE = "-verbose";
        const string START_AT = "-start-at";
        const string NO_PAUSE = "-no-pause";

        static void Main(string[] args)
        {
            int startAt = 0;
            bool slow = IsArgFound(args, SLOW);
            bool verboseLogging = IsArgFound(args, VERBOSE);

            if (IsArgFound(args, START_AT))
            {
                startAt = GetUserNumber(args);
            }

            BingSearch.Process(slow, verboseLogging, startAt);

            if (!IsArgFound(args, NO_PAUSE))
            {
                Console.WriteLine(Environment.NewLine + "Hit any key to continue....");
                Console.ReadKey();
            }
        }

        private static int GetUserNumber(string[] args)
        {
            int userNumber = 0;
            bool userTokenIsNext = false;

            foreach (string arg in args)
            {
                if (userTokenIsNext)
                {
                    Int32.TryParse(arg, out userNumber);
                    break;
                }

                if (string.Compare(arg, START_AT, true) == 0)
                {
                    userTokenIsNext = true;
                }
            }

            return userNumber;
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
    }
}
