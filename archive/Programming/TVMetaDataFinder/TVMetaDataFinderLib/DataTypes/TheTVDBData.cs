using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.Net;
using System.Xml;
using System.Net.Cache;

namespace TVMetaDataFinder.DataTypes
{
    [XmlRoot("Data")]
    public  class TheTVDBData
    {
        [XmlIgnore()]
        public string SeasonPath { get; set; }

        [XmlElement("Series")]
        public TVShowSeries SeriesDetail { get; set; }

        [XmlElement("Episode")]
        public List<TVShowEpisode> Episodes { get; set; }

        /// <summary>
        /// Stores the Series Data
        /// </summary>
        [XmlRoot("Series")]
        public  class TVShowSeries
        {
            public string id { get; set; }
            public string Actors { get; set; }
            public string Airs_DayOfWeek { get; set; }
            public string Airs_Time { get; set; }
            public string ContentRating { get; set; }
            public string FirstAired { get; set; }
            public string Genre { get; set; }
            public string IMDB_ID { get; set; }
            public string Language { get; set; }
            public string Network { get; set; }
            public string Overview { get; set; }
            public string Rating { get; set; }
            public string Runtime { get; set; }
            public string SeriesID { get; set; }
            public string SeriesName { get; set; }
            public string Status { get; set; }
            public string banner { get; set; }
            public string fanart { get; set; }
            public string lastupdated { get; set; }
            public string poster { get; set; }
            public string zap2it_id { get; set; }

        }

        /// <summary>
        /// Stores the Episode data
        /// </summary>
        [XmlRoot("Episode")]
        public partial class TVShowEpisode
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
        }

        /// <summary>
        /// Public Constructor
        /// </summary>
        public TheTVDBData()
        {
            SeriesDetail = new TVShowSeries();
            Episodes = new List<TVShowEpisode>();
        }


        /// <summary>
        /// Used to write the XML file
        /// </summary>
        /// <param name="data"></param>
        /// <param name="fileName"></param>
        public static void SaveDataXML(TVSeriesItem data, String fileName)
        {
            try
            {
                XmlSerializer xs = new XmlSerializer(typeof(TVSeriesItem));

                using (TextWriter tw = new StreamWriter(fileName))
                {

                    xs.Serialize(tw, data);

                    tw.Close();
                }
            }
            catch (Exception ex)
            {
//                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Used to get the deserialize the XML Contents from a 
        /// memory stream byte[] to memory
        /// </summary>
        /// <param name="FileName"></param>
        /// <returns></returns>
        public static TheTVDBData GetDataFromXML(string FileName)
        {
            XmlSerializer xs = new XmlSerializer(typeof(TheTVDBData));
            try
            {
                TheTVDBData data = null;
                using (TextReader tr = new StreamReader(new MemoryStream(GetXMLDataFromFile(FileName))))
                {
                    data = (TheTVDBData)xs.Deserialize(tr);
                    tr.Close();
                }
                return data;
            }
            catch { }
            return null;
        }

        /// <summary>
        /// Used to get the XML Data in Bytes from the web page
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static byte[] GetXMLDataFromFile(string fileName)
        {
            try
            {
                byte[] response = null;
                response = ASCIIEncoding.Default.GetBytes(readHtmlPage(fileName));
                return response;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Helper Method to read contents of a web page, in this case it is
        /// used to read the XML from the web page
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        private static string readHtmlPage(string url)
        {
            try
            {
                using (WebClient wc = new WebClient())
                {
                    RequestCachePolicy policy;
                    if (url.Contains("GetSeries.php?seriesname"))
                    {
                        policy = new RequestCachePolicy(RequestCacheLevel.CacheIfAvailable );
                    }
                    else
                    {
                        policy = new RequestCachePolicy(RequestCacheLevel.Revalidate);
                    }
                    wc.CachePolicy = policy;

                    return wc.DownloadString(url);
                }
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Used to extract a string from an XML memory stream
        /// </summary>
        /// <param name="xmlData"></param>
        /// <param name="field"></param>
        /// <returns></returns>
        [Obsolete("Use GetDataFromXML(...)")]
        public static string ExtractFromXML(byte[] xmlData, string field)
        {
            try
            {
                // Read a document
                using (MemoryStream ms = new MemoryStream(xmlData))
                {
                    XmlTextReader textReader = new XmlTextReader(ms);

                    // Read until end of file
                    while (textReader.Read())
                    {
                        XmlNodeType nType = textReader.NodeType;
                        if (nType == XmlNodeType.Element)
                        {
                            if (textReader.Name.ToString() == field)
                            {
                                try
                                {
                                    textReader.Read();
                                }
                                catch { }
                                return textReader.Value.ToString();
                            }
                        }
                    }
                }
            }
            catch { }
            return null;
        }
    }
}
