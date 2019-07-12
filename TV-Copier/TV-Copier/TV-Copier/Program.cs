
using System;

namespace TV_Copier
{
    class Program
    {
        static int Main(string[] args)
        {
            ////begin debug
            //// single file
            //args = new string[3];
            //args[0] = "N:\\_Unsorted-TV";
            //args[1] = "Robot.Chicken.S04.Special.Star.Wars.Episode.III.HDTV.XviD-2HD.avi";
            //args[2] = "Robot.Chicken.S04.Special.Star.Wars.Episode.III.HDTV.XviD-2HD.avi";
            //// multi file
            //args = new string[2];
            //args[0] = "N:\\_Unsorted-TV\\Chuck - Season 1 (720p .mkv) [TvT]";
            //args[1] = "Chuck - Season 1 (720p .mkv) [TvT]";
            ////end debug

            if (args != null)
            {
                FileProcessor.Process(args);

                //FileProcessor.ProcessMovies();
            }

            return 0;
        }
    }
}
