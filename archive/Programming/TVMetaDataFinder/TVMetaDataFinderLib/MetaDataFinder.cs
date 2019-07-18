using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;
using TVMetaDataFinder.DataTypes;
using TVMetaDataFinderLib.Helpers;
using System.Threading;
using System.Windows.Forms;
using System.Runtime.InteropServices;

namespace TVMetaDataFinder
{

    public class RenameItem
    {
        public bool Rename { get; set; }
        public RenameItem(string oldname, string newname)
        {
            Oldname = oldname;
            Newname = newname;
        }
        public string Oldname { get; private set; }
        public string Newname { get; private set; }
        public string Show
        {
            get
            {
                var rval = Directory.GetParent(Oldname).FullName; 
                return  Directory.GetParent(rval).Name;
            }
        }
        public string OldFileName
        {
            get
            {
                return Path.GetFileNameWithoutExtension(Oldname);
            }
        }
        
        public string NewFileName 
        {
            get
            {
                return Path.GetFileNameWithoutExtension(Newname);
            }
            set
            {
                var path = Path.GetDirectoryName(Newname);
                var ext = Path.GetExtension(Newname);

                Newname = Path.Combine(path, value + ext);
            }

        }
    }

    public class RenameList : List<RenameItem>
    {

    }

    public class MessageLoggedEventArgs : EventArgs
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public string ThreadName { get; set; }
    }

    

    public class UpdateProgressEventArgs : EventArgs
    {
        public int Current { get; set; }
        public int Total { get; set; }
    }

    public class MetaDataFinder
    {

        public RenameList renameList = new RenameList();        

        public object running = new object();

        public string DropFolder { get; set; }
        public string ShowFolder { get; set; }
        public bool ForceRefresh { get; set; }
        public bool HideMetaData { get; set; }
        public bool  SaveMetaData { get; set; }
        public bool SaveBannerArt { get; set; }
        public bool ExtractImage { get; set; }
        public bool SaveMy { get; set; }
        public bool PromptEachFile { get; set; }

        public int ThreadCount { get; set; }

        public bool RenameFiles { get; set; }
        public string ShowFormat { get; set; }

        private string apiKey = "E837AF9EE7601DB2";
        private static string[] mediaTypes = new string[] { ".avi", ".mkv", ".mp4", ".mpg", ".mpeg", ".divx", ".ogm", ".wmv", ".m4p" };

        public List<Regex> TVShowRegx { get; set; }
        public Dictionary<string, string> TVShowNameReplacers { get; set; }

        FileSystemWatcher watcher, dropFolderWatcher;
        List<string> watcherQue = new List<string>();

        int progress = 0;
        int progressTodo = 0;

        public List<string> filesJustMoved = new List<string>();

        Thread watcherThread;


        public event EventHandler<MessageLoggedEventArgs> LogMessage;
        public event EventHandler<MessageLoggedEventArgs> Alert;
        public event EventHandler<UpdateProgressEventArgs> UpdateProgress;
        public event EventHandler RenamePrompt;
        public event EventHandler Done;

        public MetaDataFinder()
        {
            // Init defaults
            ForceRefresh = false ;
            HideMetaData = true;
            SaveMetaData = true;
            SaveBannerArt = true;
            ExtractImage = true;
            RenameFiles = true;
            SaveMy = false;
            ShowFormat = "{3} - {4}";
            PromptEachFile = false;
            this.ThreadCount = 4;
            
        }


        bool justDoneFile(string file)
        {
            if (filesJustMoved.Contains(file)) return true;
            if (file.Contains(".inp.")) return true;

            return false;
        }

        public void ProcessDropFolder()
        {
            lock (running)
            {
                try
                {
                    if (!Directory.Exists(DropFolder)) throw new Exception(string.Format("Drop folder not found {0}", DropFolder));
                    if (!Directory.Exists(ShowFolder)) throw new Exception(string.Format("Drop folder not found {0}", ShowFolder));

                    var mediaFiles = from f in Directory.GetFiles(DropFolder) let fi = new FileInfo(f) where mediaTypes.Contains(fi.Extension) select f;

                    progressTodo = mediaFiles.Count();
                    progress = 0;

                    updateProgress();

                    foreach (var fullpath in mediaFiles)
                    {
                        processDropFile(fullpath);
                        // Now lets create the folder if needed and move the file to it.                
                        updateProgress(1);
                    }
                }
                finally
                {
                    if (Done != null) Done(this, null);
                   
                }
            }
        
        }

        private void processDropFile(string fullpath)
        {
            var file = System.IO.Path.GetFileName(fullpath);

            FileNameParser fnp = new FileNameParser();
            fnp.TVShowNameReplacers = this.TVShowNameReplacers;
            fnp.DropFolder = this.DropFolder;
            fnp.ShowFolder = this.ShowFolder;
            fnp.TVShowRegx = this.TVShowRegx;
            if (fnp.ExtractDetails(file))
            {
                //processFile(fnp.Show , fnp.SeasonNo ,fnp.EpNo , file);
                try
                {
                    var path = Path.Combine(ShowFolder, string.Format("{0}\\Season {1}", fnp.Show, fnp.SeasonNo));
                    Directory.CreateDirectory(path);
                    
                    var sourceFile = Path.Combine(DropFolder, file);
                    var newfilename = fnp.EpNo.ToString("00") + " " + Path.GetFileNameWithoutExtension(file) + ".inp" + Path.GetExtension(file);
                    var destFile = Path.Combine(path, newfilename);
                    File.Move(sourceFile, destFile);
                    try
                    {
                        string temp1 = Path.GetDirectoryName(path);
                        string temp2 = Path.GetDirectoryName(temp1);

                        StartProcess(temp2, fnp.Show, fnp.SeasonNo, fnp.EpNo,true);
                    }
                    catch
                    {
                        // StartProcess fail
                    }
                    if (File.Exists(destFile))
                    {
                        // looks like its not been delt with...
                        filesJustMoved.Add(sourceFile); // lets make sure we did trigger an event
                        File.Move(destFile, sourceFile);
                    }

                }
                catch (Exception ex)
                {
                    // Not sure whats gone on
                    System.Diagnostics.Trace.WriteLine(ex.ToString());
                }

            }
            AddToLog(fnp.Outcome);
        }

        private void updateProgress(int p)
        {
            progress += p;            
            updateProgress();
        }

        private void updateProgress()
        {
            if (this.progress > this.progressTodo) 
                this.progressTodo++;
            if (UpdateProgress != null)
            {
                UpdateProgress(this, new UpdateProgressEventArgs() { Current = progress, Total = progressTodo });
            }

        }


        public void ProcessShows()
        {
            lock (running)
            {
                try
                {
                    Parallel.NumberOfParallelTasks = this.ThreadCount;

                    DateTime startTime = System.DateTime.Now;
                    if (!Directory.Exists(ShowFolder)) throw new Exception(string.Format("Show folder not found {0}", ShowFolder));
                    StartProcess(ShowFolder, string.Empty, -1, -1,false);
                    TimeSpan ts = System.DateTime.Now - startTime;                    
                }
                finally
                {
                    if (Done != null) Done(this, null);
                }
            }
            
        }

        /// <summary>
        /// Processes everything
        /// </summary>
        /// <param name="targetDirectory"></param>
        private void StartProcess(string targetDirectory, string seriesNameInput, int seasonNumberInput, int episodeNumberInput, bool overriderename)
        {
            renameList.Clear();
            AddToLog("Starting Process...");
            // Disables the UI Buttons
            bool skipProcess = false;

            if (!skipProcess)
            {

                // Gets a list of all the files in the directory
                AddToLog("Getting a listing of all files *.avi, *.mkv, *.mp4, *.mpg, *.mpeg, *.divx, *.ogm, and *.wmv in " + targetDirectory);
                List<string> directoryListing = null;
                if (seriesNameInput.Length > 0)
                {
                    directoryListing = new List<string>();
                    directoryListing.Add(Path.Combine(targetDirectory, seriesNameInput));
                }
                else
                {
                    directoryListing = Directory.GetDirectories(targetDirectory, "*.*", SearchOption.TopDirectoryOnly).ToList<string>();
                }
                // Lets workout if we are on a show folder.
                // simple way todo this is just to add our self if we see folders called season n
                if (directoryListing.Where( s => Path.GetFileName(s).StartsWith("Season") ).FirstOrDefault()  != null )
                {
                    // ok, we have some season folders.
                    // lets add our self
                    directoryListing.Add(targetDirectory);
                    //  and lets remove the season and image folderfs

                    directoryListing.RemoveAll( s => Path.GetFileName(s).StartsWith("Season") );
                    directoryListing.RemoveAll( s => Path.GetFileName(s).Equals("Images"));
                    directoryListing.Where(s => Path.GetFileName(s).StartsWith("Season"));
                }

                // GetAllReleventFiles(targetDirectory);
                List<TVPathInfo> tvShows = new List<TVPathInfo>();
                tvShows = GetTVShowNames(directoryListing);
                // lets do this the PFX WAY
                // download PFX from http://www.microsoft.com/downloads/details.aspx?FamilyId=348F73FD-593D-4B3C-B055-694C50D2B0F3&displaylang=en
                if (tvShows.Count != 1)
                {
                    this.progressTodo = tvShows.Count;
                }
                TVMetaDataFinderLib.Helpers.Parallel.ForEach<TVPathInfo>(tvShows, (item) =>
                {
                    if (!item.ShowName.StartsWith("Season"))
                    {
                        processShow(seasonNumberInput, episodeNumberInput, item, overriderename);
                        if (tvShows.Count != 1)
                        {
                            updateProgress(1);
                        }
                        AddToLog(String.Format("Done {0} : {1}", item.ShowName, episodeNumberInput));
                    }
                });
            }
            // now lets do the renames
            if (renameList.Count != 0)
            {
                if (PromptEachFile && RenamePrompt != null)
                {
                    RenamePrompt(this,null);
                }
                foreach (var item in renameList)
                {
                    if (item.Rename || !PromptEachFile) File.Move(item.Oldname, item.Newname);
                }
            }
            AddToLog("Done!");
        }

        private void processShow(int seasonNumberInput, int episodeNumberInput, TVPathInfo item,bool overriderename)
        {
            //Application.DoEvents();
            AddToLog("Finding series information for " + item.ShowName + "...");

            string seasonID = string.Empty;
            try
            {
                seasonID = TheTVDBData.GetDataFromXML("http://www.thetvdb.com/api/GetSeries.php?seriesname=" + item.ShowName).SeriesDetail.id;
            }
            catch
            {
                AddToLog("Either unable to find the web service, or the TV Show... Try again later, or visit thetvdb.com");
                //break;
            }

            try
            {
                if (! string.IsNullOrEmpty(seasonID))
                {
                    AddToLog("Found series, getting details about the series...");
                    item.TheTVDBDataRaw = TheTVDBData.GetDataFromXML("http://www.thetvdb.com/api/" + apiKey + "/series/" + seasonID + "/all/");

                    // Translation between new data type and old data type
                    item.TVSeries = new TVSeriesItem();
                    item.TVSeries.Actors = item.TheTVDBDataRaw.SeriesDetail.Actors;
                    item.TVSeries.id = item.TheTVDBDataRaw.SeriesDetail.id;
                    item.TVSeries.Airs_DayOfWeek = item.TheTVDBDataRaw.SeriesDetail.Airs_DayOfWeek;
                    item.TVSeries.Airs_Time = item.TheTVDBDataRaw.SeriesDetail.Airs_Time;
                    item.TVSeries.FirstAired = item.TheTVDBDataRaw.SeriesDetail.FirstAired;
                    item.TVSeries.Genre = item.TheTVDBDataRaw.SeriesDetail.Genre;
                    item.TVSeries.IMDB_ID = item.TheTVDBDataRaw.SeriesDetail.IMDB_ID;
                    item.TVSeries.Network = item.TheTVDBDataRaw.SeriesDetail.Network;
                    item.TVSeries.Overview = item.TheTVDBDataRaw.SeriesDetail.Overview;
                    item.TVSeries.Rating = item.TheTVDBDataRaw.SeriesDetail.Rating;
                    item.TVSeries.Runtime = item.TheTVDBDataRaw.SeriesDetail.Runtime;
                    item.TVSeries.SeriesID = item.TheTVDBDataRaw.SeriesDetail.SeriesID;
                    item.TVSeries.SeriesName = item.TheTVDBDataRaw.SeriesDetail.SeriesName;
                    item.TVSeries.Status = item.TheTVDBDataRaw.SeriesDetail.Status;
                    item.TVSeries.lastupdated = item.TheTVDBDataRaw.SeriesDetail.lastupdated;
                    item.TVSeries.zap2it_id = item.TheTVDBDataRaw.SeriesDetail.zap2it_id;

                    item.TVSeries.Banner = item.TheTVDBDataRaw.SeriesDetail.banner;
                    item.TVSeries.Fanart = item.TheTVDBDataRaw.SeriesDetail.fanart;
                    item.TVSeries.Poster = item.TheTVDBDataRaw.SeriesDetail.poster;

                    SetFileAttributes(item.SeasonRootPath + "\\series.xml", FileAttributes.Normal);
                    SetFileAttributes(item.SeasonRootPath + "\\images.xml", FileAttributes.Normal);
                    SetFileAttributes(item.SeasonRootPath + "\\folder.jpg", FileAttributes.Normal);
                    SetFileAttributes(item.SeasonRootPath + "\\banner.jpg", FileAttributes.Normal);

                    TVSeriesIO.SaveSeriesXML(item.TVSeries, item.SeasonRootPath + "\\series.xml");


                    TheTVDBDataBanner theTVDBDataBanner = TheTVDBDataBanner.GetDataFromXML("http://www.thetvdb.com/api/" + apiKey + "/series/" + seasonID + "/banners.xml");
                    if (SaveBannerArt) { SetImages(item.SeasonRootPath, theTVDBDataBanner); }
                    TheTVDBDataBanner.SaveDataXML(theTVDBDataBanner, item.SeasonRootPath + "\\images.xml");

                    SetFileAttributes(item.SeasonRootPath + "\\series.xml", FileAttributes.Hidden);
                    SetFileAttributes(item.SeasonRootPath + "\\images.xml", FileAttributes.Hidden);
                    SetFileAttributes(item.SeasonRootPath + "\\folder.jpg", FileAttributes.Hidden);
                    SetFileAttributes(item.SeasonRootPath + "\\banner.jpg", FileAttributes.Hidden);

                    ProcessFilesInDirectory(item, seasonNumberInput, episodeNumberInput,overriderename);

                    //this.prgStatus.Value++; Invoke
                    //Application.DoEvents();
                }
                else
                {
                    AddToLog("Series not found for " + item.ShowName + "!");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private List<string> GetAllReleventFiles(string targetDirectory)
        {
            List<string> response = new List<string>();
            List<string> directoryListing = new List<string>();

            directoryListing.AddRange(Directory.GetFiles(targetDirectory, "*.*", SearchOption.TopDirectoryOnly).ToList<string>());

            foreach (string file in directoryListing)
            {
                string extension = Path.GetExtension(file);
                bool addToResponseList = false;
                switch (extension)
                {
                    case ".vob":
                        addToResponseList = true;
                        break;
                    case ".bup":
                        addToResponseList = true;
                        break;
                    case ".ifo":
                        addToResponseList = true;
                        break;
                    case ".rmvb":
                        addToResponseList = true;
                        break;
                    case ".mov":
                        addToResponseList = true;
                        break;
                    case ".avi":
                        addToResponseList = true;
                        break;
                    case ".mpg":
                        addToResponseList = true;
                        break;
                    case ".mpeg":
                        addToResponseList = true;
                        break;
                    case ".wmv":
                        addToResponseList = true;
                        break;
                    case ".mp4":
                        addToResponseList = true;
                        break;
                    case ".mkv":
                        addToResponseList = true;
                        break;
                    case ".divx":
                        addToResponseList = true;
                        break;
                    case ".iso":
                        addToResponseList = true;
                        break;
                    case ".dvr-ms":
                        addToResponseList = true;
                        break;
                    case ".ogm":
                        addToResponseList = true;
                        break;
                    case ".wmvhd":
                        addToResponseList = true;
                        break;
                    default:
                        addToResponseList = false;
                        break;
                }
                if (addToResponseList)
                {
                    response.Add(file);
                }
            }

            return response;
        }

        private int GetSeasonNumber(string fullPath)
        {
            int response = -1;

            try
            {
                //Application.DoEvents();

                string currentShowDirectoryName = Path.GetFileName(fullPath);
                if (currentShowDirectoryName.Equals("Images",StringComparison.InvariantCultureIgnoreCase )) return -1;
                List<string> dirSplit = new List<string>();

                string seasonTitleString = Regex.Replace(currentShowDirectoryName, "[^0-9]", "");

                response = Convert.ToInt32(seasonTitleString);
            }
            catch { }

            return response;
        }


        

        //void service_GetTVShowSeriesByNameCompleted(object sender, TVMetaDataFinder.com.metadatafinder.GetTVShowSeriesByNameCompletedEventArgs e)
        //{
        //    if (e.Result.TVMetaDataID.Length > 0)
        //    {
        //        AddToLog("Background Process: Finished updating metadata(" + e.Result.TVMetaDataID + "[" + e.Result.SeriesName + "]).");
        //    }
        //}

        

        private List<TVSeasonInfo> GetSeasonNumbers(List<string> directoryListing)
        {
            List<TVSeasonInfo> response = new List<TVSeasonInfo>();

            foreach (string item in directoryListing)
            {

                var filename = Path.GetFileName(item);

                //Application.DoEvents();
                if ((!filename.Equals("images", StringComparison.InvariantCultureIgnoreCase)) &&
                     (!filename.Equals("metadata", StringComparison.InvariantCultureIgnoreCase)))
                {

                string currentShowDirectoryName = Path.GetFileName(item);
                string rootPath = item.Replace("\\" + currentShowDirectoryName, "");

                List<string> dirSplit = new List<string>();

                string seasonTitleString = Regex.Replace(currentShowDirectoryName, "[^0-9]", "");

                try
                {
                    response.Add(new TVSeasonInfo(Convert.ToInt32(seasonTitleString), item));
                }
                catch { }
                }
            }

            response = removeDuplicates(response);

            try
            {
                //response.Sort();
            }
            catch { }

            return response;
        }


        static List<TVSeasonInfo> removeDuplicates(List<TVSeasonInfo> inputList)
        {
            Dictionary<int, int> uniqueStore = new Dictionary<int, int>();
            List<TVSeasonInfo> finalList = new List<TVSeasonInfo>();

            foreach (TVSeasonInfo currValue in inputList)
            {
                //Application.DoEvents();
                if (!uniqueStore.ContainsKey(currValue.SeasonNumber))
                {
                    uniqueStore.Add(currValue.SeasonNumber, 0);
                    finalList.Add(new TVSeasonInfo(currValue.SeasonNumber, currValue.SeasonPath));
                }
            }
            return finalList;
        }

        private string GetSplitPath(string item, int placesBackward)
        {
            string response = string.Empty;

            int totalSectionsInString = item.Split('\\').Count();

            List<string> pathList = new List<string>();

            pathList.AddRange(item.Split('\\'));

            pathList.Reverse();

            bool firstTime = true;
            for (int i = placesBackward - 1; i < totalSectionsInString; i++)
            {
                string slashValue = string.Empty;
                if (firstTime)
                {
                    firstTime = false;
                    slashValue = string.Empty;
                }
                else
                {
                    slashValue = "\\";
                }
                response = pathList[i] + slashValue + response;
            }

            return response;
        }

        public  static int GetEpisode(string input)
        {
            int response = 0;

            List<string> matches = new List<string>();
            matches.Add(@"\dx(\d+)");
            matches.Add(@"s\d+e(\d+)");
            matches.Add(@"\d{2}");
            matches.Add(@"\d+");
            foreach (var s in matches)
            {
                var match = Regex.Match(input, s,RegexOptions.IgnoreCase );
                if (match.Success)
                {
                    return int.Parse( match.Groups[match.Groups.Count -1].Value);
                }
            }
            return -1;
        }

        private void ProcessFilesInDirectory(TVPathInfo showItem, int seasonNumberInput, int episodeNumberInput,bool overriderename)
        {
            AddToLog("Getting directory information in " + showItem.SeasonRootPath + "...");
            List<string> directoryListing = Directory.GetDirectories(showItem.SeasonRootPath, "*.*", SearchOption.TopDirectoryOnly).ToList<string>();

            string processOnlySeasonDirectory = null;

            if (seasonNumberInput != -1)
            {
                foreach (string directoryItem in directoryListing)
                {
                    try
                    {
                        int seasonNumberTemp = GetSeasonNumber(directoryItem);
                        if (seasonNumberTemp == seasonNumberInput)
                        {
                            processOnlySeasonDirectory = directoryItem;
                        }
                    }
                    catch { }
                }
            }

            if (!string.IsNullOrEmpty(processOnlySeasonDirectory))
            {
                directoryListing = new List<string>();
                directoryListing.Add(processOnlySeasonDirectory);
            }

            // Gets the season numbers for each season
            showItem.TVSeries.SeasonData = GetSeasonNumbers(directoryListing);
            if (showItem.TVSeries.SeasonData.Count > 0) AddToLog("Found Season Numbers for Series.");

            foreach (TVSeasonInfo item in showItem.TVSeries.SeasonData)
            {
                //Application.DoEvents();
                AddToLog("Getting directory information for season " + item.SeasonNumber.ToString("00") + "...");
                directoryListing = GetAllReleventFiles(item.SeasonPath);

                string processOnlyEpisodeFileName = null;
                if (episodeNumberInput != -1)
                {
                    foreach (string directoryItem in directoryListing)
                    {
                        try
                        {
                            int episodeNumberTemp = GetEpisode(new FileInfo(directoryItem).Name.ToString());
                            if (episodeNumberTemp == episodeNumberInput)
                            {
                                processOnlyEpisodeFileName = directoryItem;
                            }
                        }
                        catch { }
                    }
                }

                if (!string.IsNullOrEmpty(processOnlyEpisodeFileName))
                {
                    directoryListing = new List<string>();
                    directoryListing.Add(processOnlyEpisodeFileName);
                }

                foreach (string dirItem in directoryListing)
                {
                    //Application.DoEvents();
                    TVEpisode tvEpisode = new TVEpisode();
                    tvEpisode.EpisodeNumber = GetEpisode(new FileInfo(dirItem).Name.ToString());
                    tvEpisode.EpisodePath = dirItem;
                    string pathOnly = new FileInfo(dirItem).Directory.ToString();
                    string fileExt = new FileInfo(dirItem).Extension.ToString();
                    string newFileName = string.Empty;
                    string newFileNameOnly = string.Empty;

                    

                    foreach (TheTVDBData.TVShowEpisode episodeItem in showItem.TheTVDBDataRaw.Episodes)
                    {
                        //Application.DoEvents();
                        if (item.SeasonNumber == Convert.ToInt32(episodeItem.SeasonNumber))
                        {
                            if (tvEpisode.EpisodeNumber == Convert.ToInt32(episodeItem.EpisodeNumber))
                            {
                                tvEpisode.TVShowEpisode = new TVShowEpisodeItem();
                                tvEpisode.TVShowEpisode.id = episodeItem.id;
                                tvEpisode.TVShowEpisode.Combined_episodenumber = episodeItem.Combined_episodenumber;
                                tvEpisode.TVShowEpisode.Combined_season = episodeItem.Combined_season;
                                tvEpisode.TVShowEpisode.DVD_chapter = episodeItem.DVD_chapter;
                                tvEpisode.TVShowEpisode.DVD_discid = episodeItem.DVD_discid;
                                tvEpisode.TVShowEpisode.DVD_episodenumber = episodeItem.DVD_episodenumber;
                                tvEpisode.TVShowEpisode.DVD_season = episodeItem.DVD_season;
                                tvEpisode.TVShowEpisode.Director = episodeItem.Director;
                                tvEpisode.TVShowEpisode.EpImgFlag = episodeItem.EpImgFlag;
                                tvEpisode.TVShowEpisode.EpisodeName = episodeItem.EpisodeName;
                                tvEpisode.TVShowEpisode.EpisodeNumber = episodeItem.EpisodeNumber;
                                tvEpisode.TVShowEpisode.FirstAired = episodeItem.FirstAired;
                                tvEpisode.TVShowEpisode.GuestStars = episodeItem.GuestStars;
                                tvEpisode.TVShowEpisode.IMDB_ID = episodeItem.IMDB_ID;
                                tvEpisode.TVShowEpisode.Language = episodeItem.Language;
                                tvEpisode.TVShowEpisode.Overview = episodeItem.Overview;
                                tvEpisode.TVShowEpisode.ProductionCode = episodeItem.ProductionCode;
                                tvEpisode.TVShowEpisode.Rating = episodeItem.Rating;
                                tvEpisode.TVShowEpisode.SeasonNumber = episodeItem.SeasonNumber;
                                tvEpisode.TVShowEpisode.absolute_number = episodeItem.absolute_number;
                                tvEpisode.TVShowEpisode.airsafter_season = episodeItem.airsafter_season;
                                tvEpisode.TVShowEpisode.airsbefore_episode = episodeItem.airsbefore_episode;
                                tvEpisode.TVShowEpisode.airsbefore_season = episodeItem.airsbefore_season;
                                tvEpisode.TVShowEpisode.filename = episodeItem.filename;
                                tvEpisode.TVShowEpisode.lastupdated = episodeItem.lastupdated;
                                tvEpisode.TVShowEpisode.seasonid = episodeItem.seasonid;
                                tvEpisode.TVShowEpisode.seriesid = episodeItem.seriesid;
                                tvEpisode.EpisodeFileNameOnly = Path.GetFileNameWithoutExtension(dirItem.ToString());            
                                tvEpisode.EpisodeName = episodeItem.EpisodeName;
                                AddToLog("Processing Episode " + tvEpisode.EpisodeNumber.ToString("00") + " - " + tvEpisode.EpisodeName + "...");
                            }
                        }
                    }
                    item.Epesodes.Add(tvEpisode);

                    try
                    {
                        if (!this.RenameFiles && !overriderename  )
                        {
                            newFileNameOnly = tvEpisode.EpisodeFileNameOnly;
                        }
                        else 
                        {
                            tvEpisode.EpisodeFileNameOnly = Path.GetFileNameWithoutExtension(dirItem.ToString());
                            newFileNameOnly = formatFileName(showItem, item, tvEpisode);
                            newFileName = pathOnly + "\\" + newFileNameOnly;
                        }
                        if (!dirItem.Equals(newFileName + fileExt))
                        {
                            if (this.RenameFiles || overriderename )
                            {
                                
                                if (!File.Exists(newFileName + fileExt))
                                {
                                    bool watchState = false;
                                    AddToLog("Renaming file to: " + newFileName + fileExt);
                                    try
                                    {
                                        // we dont want to re-fire the watcher.
                                        // so we add files just moved to our own list
                                        filesJustMoved.Add(newFileName + fileExt);
                                        if (!overriderename)
                                        {
                                            // if called with overide it not need as its done from a drop event
                                            // or process drop folders.
                                            lock (renameList)
                                            {
                                                renameList.Add(new RenameItem(dirItem, newFileName + fileExt));
                                            }
                                        }
                                        else
                                        {
                                            File.Move(dirItem, newFileName + fileExt);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        AddToLog("Error Renaming (Moving) File: " + dirItem + " to " + newFileName + fileExt + "\r\nException: " + ex.Message + "\r\n" + ex.StackTrace);
                                    }
                               
                                }
                            }

                        }
                    }
                    catch (Exception ex) { /* MessageBox.Show("Error: " + ex.Message); */ }

                    if (this.SaveMy)
                    {
                        if (!File.Exists(pathOnly + "\\" + newFileNameOnly + ".my"))
                        {

                            AddToLog("Adding MetaData (.my File)...");
                            StringBuilder sb = new StringBuilder();
                            sb.Append("Title=" + ReplacePipeWithComma(showItem.TVSeries.SeriesName)); sb.Append("\r\n");
                            sb.Append("overview=" + ReplacePipeWithComma(showItem.TVSeries.Overview)); sb.Append("\r\n");
                            sb.Append("TVOriginalAiringDate=" + ReplacePipeWithComma(tvEpisode.TVShowEpisode.FirstAired)); sb.Append("\r\n");
                            sb.Append("actors=" + ReplacePipeWithComma(showItem.TVSeries.Actors)); sb.Append("\r\n");
                            sb.Append("TVEpisode=" + ReplacePipeWithComma(tvEpisode.TVShowEpisode.EpisodeNumber)); sb.Append("\r\n");
                            sb.Append("TVOverview=" + ReplacePipeWithComma(tvEpisode.TVShowEpisode.Overview)); sb.Append("\r\n");
                            sb.Append("TVDuration=" + ReplacePipeWithComma(showItem.TVSeries.Runtime)); sb.Append("\r\n");
                            sb.Append("TVGenre=" + ReplacePipeWithComma(showItem.TVSeries.Genre)); sb.Append("\r\n");
                            sb.Append("TVChannelName=" + ReplacePipeWithComma(showItem.TVSeries.Network));

                            using (StreamWriter sw = File.CreateText(pathOnly + "\\" + newFileNameOnly + ".my"))
                            {
                                try
                                {
                                    sw.Write(sb.ToString());
                                    sw.Close();
                                }
                                catch { }
                            }
                        }
                    }

                    if (this.SaveMetaData )
                    {
                        try
                        {
                            Directory.CreateDirectory(pathOnly + "\\metadata");
                            SetDirectoryAttributes(pathOnly + "\\metadata", FileAttributes.Hidden);
                        }
                        catch { }

                        try
                        {
                            if (tvEpisode.TVShowEpisode.filename.Replace("episodes/", "").Length > 0)
                            {
                                if (!File.Exists(pathOnly + "\\metadata\\" + tvEpisode.TVShowEpisode.filename.Replace("episodes/", "")) || ForceRefresh )
                                {
                                    AddToLog("Adding Thumbnails...");
                                    Helpers.SaveImageFromWeb.WriteBytesToFile(pathOnly + "\\metadata\\" + tvEpisode.TVShowEpisode.filename.Replace("episodes/", ""),
                                        "http://thetvdb.com/banners/" + tvEpisode.TVShowEpisode.filename);
                                }
                            }
                            else
                            {
                                if (this.ExtractImage)
                                {
                                    if (!File.Exists(pathOnly + "\\metadata\\" + "episodes/" + tvEpisode.TVShowEpisode.seriesid + "-" + tvEpisode.TVShowEpisode.id + ".jpg") || ForceRefresh )
                                    {
                                        AddToLog("Extracting Thumbnail...");
                                        try
                                        {
                                            tvEpisode.TVShowEpisode.filename = "episodes/" + tvEpisode.TVShowEpisode.seriesid + "-" + tvEpisode.TVShowEpisode.id + ".jpg";
                                            //Application.DoEvents();
                                            ThumbCreator.CreateThumb(Path.Combine(pathOnly, newFileName + fileExt), Path.Combine(pathOnly, @"metadata\" + tvEpisode.TVShowEpisode.filename.Replace("episodes/", "")), .5);
                                        }
                                        catch { }
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            AddToLog("Issue finding episode information for: " + item.SeasonNumber.ToString() + ".");
                        }

                        try
                        {
                            if (!File.Exists(pathOnly + "\\metadata\\" + newFileNameOnly + ".xml") || ForceRefresh )
                            {
                                AddToLog("Adding MetaData...");
                                EpisodeItemIO.SaveDataXML(tvEpisode.TVShowEpisode, pathOnly + "\\metadata\\" + newFileNameOnly + ".xml");
                            }


                        }
                        catch (Exception ex)
                        {
                            AddToLog("Issue finding episode information for: " + item.SeasonNumber.ToString() + ".");
                        }
                    }

                }
            }

            return;

        }

        public string formatFileName( TVPathInfo showItem, TVSeasonInfo item, TVEpisode tvEpisode)
        {
            
            var showName = showItem.ShowName;
            var seasonNo = item.SeasonNumber;
            var epNo = tvEpisode.EpisodeNumber;
            var tvepName = tvEpisode.EpisodeName;
            
            return formatFileName(showName, seasonNo, epNo, tvepName,tvEpisode.EpisodeFileNameOnly );
        }

        public string formatFileName(string showName, int seasonNo, int epNo, string tvepName, string filename)
        {
            string temp = this.ShowFormat;

            // the filename holds the format
            // I am working on improving this
            string preservedFormat = "";

            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" DSRip ")) preservedFormat = "DSRip";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" DVBRip ")) preservedFormat = "DVBRip";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" DVDR ")) preservedFormat = "DVDR";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" DVDRip ")) preservedFormat = "DVDRip";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" DVDScr ")) preservedFormat = "DVDScr";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" HDTV ")) preservedFormat = "HDTV";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" HR.HDTV ")) preservedFormat = "HR.HDTV";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" HR.PDTV ")) preservedFormat = "HR.PDTV";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" PDTV ")) preservedFormat = "PDTV";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" SatRip ")) preservedFormat = "SatRip";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" WebRip ")) preservedFormat = "WebRip";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" 720i ")) preservedFormat = "720i";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" 720p ")) preservedFormat = "720p";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" 1080i ")) preservedFormat = "1080i";
            if (filename.Replace(".", " ").Replace("(", " ").Replace(")", " ").Contains(" 1080p ")) preservedFormat = "1080p";

            if (preservedFormat.Length > 0)
            {
                temp = temp.Replace("{5}", " (" + preservedFormat + ")");
                temp = temp.Replace("{6}", "." + preservedFormat + ".");
                temp = temp.Replace("{7}", "." + preservedFormat + "");
                temp = temp.Replace("{8}", "-" + preservedFormat + "");
                temp = temp.Replace("{9}", " - " + preservedFormat + "");
                temp = temp.Replace("{10}", " - " + preservedFormat + " - ");
                temp = temp.Replace("{11}", " " + preservedFormat + " - ");
                
            }
            else
            {
                temp = temp.Replace("{5}", string.Empty);
                temp = temp.Replace("{6}", string.Empty);
                temp = temp.Replace("{7}", string.Empty);
                temp = temp.Replace("{8}", string.Empty);
                temp = temp.Replace("{9}", string.Empty);
                temp = temp.Replace("{10}", string.Empty);
                temp = temp.Replace("{11}", string.Empty);
            }

            temp = temp.Replace("{1}", showName);
            temp = temp.Replace("{2}", seasonNo.ToString ("00"));
            temp = temp.Replace("{3}", epNo.ToString ("00"));
            temp = temp.Replace("{4}", tvepName);
            temp = temp.Replace("{5}", preservedFormat);

            temp = Regex.Replace(temp,@"/|\?|<|>|:|\*|\||\\","");

            return temp;
        }

        private string ReplacePipeWithComma(string value)
        {
            string response = value;
            try
            {
                if (value.Substring(0, 1).Contains("|"))
                {
                    value = value.Remove(0, 1);
                }

                if (value.Substring(value.Length - 1, 1).Contains("|"))
                {
                    value = value.Remove(value.Length - 1, 1);
                }

                response = value.Replace("|", ", ");
            }
            catch { }
            return response;
        }



        private void SetFileAttributes(string file, FileAttributes attributes)
        {
            if (HideMetaData )
            {
                try
                {
                    if (File.Exists(file))
                    {
                        FileInfo fileInfo = new FileInfo(file);
                        fileInfo.Attributes = attributes;
                    }
                }
                catch { }
            }
        }

        private void SetImages(string seasonRootPath, TheTVDBDataBanner theTVDBDataBanner)
        {
            AddToLog("Locating... Banners, FanArt, and Posters (if any)...");



            List<ImageItemDetal> imagesToGrab = new List<ImageItemDetal>();
            bool firstPosterAdded = false;
            bool firstBannerAdded = false;
            bool firstBackDropAdded = false;
            Dictionary<int, bool> firstSeriesPosterAdded = new Dictionary<int, bool>();

            foreach (TheTVDBDataBanner.Banner bannerItem in theTVDBDataBanner.Banners)
            {
                //Application.DoEvents();
                if (bannerItem.BannerType.Equals("poster"))
                {
                    if (!firstPosterAdded)
                    {
                        ImageItemDetal tempImgItemRootImage = new ImageItemDetal();
                        tempImgItemRootImage.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                        tempImgItemRootImage.OriginalImageString = bannerItem.BannerPath;
                        tempImgItemRootImage.FileName = seasonRootPath + @"\folder.jpg";
                        tempImgItemRootImage.IsFolderJPG = true;
                        tempImgItemRootImage.TypeOfImage = ImageType.FolderItem;
                        imagesToGrab.Add(tempImgItemRootImage);
                        firstPosterAdded = true;
                    }
                    ImageItemDetal tempImgItem = new ImageItemDetal();
                    tempImgItem.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                    tempImgItem.OriginalImageString = bannerItem.BannerPath;
                    tempImgItem.FileName = seasonRootPath + @"\Images\Posters\" + Path.GetFileName(bannerItem.BannerPath.Replace("/", @"\"));
                    tempImgItem.TypeOfImage = ImageType.Poster;
                    imagesToGrab.Add(tempImgItem);
                }
                else if (bannerItem.BannerType.Equals("fanart"))
                {
                    if (!firstBackDropAdded)
                    {
                        ImageItemDetal tempImgItemRootImage = new ImageItemDetal();
                        tempImgItemRootImage.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                        tempImgItemRootImage.OriginalImageString = bannerItem.BannerPath;
                        tempImgItemRootImage.FileName = seasonRootPath + @"\backdrop.jpg";
                        tempImgItemRootImage.IsFolderJPG = true;
                        tempImgItemRootImage.TypeOfImage = ImageType.FolderItem;
                        imagesToGrab.Add(tempImgItemRootImage);
                        firstBackDropAdded = true;
                    }
                    ImageItemDetal tempImgItem = new ImageItemDetal();
                    tempImgItem.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                    tempImgItem.OriginalImageString = bannerItem.BannerPath;
                    tempImgItem.FileName = seasonRootPath + @"\Images\FanArt\" + Path.GetFileName(bannerItem.BannerPath.Replace("/", @"\"));
                    tempImgItem.TypeOfImage = ImageType.FanArt;
                    imagesToGrab.Add(tempImgItem);
                }
                else if (bannerItem.BannerType.Equals("series"))
                {
                    if (!firstBannerAdded)
                    {
                        ImageItemDetal tempImgItemRootImage = new ImageItemDetal();
                        tempImgItemRootImage.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                        tempImgItemRootImage.OriginalImageString = bannerItem.BannerPath;
                        tempImgItemRootImage.FileName = seasonRootPath + @"\banner.jpg";
                        tempImgItemRootImage.IsFolderJPG = true;
                        tempImgItemRootImage.TypeOfImage = ImageType.FolderItem;
                        imagesToGrab.Add(tempImgItemRootImage);
                        firstBannerAdded = true;
                    }
                    ImageItemDetal tempImgItem = new ImageItemDetal();
                    tempImgItem.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                    tempImgItem.OriginalImageString = bannerItem.BannerPath;
                    tempImgItem.FileName = seasonRootPath + @"\Images\Banners\" + Path.GetFileName(bannerItem.BannerPath.Replace("/", @"\"));
                    tempImgItem.TypeOfImage = ImageType.Banner;
                    imagesToGrab.Add(tempImgItem);
                }
                else if (bannerItem.Season > 0)
                {
                    try
                    {
                        if (!firstSeriesPosterAdded.ContainsKey(bannerItem.Season))
                        {
                            ImageItemDetal tempImgItemRootImage = new ImageItemDetal();
                            tempImgItemRootImage.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                            tempImgItemRootImage.OriginalImageString = bannerItem.BannerPath;
                            tempImgItemRootImage.FileName = seasonRootPath + @"\Season " + bannerItem.Season.ToString() + @"\folder.jpg";
                            tempImgItemRootImage.IsFolderJPG = true;
                            tempImgItemRootImage.TypeOfImage = ImageType.FolderItem;
                            tempImgItemRootImage.IsSeason = true;
                            imagesToGrab.Add(tempImgItemRootImage);
                            firstSeriesPosterAdded[bannerItem.Season] = true;
                        }
                    }
                    catch { throw new Exception(); }
                    ImageItemDetal tempImgItem = new ImageItemDetal();
                    tempImgItem.Url = "http://thetvdb.com/banners/" + bannerItem.BannerPath;
                    tempImgItem.OriginalImageString = bannerItem.BannerPath;
                    tempImgItem.FileName = seasonRootPath + @"\Season " + bannerItem.Season.ToString() + @"\Images\" + Path.GetFileName(bannerItem.BannerPath.Replace("/", @"\"));
                    tempImgItem.TypeOfImage = ImageType.Poster;
                    tempImgItem.IsSeason = true;
                    imagesToGrab.Add(tempImgItem);
                }
            }
            // lets do this the PFX WAY
            TVMetaDataFinderLib.Helpers.Parallel.ForEach<ImageItemDetal>(imagesToGrab, (imageItem) =>
            {
                processImages(seasonRootPath, imageItem);
              //  AddToLog("Done : " + imageItem.Url);
            });

        }

        private bool processImages(string seasonRootPath, ImageItemDetal imageItem)
        {
            try
            {
                if (!File.Exists(imageItem.FileName) || ForceRefresh) 
                {
                    
                    if (imageItem.IsSeason)
                    {
                        if (imageItem.IsFolderJPG)
                        {
                            if (!Directory.Exists(Path.GetDirectoryName(imageItem.FileName)))
                            {

                                return true;
                            }

                        }
                        else
                        {
                            if (!Directory.Exists(Path.GetDirectoryName(imageItem.FileName.Replace("Images\\", ""))))
                            {
                                return true;
                            }

                        }
                    }

                    if (!Directory.Exists(Path.GetDirectoryName(imageItem.FileName)))
                    {
                        //    AddToLog("Creating Directory: " + Path.GetDirectoryName(imageItem.FileName) + "...");
                        Directory.CreateDirectory(Path.GetDirectoryName(imageItem.FileName));
                    }
                    SetDirectoryAttributes(seasonRootPath + @"\Images", FileAttributes.Hidden);

                    if (Directory.GetFiles(Path.GetDirectoryName(imageItem.FileName)).Length > 10)
                        return true;

                    AddToLog("Downloading " + imageItem.TypeOfImage.ToString() + " Image File: " + imageItem.FileName);
                    Helpers.SaveImageFromWeb.WriteBytesToFile(imageItem.FileName, imageItem.Url);
                    AddToLog("Saving " + imageItem.TypeOfImage.ToString() + " Image File: " + imageItem.FileName);
                    if (!imageItem.IsFolderJPG)
                    {
                        SetDirectoryAttributes(Path.GetDirectoryName(imageItem.FileName), FileAttributes.Hidden);
                    }
                    else
                    {
                        SetFileAttributes(imageItem.FileName, FileAttributes.Hidden);
                    }
                }
            }
            catch { }
            return false;
        }

        private void SetDirectoryAttributes(string directory, FileAttributes attributes)
        {
            if (this.HideMetaData)
            {
                try
                {
                    DirectoryInfo directoryInfo = new DirectoryInfo(directory);
                    directoryInfo.Attributes = attributes;
                }
                catch { }
            }
        }

        private static string DesortTHE(string nameOfTVShow)
        {
            if (nameOfTVShow.Contains(", The"))
            {
                nameOfTVShow = "The " + nameOfTVShow.Replace(", The", "");
            }

            return nameOfTVShow;
        }

        private string GetTVShowName(string file)
        {
            if (SplitString(file, 1).ToUpper().Contains("SEASON"))
            {
                return SplitString(file, 2);
            }
            else
            {
                throw new Exception("File naming is invalid for this file: " + file);
            }
        }

        private string SplitString(string file, int item)
        {
            string[] response = file.Split('\\');
            Array.Reverse(response);
            return response[item];
        }

        private List<TVPathInfo> GetTVShowNames(List<string> directoryListing)
        {
            List<TVPathInfo> response = new List<TVPathInfo>();

            foreach (string item in directoryListing)
            {
                //Application.DoEvents();
                try
                {
                    string showName = Path.GetFileName(item);
                    string rootPath = item.Replace("\\" + showName, "");
                    response.Add(new TVPathInfo(DesortTHE(showName), item));
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception: " + ex.Message);
                }
            }

            List<string> namesOfShowsOnly = new List<string>();
            List<string> pathOfShowsOnly = new List<string>();

            foreach (TVPathInfo item in response)
            {
                //Application.DoEvents();
                namesOfShowsOnly.Add(item.ShowName);
                pathOfShowsOnly.Add(item.SeasonRootPath);
            }

            removeDuplicates(namesOfShowsOnly);
            removeDuplicates(pathOfShowsOnly);

            response = new List<TVPathInfo>();

            for (int i = 0; i < namesOfShowsOnly.Count; i++)
            {
                response.Add(new TVPathInfo(namesOfShowsOnly[i], pathOfShowsOnly[i]));
            }

            try
            {
                //response.Sort();
            }
            catch { }

            return response;
        }


        private void AddToLog(string text)
        {
            if (LogMessage != null) LogMessage(this,new MessageLoggedEventArgs() { Message = text,ThreadName = Thread.CurrentThread.Name });
        }
        private void processFile(string show, int season, int ep, string source)
        {
        }

        public void LoadDefaultRegEx()
        {
            TVShowRegx = new List<Regex>();
            TVShowRegx.Add(new Regex(@"\[[Ss]([0-9]+)\]_\[[Ee]([0-9]+)([^\\/]*)", RegexOptions.IgnoreCase));         // The.Sopranos.S01E02.randomstuff.avi 
            TVShowRegx.Add(new Regex(@"[\._ \-]([0-9]+)x([0-9]+)([^\\/]*)", RegexOptions.IgnoreCase));          // Dexter-2x02-random-stuff.avi                
            TVShowRegx.Add(new Regex(@"[\._ \-][Ss]([0-9]+)[\.\-]?[Ee]([0-9]+)([^\\/]*)", RegexOptions.IgnoreCase)); // Dead_Like_Me.111.random_stuff.avi
            TVShowRegx.Add(new Regex(@"[\._ \-]([0-9]+)([0-9][0-9])([\._ \-][^\\/]*)", RegexOptions.IgnoreCase)); // Dead_Like_Me.111.random_stuff.avi
            

        }
        
        public void ProcessList()
        {
            // the list could be written to while we loop, so we cannot just for each on it
            var list = watcherQue;
            
            var keepgoing = true;
            while (keepgoing)
            {
                if (Monitor.TryEnter(running, 1000))
                {
                    try
                    {
                        this.progressTodo = list.Count;
                        this.updateProgress();
                        // lets get the first file off the list
                        string filename;
                        lock (list)
                        {
                            if (list.Count > 0)
                            {
                                filename = list[0];
                            }
                            else
                            {
                                if (Done != null) Done(this,null); // done the entire list
                                return;
                            }
                        }
                        // work on this file, the list can be added to while we work
                        // also the file could be in use, so lets try to access it for RW
                        if (File.Exists(filename))
                        {
                            if (waitUntilFileNotLocked(filename))
                            {
                                // cool, not locked.
                                if (filename.StartsWith(this.ShowFolder))
                                {
                                    string directoryToScan = new FileInfo(filename).Directory.ToString();

                                    string temp1 = Path.GetDirectoryName(directoryToScan);
                                    string temp2 = Path.GetDirectoryName(temp1);

                                    string seasonName = Path.GetFileName(temp1);
                                    try
                                    {
                                        StartProcess(temp2, seasonName, GetSeasonNumber(directoryToScan), GetEpisode(new FileInfo(filename).Name.ToString()),false);

                                    }
                                    catch (Exception e)
                                    {
                                        AddToLog(e.Message);
                                    }
                                }
                                else
                                {
                                    processDropFile(filename);
                                }

                            }
                            else
                            {
                                // we could get stuck if the file never gets freeed
                            }
                        }
                        lock (list)
                        {
                            list.Remove(filename);
                            removeDuplicates (list);                            
                        }
                        this.progressTodo = list.Count;
                        this.updateProgress(1);
                        if (list.Count > 0) keepgoing = true;
                    }
                    finally
                    {                        
                        Monitor.Exit(running);
                    }
                }
                else
                {
                    System.Diagnostics.Trace.WriteLine("Que waiting");
                }
            }
            filesJustMoved = new List<string>();
            if (Done != null) Done(this,null); // done the entire list
        }

        private bool waitUntilFileNotLocked(string filename)
        {
            // I am sure this can be done better, its a little crude...
            
            int i = 0;
            while (i<10)
            {
                try
                {
                    using (var f = System.IO.File.Open(filename, FileMode.Open, FileAccess.ReadWrite, FileShare.None)) { };
                    return true;
                }
                catch
                {
                    // still locked, keep going..
                }
                System.Threading.Thread.Sleep(1000);
                i++;                
            }
            return false;
        }
        
        static List<string> removeDuplicates(List<string> inputList)
        {
            for (int i = 0; i < inputList.Count; i++)
            {
                if (inputList.IndexOf(inputList[i]) != i)
                {
                    inputList.RemoveAt(i);
                }
            }
            
            return inputList;
        }
        
        private void setupWatcherEvents(FileSystemWatcher watcher)
        {
            watcher.Created += new
            FileSystemEventHandler(watcher_FileEvent);

            watcher.Changed += new
            FileSystemEventHandler(watcher_FileEvent);

            watcher.Renamed += new
            RenamedEventHandler(watcher_FileEvent);
        }

        public void StopWatcher()
        {
            if (watcher != null)
            {
                watcher.Dispose();
                watcher = null;
            }
            if (dropFolderWatcher != null)
            {
                dropFolderWatcher.Dispose();
                dropFolderWatcher = null;
            }
        }

        public void CreateWatcher()
        {
            watcher = new FileSystemWatcher();
            dropFolderWatcher = new FileSystemWatcher();

            setupWatcherEvents(watcher);
            setupWatcherEvents(dropFolderWatcher);

            watcher.Path = this.ShowFolder;
            dropFolderWatcher.Path = this.DropFolder;
            watcher.IncludeSubdirectories = true;
            watcher.EnableRaisingEvents = true;
            dropFolderWatcher.EnableRaisingEvents = true;
        }

        void watcher_FileEvent(object sender, FileSystemEventArgs e)
        {
            bool fileAdded = false;
            try
            {
                if (string.IsNullOrEmpty(e.Name))
                {
                    return;
                }
            }
            catch
            {
                return; // while testing I got an odd null error, if the above check fails, the rest of the code will not work
            }


            switch (new FileInfo(e.Name).Extension.ToLower())
            {
                case ".avi":
                    fileAdded = true;
                    break;
                case ".mkv":
                    fileAdded = true;
                    break;
                case ".mp4":
                    fileAdded = true;
                    break;
                case ".mpg":
                    fileAdded = true;
                    break;
                case ".mpeg":
                    fileAdded = true;
                    break;
                case ".divx":
                    fileAdded = true;
                    break;
                case ".wmv":
                    fileAdded = true;
                    break;
                case ".ogm":
                    fileAdded = true;
                    break;
                default:
                    fileAdded = false;
                    break;
            }

            if (fileAdded)
            {
                if (watcherQue.Contains(e.FullPath)) return;
                if (justDoneFile(e.FullPath))
                {
                    System.Diagnostics.Trace.WriteLine("Just done " + e.FullPath);
                    return;
                }
                if (Alert != null) Alert(this, new MessageLoggedEventArgs() { Title = "New file",Message = string.Format("File dropped {0}", e.Name) } );
                
                AddToLog("A new file was added: " + e.FullPath);
                string directoryToScan = new FileInfo(e.FullPath).Directory.ToString();
                AddToLog("Added directory to scan to queue: " + directoryToScan);
                lock (watcherQue)
                {
                    watcherQue.Add(e.FullPath);
                }
                // lets start the watcher thread if we need to
                if (watcherThread == null )
                {
                    watcherThread = new Thread(new ThreadStart(ProcessList));
                }
                if (!watcherThread.IsAlive)
                {
                    watcherThread = new Thread(new ThreadStart(ProcessList));
                    watcherThread.Start();
                }
            }
        }
    }

}
