
using System;
using System.IO;
using System.Windows.Forms;

namespace MediaCounts
{
    class Program
    {
		private static bool _verbose = false;
		private const string VERBOSE = "-v";
		
        static int Main(string[] args)
        {
            //debug start
			
			//args = new string[3];
			//args[0] = "/home/username/Videos/TV";
			//args[1] = "true";
			//args[2] = "-v";
			
			//debug end
			
			if (args != null && args.Length >= 1 && args.Length <= 3)
            {
                try
                {
					string path = string.Empty;
					bool? removeCounts = null;
					
					if (!string.IsNullOrEmpty(args[0]))
					{
						path = args[0];
						DirectoryInfo pathInfo = new DirectoryInfo(path);
						
						if (!pathInfo.Exists)
						{
							DisplayUsage();
						}
					}
					else
					{
						DisplayUsage();	
					}
					
					if ((args.Length == 2 && !string.IsNullOrEmpty(args[1]) && args[1] == VERBOSE) 
							|| (args.Length == 3 && !string.IsNullOrEmpty(args[2]) && args[2] == VERBOSE))
					{
						_verbose = true;
					}
					
            		if (args.Length >= 2 && !string.IsNullOrEmpty(args[1]) && args[1] != VERBOSE)
					{
						string behavior = "updating";
						
						removeCounts = Convert.ToBoolean(args[1]);
												
						if (removeCounts.HasValue && removeCounts.Value)
						{
							behavior = "removing";
						}
						
						DisplayStatus("Processing directory and " + behavior + " counts.");						
                    	Processor.UpdateDirectoryCounts(path, removeCounts ?? false, _verbose);
					}
					
					if (removeCounts == null)
					{						
						DisplayStatus("Making first pass which removes counts and combines folders.");						
	                    Processor.UpdateDirectoryCounts(path, true, _verbose);
						
						DisplayStatus("Making second pass which adds counts back.");						
	                    Processor.UpdateDirectoryCounts(path, false, _verbose);
					}
                }
                catch(Exception ex)
                {
					DisplayStatus(ex.Message);
                }
            }
			else
			{
				DisplayUsage ();
			}

            return 0;
        }
		
		public static void DisplayStatus(string status)
		{
			if (_verbose)
			{
				Console.WriteLine(status);
			}
		}

		private static void DisplayUsage ()
		{
        	Console.WriteLine("USAGE: ./MediaCounts.exe 'target directory' [true] [-v]");
        	Console.WriteLine("");
			Console.WriteLine("Specify the target directory and whether or not to remove the counts. '-v' indicates verbose mode.");
			Console.WriteLine("If you to not specify the remove count option, the program will preserve counts and combine folders.");
        	Console.WriteLine("");
        	Console.WriteLine("FOLDERS WITH NO MEDIA WILL BE REMOVED.  BE CAREFUL.");
			
			Application.Exit();
		}
    }
}
