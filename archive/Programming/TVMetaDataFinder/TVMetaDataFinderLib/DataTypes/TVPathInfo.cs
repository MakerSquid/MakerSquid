using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TVMetaDataFinder.DataTypes
{
    /// <summary>
    /// Class used to contain the file names found in each directory
    /// </summary>
    public partial class TVPathInfo
    {
        public string ShowName { get; set; }
        public string SeasonRootPath { get; set; }
        public string EpisodeRootPath { get; set; }
        public TVSeriesItem TVSeries { get; set; }
        public TheTVDBData TheTVDBDataRaw { get; set; }

        public TVPathInfo(string showName, string showRootPath)
        {
            this.ShowName = showName;
            this.SeasonRootPath = showRootPath;
        }

        public override string ToString()
        {
            return ShowName + " - " + SeasonRootPath;
        }
    }
}