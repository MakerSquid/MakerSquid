using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TVMetaDataFinder;
using System.IO;
using System.Threading;
using TVMetaDataFinderLib;
using System.Collections;

namespace UnitTests
{
    /// <summary>
    /// Summary description for UnitTest1 test
    /// </summary>
    [TestClass]
    public class Tests
    {

        const string rootDropFolder = @"D:\TVTESTING\DROP";
        const string rootDestFolder = @"D:\TVTESTING\TV";

        public Tests()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        public void CreateTestShow(string path,string show,int season,int ep)
        {
            Directory.CreateDirectory(path);
            path = Path.Combine(path, show);
            path = Path.Combine(path, "Season " + season);
            
            Directory.CreateDirectory(path);

            File.CreateText(Path.Combine(path, ep.ToString("00") + ".avi" )).Close();
            
        }

        public void CreateTestFile(string path)
        {
            File.CreateText( Path.Combine(rootDropFolder, path)).Close();
        }

        [TestMethod]
        public void FileNameformater()
        {
            MetaDataFinder_Accessor mdf = new MetaDataFinder_Accessor();
            mdf.ShowFormat = "{1}{2}{3}{4}{5}";            
            var filename = mdf.formatFileName("show", 1, 2, @"ep name/?<>\:*|","");
            // "show0102ep nameep.name"
            Assert.AreEqual("show0102ep name", filename);
        }

        [TestInitialize]
        public  void SetupTestData()
        {
            Directory.CreateDirectory(rootDropFolder);
            Directory.CreateDirectory(rootDestFolder);
        }

        [TestMethod]
        public void CheckDefaults()
        {
            // make sure the defaults are not changed.
            MetaDataFinder mdf = new MetaDataFinder();

            Assert.AreEqual(mdf.ForceRefresh, false);
            Assert.AreEqual(mdf.HideMetaData, true);
            Assert.AreEqual(mdf.SaveMetaData, true);
            Assert.AreEqual(mdf.SaveBannerArt, true);
            Assert.AreEqual(mdf.ExtractImage, true);
            Assert.AreEqual(mdf.RenameFiles, true);
            Assert.AreEqual(mdf.SaveMy, false);
            Assert.AreEqual(mdf.ShowFormat, "{3} - {4}");
        }

        [TestMethod]
        public void ProcessDropFolderWithFormatInfo()
        {
            CreateTestFile("Desperate.Housewives.S06E02.720p.HDTV.x264-CT.mkv");
            
            var mdf = createMDF();
            mdf.TVShowNameReplacers = this.GetDefaultShowNameReplacers();

            mdf.ShowFormat += " {5}";
            mdf.ProcessDropFolder();

            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"Desperate Housewives\Season 6\02 - Being Alive  (720p).mkv")), true);

        }

        [TestMethod]
        public void ProcessDropFolder()
        {
            // Lets create some test files
            CreateTestFile("dont fail.s01e01.avi");
            CreateTestFile("tvr-lost.s01e01.avi");
            CreateTestFile("Prison Break 3x02.avi");
            CreateTestFile("The.4400.s01e02.avi");
            

            MetaDataFinder mdf = createMDF();
            mdf.RenameFiles = false; // check to see of override works
            mdf.TVShowNameReplacers = this.GetDefaultShowNameReplacers();

            mdf.ProcessDropFolder();

            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"Lost\Season 1\01 - Pilot (1).avi")), true);
            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"Prison Break\Season 3\02 - FireWater.avi")), true);
            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"The 4400\Season 1\02 - The New & Improved Carl Morrissey.avi")), true);
        }

        [TestMethod]
        public void DropFolderEvents()
        {
            var mdf = createMDF();
            mdf.CreateWatcher();
            AutoResetEvent waitHandle = new AutoResetEvent(false);
            mdf.Done += delegate
                        {
                            waitHandle.Set();
                        };
            // now lets wait for our file
            CreateTestFile("reaper.103.avi");
            CreateTestFile("lost.103.avi");
            waitHandle.WaitOne();      
                  
            CreateTestFile("lost.104.avi");
            waitHandle.WaitOne();
//sdr
            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"Reaper\Season 1\03 - All Mine.avi")), true);
            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"Lost\Season 1\03 - Tabula Rasa.avi")), true);

            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"Lost\Season 1\04 - Walkabout.avi")), true);

        }


        //[TestMethod], takes to long...
        public void ProcessDropFolderThreadTest()
        {
            // Lets create some test files
            CreateTestFile("Lost.s01e01.avi");

            MetaDataFinder mdf = createMDF();
            mdf.ForceRefresh = true;
            mdf.SaveBannerArt =true;
            mdf.ExtractImage = true;
            mdf.ThreadCount = 4;
            mdf.ProcessDropFolder();

            DateTime startTime = System.DateTime.Now;
            mdf.ThreadCount = 1;
            mdf.ProcessShows();
            TimeSpan ts = System.DateTime.Now - startTime;
            

            startTime = System.DateTime.Now;
            mdf.ThreadCount = 4;
            mdf.ProcessShows();
            var ts2 = System.DateTime.Now - startTime;

            System.Diagnostics.Trace.WriteLine(string.Format("T1 {0}", ts.TotalSeconds));
            System.Diagnostics.Trace.WriteLine(string.Format("T16 {0}", ts2.TotalSeconds));

            
        }


        private MetaDataFinder createMDF()
        {
            MetaDataFinder mdf = new MetaDataFinder();
            mdf.ExtractImage = false; // For Speed
            mdf.SaveBannerArt = false;

            mdf.DropFolder = rootDropFolder;
            mdf.ShowFolder = rootDestFolder;

            mdf.LogMessage +=new EventHandler<MessageLoggedEventArgs>(mdf_LogMessage);
            mdf.LoadDefaultRegEx();
            return mdf;
        }

        private MetaDataFinder_Accessor createMDF_a()
        {
            var mdf = new MetaDataFinder_Accessor();
            mdf.ExtractImage = false; // For Speed
            mdf.SaveBannerArt = false;

            mdf.DropFolder = rootDropFolder;
            mdf.ShowFolder = rootDestFolder;

           // mdf.LogMessage += new EventHandler<MessageLoggedEventArgs>(mdf_LogMessage);
            mdf.LoadDefaultRegEx();
            return mdf;
        }


        [TestMethod]
        public void TestFileNameExtraction()
        {
            MetaDataFinder mdf  = createMDF();
            FileNameParser fnp = new FileNameParser();

            fnp.DropFolder = mdf.DropFolder;
            fnp.ShowFolder = mdf.ShowFolder;
            fnp.TVShowRegx = mdf.TVShowRegx;
            
            fnp.TVShowNameReplacers = GetDefaultShowNameReplacers();

            fnp.ExtractDetails("dont fail.s01e02.avi");

            //fnp.ExtractDetails("tpz-ttscc.222.avi");
            //Assert.AreEqual(fnp.Show, "Terminator The Sarah Connor Chronicles");

            //fnp.ExtractDetails("tpz-ttscc222.avi");
            //Assert.AreEqual(fnp.Show, "Terminator The Sarah Connor Chronicles");


            fnp.ExtractDetails("tvr-lost.s01e02.avi");
            Assert.AreEqual(fnp.Show, "Lost");
            
            fnp.ExtractDetails("merlin.2008.s01e03.avi");
            Assert.AreEqual(fnp.Show, "Merlin (2008)");
            
            fnp.ExtractDetails("merlin.s01e04.avi");
            Assert.AreEqual(fnp.Show, "Merlin (2008)");

            fnp.ExtractDetails("the.x.factor.uk.s01e04.avi");
            Assert.AreEqual(fnp.Show, "The X Factor");


            fnp.ExtractDetails("Ben 10 1x01-1x02 Ben 10 Returns");
            Assert.AreEqual(fnp.Show ,"Ben 10");
            Assert.AreEqual(fnp.SeasonNo ,1);
            Assert.AreEqual(fnp.EpNo , 1);
            
            
        }

        private Dictionary<string, string> GetDefaultShowNameReplacers()
        {
            var tVShowReplacer = new Dictionary<string, string>();
            tVShowReplacer.Add("merlin$", "merlin 2008");
            tVShowReplacer.Add("x factor uk$", "x factor");
            tVShowReplacer.Add(@"^\w+-", "");
            tVShowReplacer.Add("ttscc", "The Sarah Connor Chronicles");

            return tVShowReplacer;
        }

        void mdf_LogMessage(object sender, MessageLoggedEventArgs e)
        {
            System.Diagnostics.Trace.WriteLine(e.Message );
        }

        [TestMethod]
        public void NewShow()
        {
            NewShows ns = new NewShows();
            CreateTestShow(rootDestFolder, "Dont Crash", 2, 22);
            //CreateTestShow(rootDestFolder, "Chuck", 2, 20);
            CreateTestShow(rootDestFolder, "Lost", 1, 3);
            
            ns.ShowFolder = rootDestFolder;
            ns.FindNewShows();
            
            
            Assert.AreEqual(ns.Shows.Lookup("Lost").SuggestedSeason , 1);
            Assert.AreEqual(ns.Shows.Lookup("Lost").SuggestedEp, 4);
            //Assert.AreEqual(ns.Shows.Lookup("Chuck").SuggestedEp ,21);
            //Assert.AreEqual(ns.Shows.Lookup("Chuck").SuggestedSeason , 2);
        }

        [TestMethod]
        public void RefreshShows()
        {
            var mdf = createMDF();
            mdf.RenameFiles = true;
            mdf.PromptEachFile = false;
            mdf.SaveBannerArt = true;
            

            CreateTestShow(rootDestFolder, "CSI NY", 6, 1);
            CreateTestShow(rootDestFolder, "NOT A SHOW", 6, 1);
            mdf.ProcessShows();

            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"CSI NY\Season 6\01 - Epilogue.avi")), true);


        }

        [TestMethod]
        public void TestOnRootShow()
        {
            var mdf = createMDF();
            mdf.RenameFiles = true;
            mdf.PromptEachFile = false;
            mdf.SaveBannerArt = true;

            mdf.ShowFolder = rootDestFolder + @"\CSI NY";

            CreateTestShow(rootDestFolder, "CSI NY", 6, 1);
            
            mdf.ProcessShows();

            Assert.AreEqual(File.Exists(Path.Combine(rootDestFolder, @"CSI NY\Season 6\01 - Epilogue.avi")), true);


        }


        [TestMethod]
        public void TestEpisodeExtractor()
        {
            var mdf = createMDF_a();

            // this is for shows in the show folder
            // we only support 01 - abc or 01x02 abc


            Assert.AreEqual(04, MetaDataFinder_Accessor.GetEpisode("02x04 Lancelot and Guinevere"));
            Assert.AreEqual(12, MetaDataFinder_Accessor.GetEpisode("S01E12 - No Brainer x"));
            Assert.AreEqual(2, MetaDataFinder_Accessor.GetEpisode("s1e02 - dfsfd 01 sds"));
            Assert.AreEqual(2, MetaDataFinder_Accessor.GetEpisode("s2e02 - dfsfd 01 sds"));
            Assert.AreEqual(1, MetaDataFinder_Accessor.GetEpisode("01 - dfsfd 01 sds"));
            Assert.AreEqual(1, MetaDataFinder_Accessor.GetEpisode("Show 1x01 - dfsfd 01 sds"));
            Assert.AreEqual(2, MetaDataFinder_Accessor.GetEpisode("01x02 - test"));
            Assert.AreEqual(4, MetaDataFinder_Accessor.GetEpisode("01x04 - dfsfd 01 sds"));
            Assert.AreEqual(4, MetaDataFinder_Accessor.GetEpisode("Show Name 01x04 - dfsfd 01 sds"));
            Assert.AreEqual(4, MetaDataFinder_Accessor.GetEpisode("Show Name 01x04 - ep name 01 01"));
            Assert.AreEqual(4, MetaDataFinder_Accessor.GetEpisode("Show Name 04 - ep name 12 12"));

            Assert.AreEqual(2, MetaDataFinder_Accessor.GetEpisode("02 - dfsfd 01 sds"));
            
        }



        [TestCleanup]
        public  void TidyTestData()
        {
            try
            {
                Directory.Delete(rootDestFolder, true);
                Directory.Delete(rootDropFolder, true);
            }
            catch
            { }

        }
    }
}
