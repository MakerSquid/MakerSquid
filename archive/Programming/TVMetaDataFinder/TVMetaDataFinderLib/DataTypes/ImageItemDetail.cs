using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TVMetaDataFinder.DataTypes
{
    public enum ImageType
    {
        Banner, Poster, FanArt, FolderItem
    }

    public class ImageItemDetal
    {
        public string OriginalImageString { get; set; }
        public string FileName { get; set; }
        public string Url { get; set; }
        public ImageType TypeOfImage { get; set; }
        public bool IsFolderJPG { get; set; }
        public bool IsSeason { get; set; }

        public ImageItemDetal() { }
    }

}
