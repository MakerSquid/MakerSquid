using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.Net;
using System.Xml;
using System.Threading;

namespace TVMetaDataFinder.DataTypes
{
    [XmlRoot("Banners")]
    public partial class TheTVDBDataBanner
    {
        [XmlElement("Banner")]
        public List<Banner> Banners { get; set; }

        /// <summary>
        /// Stores the Series Data
        /// </summary>
        [XmlRoot("Banner")]
        public partial class Banner
        {
            public int id = 0; // Example Data: 28360
            public string BannerPath = string.Empty; // Example Data: fanart/original/73800-12.jpg 
            public string BannerType = string.Empty; // Example Data: fanart or season
            public string BannerType2 = string.Empty; // Example Data: 1920x1080
            public string Colors = string.Empty; // Example Data: |241,241,241|160,31,10|164,164,164|
            public string Language = string.Empty; // Example Data: en
            public string ThumbnailPath = string.Empty; // Example Data: _cache/fanart/original/73800-12.jpg
            public string VignettePath = string.Empty; // Example Data: fanart/vignette/73800-12.jpg
            public int Season = 0; // Example Data: 0

            public Banner()
            {

            }

        }
        /// <summary>
        /// Public Constructor
        /// </summary>
        public TheTVDBDataBanner()
        {
            Banners = new List<Banner>();
        }


        /// <summary>
        /// Used to write the XML file
        /// </summary>
        /// <param name="data"></param>
        /// <param name="fileName"></param>
        public static void SaveDataXML(TheTVDBDataBanner data, String fileName)
        {
            try
            {
                XmlSerializer xs = new XmlSerializer(typeof(TheTVDBDataBanner));

                using (TextWriter tw = new StreamWriter(fileName))
                {
                    xs.Serialize(tw, data);

                    tw.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(DateTime.Now + ": ERRROR: " + ex.Message);
            }
        }


        /// <summary>
        /// Used to get the deserialize the XML Contents from a 
        /// memory stream byte[] to memory
        /// </summary>
        /// <param name="FileName"></param>
        /// <returns></returns>
        public static TheTVDBDataBanner GetDataFromXML(string FileName)
        {
            XmlSerializer xs = new XmlSerializer(typeof(TheTVDBDataBanner));
            try
            {
                using (TextReader tr = new StreamReader(new MemoryStream(GetXMLDataFromFile(FileName))))
                {
                    TheTVDBDataBanner data = (TheTVDBDataBanner)xs.Deserialize(tr);
                    tr.Close();
                    return data;
                }
            }
            catch (Exception ex)
            {
            }
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


                //ThreadPool.QueueUserWorkItem(
                //delegate(object state)
                //{
                response = ASCIIEncoding.Default.GetBytes(readHtmlPage(fileName));
                //});
                //DateTime startTime = DateTime.Now;
                //while (!Program.WebThreadDone)
                //{
                //    Application.DoEvents();
                //    Console.WriteLine("In thread wait loop 1");
                //}
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
                string result;
                WebResponse objResponse;
                WebRequest objRequest = System.Net.HttpWebRequest.Create(url);
                objRequest.Timeout = 60000;

                objResponse = objRequest.GetResponse();

                using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
                {
                    result = sr.ReadToEnd();
                    // Close and clean up the StreamReader 
                    sr.Close();
                }
                return result;
            }
            catch (Exception ex)
            {
            }
            return null;
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
