using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Threading;
using System.Net.Cache;

namespace TVMetaDataFinder.Helpers
{
    public partial class SaveImageFromWeb
    {
        public static void WriteBytesToFile(string fileName, string url)
        {
            try
            {
                using (WebClient wc = new WebClient())
                {
                    RequestCachePolicy policy = new RequestCachePolicy(RequestCacheLevel.CacheIfAvailable);
                    
                    wc.CachePolicy = policy;
                    if (Directory.Exists(Path.GetDirectoryName(fileName)))
                    {
                        wc.DownloadFile(url, fileName);
                    }
                }
            }
            catch { }
        }
    }
}
