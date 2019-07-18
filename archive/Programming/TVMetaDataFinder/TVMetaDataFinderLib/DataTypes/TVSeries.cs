using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;

namespace TVMetaDataFinder.DataTypes
{
    public static class TVSeriesIO
    {

        public static TVSeriesItem _GetDataFromXML(string fileName)
        {
            TVSeriesItem tvSeriesItem = new TVSeriesItem();

            return tvSeriesItem;
        }

        public static void SaveSeriesXML(TVSeriesItem tvSeriesItem, String fileName)
        {
            try
            {
                XmlSerializer xs = new XmlSerializer(typeof(TVSeriesItem));

                using (TextWriter tw = new StreamWriter(fileName))
                {

                    xs.Serialize(tw, tvSeriesItem);

                    tw.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }


    [XmlRoot("Series")]
    public partial class TVSeriesItem
    {
        public string id { get; set; }
        public string SeriesName { get; set; }
        public string SeriesID { get; set; }
        public string Status { get; set; }
        public string FirstAired { get; set; }
        public string Network { get; set; }
        public string Runtime { get; set; }
        public string Genre { get; set; }
        public string Actors { get; set; }
        public string Overview { get; set; }
        public string Banner { get; set; }
        public string lastupdated { get; set; }
        public string Airs_DayOfWeek { get; set; }
        public string Airs_Time { get; set; }
        public string Rating { get; set; }
        public string flagged { get; set; }
        public string forceupdate { get; set; }
        public string hits { get; set; }
        public string updateID { get; set; }
        public string requestcomment { get; set; }
        public string locked { get; set; }
        public string mirrorupdate { get; set; }
        public string lockedby { get; set; }
        public string autoimport { get; set; }
        public string disabled { get; set; }
        public string IMDB_ID { get; set; }
        public string zap2it_id { get; set; }
        public string MatchValue { get; set; }
        public string SortName { get; set; }
        public string EpisodeOrders { get; set; }
        public string Fanart { get; set; }
        public string Poster { get; set; }

        // [XmlIgnore()]
        public List<TVSeasonInfo> SeasonData { get; set; }

        public TVSeriesItem()
        {
            this.SeasonData = new List<TVSeasonInfo>();
        }

    }

    public partial class TVSeasonInfo
    {
        public int SeasonNumber { get; set; }
        public string SeasonPath { get; set; }
        public List<TVEpisode> Epesodes { get; set; }

        public TVSeasonInfo()
        {
            this.Epesodes = new List<TVEpisode>();
        }

        public TVSeasonInfo(int seasonNumber)
        {
            this.SeasonNumber = seasonNumber;
            this.Epesodes = new List<TVEpisode>();
        }

        public TVSeasonInfo(int seasonNumber, string seasonPath)
        {
            this.SeasonNumber = seasonNumber;
            this.SeasonPath = seasonPath;
            this.Epesodes = new List<TVEpisode>();
        }

    }

    public partial class TVEpisode
    {
        public int EpisodeNumber { get; set; }
        public string EpisodeFileNameOnly { get; set; }
        public string EpisodeName { get; set; }
        public string EpisodePath { get; set; }
        public TVShowEpisodeItem TVShowEpisode { get; set; }
        public TVEpisode()
        {
            TVShowEpisode = new TVShowEpisodeItem();
        }
    }
}