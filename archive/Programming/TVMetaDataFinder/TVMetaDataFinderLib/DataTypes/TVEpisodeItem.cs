using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;

namespace TVMetaDataFinder.DataTypes
{
    /// <summary>
    /// Stores the Episode data
    /// </summary>
    [XmlRoot("Item")]
    public partial class TVShowEpisodeItem
    {
        public string id { get; set; }
        public string Combined_episodenumber { get; set; }
        public string Combined_season { get; set; }
        public string DVD_chapter { get; set; }
        public string DVD_discid { get; set; }
        public string DVD_episodenumber { get; set; }
        public string DVD_season { get; set; }
        public string Director { get; set; }
        public string EpImgFlag { get; set; }
        public string EpisodeName { get; set; }
        public string EpisodeNumber { get; set; }
        public string FirstAired { get; set; }
        public string GuestStars { get; set; }
        public string IMDB_ID { get; set; }
        public string Language { get; set; }
        public string Overview { get; set; }
        public string ProductionCode { get; set; }
        public string Rating { get; set; }
        public string SeasonNumber { get; set; }
        public string absolute_number { get; set; }
        public string airsafter_season { get; set; }
        public string airsbefore_episode { get; set; }
        public string airsbefore_season { get; set; }
        public string filename { get; set; }
        public string lastupdated { get; set; }
        public string seasonid { get; set; }
        public string seriesid { get; set; }

        public TVShowEpisodeItem()
        {

        }
    }

    public class EpisodeItemIO
    {
        /// <summary>
        /// Used to write the XML file
        /// </summary>
        /// <param name="data"></param>
        /// <param name="fileName"></param>
        public static void SaveDataXML(TVShowEpisodeItem data, String fileName)
        {
            try
            {
                XmlSerializer xs = new XmlSerializer(typeof(TVShowEpisodeItem));

                using (TextWriter tw = new StreamWriter(fileName))
                {

                    xs.Serialize(tw, data);

                    tw.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
