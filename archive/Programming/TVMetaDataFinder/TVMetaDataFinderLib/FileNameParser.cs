using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;
using TVMetaDataFinder.DataTypes;

namespace TVMetaDataFinder
{
    public class FileNameParser
    {
        public string DropFolder { get; set; }
        public string ShowFolder { get; set; }
        public List<Regex> TVShowRegx { get; set; }
        
        public Dictionary<string,string> TVShowNameReplacers { get; set; }

        public string Show { get; set; }
        public int SeasonNo { get; set; }
        public string EpName { get; set; }
        public int EpNo { get; set; }

        public string Outcome { get; set; }

        /// <summary>
        /// used to parse filenames from a import folder, expects names like :
        ///     show.s01e01
        ///     show.1x1
        ///     show.101
        /// </summary>
        public FileNameParser()
        {
            TVShowNameReplacers = new Dictionary<string, string>();
            TVShowRegx = new List<Regex>();
        }

        public bool ExtractDetails(string filename)
        {
            if (!Directory.Exists(DropFolder)) throw new Exception(string.Format("Drop folder not found {0}", DropFolder));
            if (!Directory.Exists(ShowFolder)) throw new Exception(string.Format("Drop folder not found {0}", ShowFolder));

            Show = "";
            return matchFile(filename);

        }

        private bool matchFile(string file)
        {
            foreach (var match in TVShowRegx)
            {
                if (match.IsMatch(file))
                {
                    var myMatch = match.Match(file);

                    Show  = file.Substring(0, myMatch.Index);
                    SeasonNo = int.Parse(myMatch.Groups[1].Value);
                    EpNo  = int.Parse(myMatch.Groups[2].Value);
                    Show  = tidyShowName(Show );
                    Outcome = string.Format("Matched : \"{2}\" {3}x{4:00} - file {0} match {1} ", file, match.ToString(), Show , SeasonNo, EpNo );
                    if (string.IsNullOrEmpty(Show)) return false;
                    return true;
                }
            }
            return false;
        }

        private string tidyShowName(string show)
        {
            // this could be done better...
            show = show.Replace(".", " ").Trim();
            show = show.Replace("_", " ");
            show = adjustShowName(show);
            if (string.IsNullOrEmpty(show))
            {
                Outcome = string.Format("Could not find show on theTVDB {0}", show);
            }
            return show;
        }
        private string adjustShowName(string show)
        {
            // lets run the REGEX agaist the show name
            show = runRegExAgaistShow(show);
            // lets see if we can find the Folder, this saves a call the thetvdv            
            show = lookupBothDirAndTVDB(show);
            if (string.IsNullOrEmpty(show)) return null;
            return show.Replace(":"," ");
        }

        private string runRegExAgaistShow(string show)
        {
            if (TVShowNameReplacers == null) return show;

            foreach (var item in this.TVShowNameReplacers)
            {
                if (Regex.IsMatch(show, item.Key, RegexOptions.IgnoreCase))
                {
                    show = Regex.Replace(show, item.Key, item.Value, RegexOptions.IgnoreCase);
                }
            }
            return show;
        }
        private string lookupBothDirAndTVDB(string show)
        {
            string regs = "[^\\w\\.@-]";

            var showSimple = Regex.Replace(show, regs, "");

            var showsLike = from f in Directory.GetDirectories(ShowFolder)
                            let file = new FileInfo(f).Name
                            let simplefile = Regex.Replace(file, regs, "") // this is a minor perf issue
                            where simplefile.Equals(showSimple, StringComparison.InvariantCultureIgnoreCase)
                            select file;

            var rval = showsLike.FirstOrDefault();
            if (!string.IsNullOrEmpty(rval)) return rval;

            // make sure its on TVDB
            var showMetaData = TheTVDBData.GetDataFromXML("http://www.thetvdb.com/api/GetSeries.php?seriesname=" + show);
            System.Diagnostics.Trace.WriteLine(showMetaData.SeriesDetail.Status);

            // lets compare the RAW values, eg change (yyyy) to yyyy and remove any - or other chars

            if (showMetaData == null || string.IsNullOrEmpty( showMetaData.SeriesDetail.SeriesName )) return null;

            var lookupSimple = Regex.Replace(showMetaData.SeriesDetail.SeriesName,regs , "");
            //showSimple = Regex.Replace(showSimple, "  ", " ");
            //lookupSimple = Regex.Replace(lookupSimple, "  ", " ");

            if (!showSimple.Equals(lookupSimple,StringComparison.InvariantCultureIgnoreCase ))
            {

                // we did not get an 100% match, lets hope we got the correct one
                // if we end in a YEAR then we could have got an OLD version                
                if (Regex.Match(showMetaData.SeriesDetail.SeriesName, "([0-9][0-9][0-9][0-9])").Success)
                {
                    var year = Regex.Match(showMetaData.SeriesDetail.SeriesName, "([0-9][0-9][0-9][0-9])").Value;                    
                    
                    // lets just see if we have a folder, this is crude 
                    // TODO improve
                    var showsLikeWithYear = from f in Directory.GetDirectories(ShowFolder)
                                    let file = new FileInfo(f).Name
                                    let filenoyear = Regex.Replace(file,"([0-9][0-9][0-9][0-9])","")
                                    let simplefile = Regex.Replace(filenoyear, regs, "") // this is a minor perf issue
                                    
                                    where simplefile.Equals(showSimple, StringComparison.InvariantCultureIgnoreCase)
                                    select file;

                    rval = showsLikeWithYear.FirstOrDefault();
                    if (!string.IsNullOrEmpty(rval)) return rval;
                }
                // No year, let it go back as is, drop through
            }
            return showMetaData.SeriesDetail.SeriesName;
        }
    }
}
