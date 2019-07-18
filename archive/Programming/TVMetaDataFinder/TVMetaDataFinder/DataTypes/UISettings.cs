using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.Windows.Forms;

namespace TVMetaDataFinder.DataTypes
{
    [Serializable]
    public class ShowMenuExtenion
    {
        public ShowMenuExtenion()
        { }
        public string MenuName { get; set; }
        /// <summary>
        /// Action 
        /// http://www.bing.com/search?q={show}{season}{ep}
        /// show = showname
        /// seasontowatch = season to view, eg season with the next episode
        ///                 or new season if you have watch the current one
        /// eptowatch     = next episode or first epiosde of new season                
        /// </summary>
        public string Action { get; set; }
    }

    public partial class UISettings
    {


        [Serializable]
        public class SearchAndReplace
        {
            public string SearchFor { get; set; }
            public string ReplaceWith { get; set; }
            public SearchAndReplace() { }
            public SearchAndReplace(string s, string r)
            {
                SearchFor = s;
                ReplaceWith = r;
            }
        }


        public bool CheckForUpgrade { get; set; }
        public string DefaultDirectory { get; set; }
        public string DropFolder { get; set; }
        public bool RenameFilesChecked { get; set; }
        public bool PromptEachFilesChecked { get; set; }
        public string FileFormat { get; set; }
        public bool SaveMetaData { get; set; }
        public bool ForceRefresh { get; set; }
        public bool MiminimizeToTray { get; set; }
        public string LastDirectory { get; set; }
        public bool SaveBannerArt { get; set; }
        public bool HideMetaData { get; set; }
        public int WebTimeOutInSeconds { get; set; }
        public bool ExtractFromVideo { get; set; }
        public string OtherFileFormat { get; set; }
        public bool SaveMyFile { get; set; }
        public string[] TVShowExtractor { get; set; }        
        public SearchAndReplace[] TVShowReplacer { get; set; }
        public ShowMenuExtenion[] ShowMenuExtenions { get; set; }
        

        public UISettings()
        {
        }
        public partial class IO
        {
            /// <summary>
            /// Used to write the XML file
            /// </summary>
            /// <param name="data"></param>
            /// <param name="fileName"></param>
            public static void SaveDataXML(UISettings data, String fileName)
            {
                try
                {
                    XmlSerializer xs = new XmlSerializer(typeof(UISettings));
                    using (TextWriter tw = new StreamWriter(fileName))
                    {
                        xs.Serialize(tw, data);
                        tw.Close();
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }

            /// <summary>
            /// Reads the XML File
            /// </summary>
            /// <param name="FileName"></param>
            /// <returns></returns>
            public static UISettings GetDataFromXML(String FileName)
            {
                XmlSerializer xs = new XmlSerializer(typeof(UISettings));
                try
                {
                    using (TextReader tr = new StreamReader(FileName))
                    {
                        UISettings settings = (UISettings)xs.Deserialize(tr);
                        tr.Close();
                        return settings;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
                return null;
            }
        }
    }
}