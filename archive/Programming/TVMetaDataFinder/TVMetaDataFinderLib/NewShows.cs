using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using TVMetaDataFinder.DataTypes;
using System.Text.RegularExpressions;
using System.Globalization;
using TVMetaDataFinder;

namespace TVMetaDataFinderLib
{

    public class NewShowInfoList : List<NewShowInfo>
    {
        public NewShowInfo Lookup(string show)
        {
            return this.Where((s) => s.ShowName == show).FirstOrDefault();            
        }
    }
    public class NewShowInfo
    {
        public string ShowName { get; set; }

        public DateTime  NextSuggetionAired { get; set; }
        public string AirsIn
        {
            get
            {
                if (NextSuggetionAired.Date == DateTime.MinValue) return "Nothing";
                var ts = NextSuggetionAired.Subtract(DateTime.Now.Date);

                if (ts.TotalDays > 14)
                {                    
                    return string.Format("{0:0} Weeks", (ts.TotalDays / 7));
                }
                if (ts.TotalDays == 1)
                {
                    return "1 Day";
                }
                if (ts.TotalDays > 1)
                {
                    return string.Format("{0} Days", ts.TotalDays);
                }
                if (ts.TotalDays == 0)
                {
                    return "Today";
                }
                if (ts.TotalDays >= -7)
                {
                    return "Its been on (this week)";
                }
                return "Its been on";
            }
        }
        public int SuggestedSeason { get; set; }
        public int SuggestedEp { get; set; }

        public int ShowID { get; set; }
    }

    public class NewShows
    {
        public string ShowFolder { get; set; }
        private string apiKey = "E837AF9EE7601DB2";
        public bool NewSeason { get; set; }

        private static string[] mediaTypes = new string[] { ".mkv", ".avi" , ".mp4"};

        public NewShowInfoList Shows;

        public NewShows()
        {
            Shows = new NewShowInfoList();
        }
        
        public void FindNewShows()
        {
            //Shows.Clear();
            Shows = new NewShowInfoList(); // better than clear is its bound to from a dif thread

            // Lets list all the shows and check for new shows
            foreach(var dir in Directory.GetDirectories( ShowFolder))
            {
                // find on theTVDB
                processShow(Path.GetFileName ( dir));                
                
            }
        }

        public void processShow(string show)
        {
            // re working
            try
            {
                var lastSeason = getLastSeason(show);
                if (lastSeason == -1) return;
                var lastEpisode = getLastEpisode(show, lastSeason);
                if (lastEpisode == -1) return;


                var showMetaData = TheTVDBData.GetDataFromXML(String.Format("http://www.thetvdb.com/api/GetSeries.php?seriesname={0}", show));
                showMetaData = TheTVDBData.GetDataFromXML(String.Format("http://www.thetvdb.com/api/{0}/series/{1}/all/", apiKey, showMetaData.SeriesDetail.id));
                if (showMetaData == null || showMetaData.SeriesDetail.id == "") return;

                // New ep?
                var nextEpisode = (from e in showMetaData.Episodes
                                   where int.Parse(e.SeasonNumber) == lastSeason && int.Parse(e.EpisodeNumber) == lastEpisode + 1
                                   select e.FirstAired).FirstOrDefault();


                if (string.IsNullOrEmpty(nextEpisode)
                    //|| DateTime.ParseExact(nextEpisode, "yyyy-MM-dd", CultureInfo.InvariantCulture) > DateTime.Now
                    )
                {
                    // no next episode, or its not been on
                    // do we have a new season
                    var nextSeason = (from e in showMetaData.Episodes
                                      where int.Parse(e.SeasonNumber) == lastSeason + 1
                                      select e.FirstAired).FirstOrDefault();


                    if (!string.IsNullOrEmpty(nextSeason)
                        // && DateTime.ParseExact(nextSeason, "yyyy-MM-dd", CultureInfo.InvariantCulture) < DateTime.Now
                        )
                    {
                        // new season has be aired
                        Shows.Add(new NewShowInfo() { ShowID = int.Parse(showMetaData.SeriesDetail.id), ShowName = show, SuggestedSeason = lastSeason + 1, SuggestedEp = 1, NextSuggetionAired = DateTime.ParseExact(nextSeason, "yyyy-MM-dd", CultureInfo.InvariantCulture) });
                        return;
                    }
                }
                else
                {
                    // ok we have a new ep
                    //if (!string.IsNullOrEmpty(nextEpisode))
                    {
                        // we have one
                        Shows.Add(new NewShowInfo() { ShowID = int.Parse(showMetaData.SeriesDetail.id), ShowName = show, SuggestedSeason = lastSeason, SuggestedEp = lastEpisode + 1, NextSuggetionAired = DateTime.ParseExact(nextEpisode, "yyyy-MM-dd", CultureInfo.InvariantCulture) });
                        return;
                    }
                }
                // looks like its not running
                Shows.Add(new NewShowInfo() { ShowID = int.Parse(showMetaData.SeriesDetail.id), ShowName = show, SuggestedSeason = 0, SuggestedEp = 0, NextSuggetionAired = DateTime.MinValue });
            }
            catch { 
                // messy 
            };
        }

        private int getLastEpisode(string show,int season)
        {
            var seasonpath = string.Format(@"{0}\Season {1}",show,season);
            var eps = Directory.GetFiles(Path.Combine(ShowFolder, seasonpath));

            var lastep = (from s in eps
                              let f = new FileInfo(s)
                              where mediaTypes.Contains(f.Extension) 
                              orderby f.Name  descending 
                              select f.Name ).FirstOrDefault();

            if (lastep == null) return -1;
            return (MetaDataFinder.GetEpisode(lastep));
            
        }

        int getLastSeason(string show)
        {
            var seasons = Directory.GetDirectories(Path.Combine(ShowFolder, show), "Season*");
            if (seasons.Length == 0) return -1;

            var lastSeason = (from s in seasons
                              let f = Path.GetFileName(s)
                             where f.StartsWith("Season")
                             orderby f descending 
                             select f).FirstOrDefault();

            if (lastSeason == null) return -1;
            return int.Parse(Regex.Match(lastSeason , @"\d+").Value);
        }
    }
}
