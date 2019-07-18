using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using System.Reflection;
using System.Diagnostics;
using System.IO;
using TVMetaDataFinder.DataTypes;
using System.Text.RegularExpressions;
using TVMetaDataFinderLib;

namespace TVMetaDataFinder
{
    public partial class frmMain : Form
    {

        private ShowMenuExtenion[] showmenuExtenions = null;
        List<string> watcherQue = new List<string>();

        Label[] tLabels = new Label[25];

        public string lastDirectory = string.Empty;

        List<Regex> matchers = new List<Regex>();
        Dictionary<string, string> tVShowReplacer = new Dictionary<string, string>();
        private MetaDataFinder mdf = new MetaDataFinder();
        NewShows ns = new NewShows();

        public frmMain()
        {
            InitializeComponent();
            btnAdvanced_Click(null, null);
            btnAdvanced_Click(null, null);
            this.ntfMonitor.Visible = true;
            this.tmrUpdateUI.Enabled = true;
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            this.Text = "TV Meta Data Finder - " + GetCurrentVersionString();
            txtStatus.Text = txtStatus.Text.Replace("%ver%", GetCurrentVersionString());
            mdf.LogMessage += new EventHandler<MessageLoggedEventArgs>(mdf_LogMessage);
            mdf.UpdateProgress += new EventHandler<UpdateProgressEventArgs>(mdf_UpdateProgress);
            mdf.Alert += new EventHandler<MessageLoggedEventArgs>(mdf_Alert);
            mdf.RenamePrompt += new EventHandler(mdf_RenamePrompt);
            PopulateStartingText();
            for (int i = 0; i < 20; i++)
            {

                tLabels[i] = new Label() { Text = String.Format("Thread {0}", i) };
                tLabels[i].Width = flowLayoutPanel1.Width - flowLayoutPanel1.Padding.Right;
                flowLayoutPanel1.Controls.Add(tLabels[i]);
            }

            GetConfig();
        }

        void mdf_RenamePrompt(object sender, EventArgs e)
        {
            var frm = new frmRenamePreview();
            frm.RenameList = mdf.renameList;
            var result =  frm.ShowDialog();
            if (result == DialogResult.Cancel) mdf.renameList.Clear();
        }

        void mdf_Alert(object sender, MessageLoggedEventArgs e)
        {
            if (this.InvokeRequired)
            {
                this.Invoke((Action)delegate()
                {
                    ntfMonitor.ShowBalloonTip(4000,e.Title ,e.Message ,ToolTipIcon.Info );
                });
            }
        }

        static Dictionary<int,int> threadIds = new Dictionary<int,int>();

        void mdf_LogMessage(object sender, MessageLoggedEventArgs e)
        {
            try
            {
                var currentT = Thread.CurrentThread.ManagedThreadId;

                if (threadIds.ContainsKey(currentT))
                {
                    currentT = threadIds[currentT];
                }
                else
                {
                    lock (threadIds)
                    {

                        threadIds.Add(currentT, threadIds.Count);
                        currentT = threadIds.Count - 1;

                    }
                }
                if (this.InvokeRequired)
                {
                    this.Invoke((Action)delegate()
                    {
                        int iout;
                        tLabels[currentT].Text = e.Message;
                    });
                }
                AddToLog(e.Message);
            }
            catch(Exception ee)
            {
                System.Diagnostics.Trace.WriteLine(ee.Message);
            }
        }

        void mdf_UpdateProgress(object sender, UpdateProgressEventArgs e)
        {
            var max = e.Total;
            var val = e.Current;
            if (val > max) max = val + 1;

            if (this.InvokeRequired)
            {
                this.Invoke((Action)delegate()
                {
                    this.prgStatus.Maximum = max;
                    this.prgStatus.Value = val;
                });
            }
        }

        private void PopulateStartingText()
        {
            /*
            StringBuilder sbStartingText = new StringBuilder();
            sbStartingText.Append("================================================================================\r\n");
            sbStartingText.Append("Welcome to the TV Meta Data Finder - Version ");
            sbStartingText.Append(Assembly.GetEntryAssembly().GetName().Version.Major.ToString() + "." +
                Assembly.GetEntryAssembly().GetName().Version.Minor.ToString() + "." +
                Assembly.GetEntryAssembly().GetName().Version.Build.ToString() + "." +
                Assembly.GetEntryAssembly().GetName().Version.Revision.ToString());
            sbStartingText.Append("\r\n");
            sbStartingText.Append("\r\n");
            sbStartingText.Append("Use this application at your own risk, there is no warranty, or guarantee for\r\n");
            sbStartingText.Append("this software.\r\n");
            sbStartingText.Append("\r\n");
            sbStartingText.Append("This software uses the XML based web service found from: <http://thetvdb.com/>.\r\n");
            sbStartingText.Append("\r\n");
            sbStartingText.Append("If this application does not find your TV information, <http://thetvdb.com/>\r\n");
            sbStartingText.Append("suggests that you add it to their site as a contribution.\r\n");
            sbStartingText.Append("\r\n");
            sbStartingText.Append("This is a beta release, the following features have been added:\r\n");
            sbStartingText.Append("This is a beta release:\r\n");
            sbStartingText.Append("\r\n");
            sbStartingText.Append("To use this software:\r\n");
            sbStartingText.Append("1.\tClick Browse to find the directory to your video files\r\n");
            sbStartingText.Append("2.\tSelect the format you want the files to be renamed\r\n");
            sbStartingText.Append("3.\tIf you want the files to be renamed, select the Rename Files checkbox\r\n");
            sbStartingText.Append("4.\tIf you want to be prompted with what the file will be renamed to,\r\n");
            sbStartingText.Append("  \tselect Prompt Each File\r\n");
            sbStartingText.Append("5.\tIf you want the Meta Data to also be stored in the metadata folder,\r\n");
            sbStartingText.Append("  \tcheck the Save Meta Data check box.\r\n");
            sbStartingText.Append("6.\tClick Start.\r\n");
            sbStartingText.Append("\r\n");
            sbStartingText.Append("For more information go to http://www.wmediacenter.com\r\n");
            sbStartingText.Append("================================================================================\r\n");
            this.txtStatus.Text = sbStartingText.ToString();*/
        }

        private void GetConfig()
        {
            // lets make sure of setting folder exsits
            var path = Path.Combine(Environment.GetFolderPath(System.Environment.SpecialFolder.ApplicationData), "TVMetaDataFinder");
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);
            path = Path.Combine(path, "UISettings.xml");
            if (!File.Exists(path))
            {
                MessageBox.Show("This is the first run of the application, please read the readme for usage tips. Using default settings");
                if (File.Exists("UISettings.xml"))
                {
                    File.Copy("UISettings.xml", path);
                }
                else
                {
                    MessageBox.Show("Default settings not found");
                }

            }

            UISettings uiSettings = UISettings.IO.GetDataFromXML(path);

            this.txtGetDirectory.Text = uiSettings.DefaultDirectory;
            this.txtDropFolder.Text = uiSettings.DropFolder;
            this.cmbFormat.Text = uiSettings.FileFormat;
            
            if (cmbFormat.SelectedIndex == -1)
            {
                // must be a custom format
                cmbFormat.SelectedIndex = cmbFormat.Items.Count - 1;
            }
            this.chkForceRefresh.Checked = uiSettings.ForceRefresh;
            this.chkPromptEachFile.Checked = uiSettings.PromptEachFilesChecked;
            this.chkRenameFiles.Checked = uiSettings.RenameFilesChecked;
            this.chkSaveMetaData.Checked = uiSettings.SaveMetaData;
            this.chkMinimizeToTray.Checked = uiSettings.MiminimizeToTray;
            this.lastDirectory = uiSettings.LastDirectory;
            this.chkSaveBannerArt.Checked = uiSettings.SaveBannerArt;
            this.chkHideMetaData.Checked = uiSettings.HideMetaData;
            this.txtOtherFormat.Text = uiSettings.OtherFileFormat;
            if (txtOtherFormat.Text.StartsWith("{1}")) cbPrefixwithshow.Checked = true;
            this.chkExtractImage.Checked = uiSettings.ExtractFromVideo;
            this.chkCheckForUpdates.Checked = uiSettings.CheckForUpgrade;
            this.chkSaveMyFile.Checked = uiSettings.SaveMyFile;
            this.txtOtherFormat.Text = getShowString();
            if (this.txtOtherFormat.Text.Length == 0)
            {
                this.txtOtherFormat.Text = "{3} - {4}";
            }

            

            if ((uiSettings.TVShowExtractor != null) && (uiSettings.TVShowExtractor.Length > 0))
            {
                foreach (var reg in uiSettings.TVShowExtractor)
                {
                    matchers.Add(new Regex(reg, RegexOptions.IgnoreCase));
                }
            }

            else
            {
                matchers.Add(new Regex(@"\[[Ss]([0-9]+)\]_\[[Ee]([0-9]+)([^\\/]*)", RegexOptions.IgnoreCase));         // The.Sopranos.S01E02.randomstuff.avi                
                matchers.Add(new Regex(@"[\._ \-]([0-9]+)x([0-9]+)([^\\/]*)", RegexOptions.IgnoreCase));          // Dexter-2x02-random-stuff.avi                
                matchers.Add(new Regex(@"[\._ \-][Ss]([0-9]+)[\.\-]?[Ee]([0-9]+)([^\\/]*)", RegexOptions.IgnoreCase)); // Dead_Like_Me.111.random_stuff.avi
                matchers.Add(new Regex(@"[\._ \-]([0-9]+)([0-9][0-9])([\._ \-][^\\/]*)", RegexOptions.IgnoreCase)); // Dead_Like_Me.111.random_stuff.avi
            }

            if ((uiSettings.TVShowReplacer != null) && (uiSettings.TVShowReplacer.Length > 0))
            {
                tVShowReplacer = new Dictionary<string, string>();
                foreach (var tvsr in uiSettings.TVShowReplacer)
                {
                    tVShowReplacer.Add(tvsr.SearchFor, tvsr.ReplaceWith);
                }
            }
            else
            {
                tVShowReplacer = new Dictionary<string, string>();
                tVShowReplacer.Add(@"merlin$", "merlin 2008");
                tVShowReplacer.Add(@"x factor uk$", "x factor");
                tVShowReplacer.Add(@"^\w+-", "");
            }
            this.showmenuExtenions = uiSettings.ShowMenuExtenions;
            if (uiSettings.ShowMenuExtenions != null)
            {
                foreach (ShowMenuExtenion m in uiSettings.ShowMenuExtenions)
                {

                    var newmenu = contextMenuStrip2.Items.Add(m.MenuName);
                    newmenu.Tag = m.Action;
                    newmenu.Click += new EventHandler(newmenu_Click);
                }
            }

            cmbFormat_SelectedIndexChanged(null, null);

            


            if (cmbFormat.SelectedIndex == -1) { cmbFormat.SelectedIndex = 0; }
        }

        void newmenu_Click(object sender, EventArgs e)
        {
            var menu = sender as ToolStripItem;
            navTo(menu.Tag.ToString());
        }

        private string GetCurrentVersionString()
        {
            return
                Assembly.GetEntryAssembly().GetName().Version.Major.ToString() + "." +
                Assembly.GetEntryAssembly().GetName().Version.Minor.ToString() + "." +
                Assembly.GetEntryAssembly().GetName().Version.Build.ToString() + "." +
                Assembly.GetEntryAssembly().GetName().Version.Revision.ToString();
        }

        private void btnStart_Click(object sender, EventArgs e)
        {
            Program.FileFormatRenameSelectedIndex = this.cmbFormat.SelectedIndex;
            if (this.txtGetDirectory.Text.Length > 0)
            {
                this.backgroundWorker1.RunWorkerAsync("shows");
            }
        }

        private void btnAdvanced_Click(object sender, EventArgs e)
        {
            if (this.btnAdvanced.Text.Equals("Advanced >>"))
            {
                this.btnAdvanced.Text = "<< Hide";
                this.Width = 717;
                this.Height = 598;

                this.tbcInfo.Visible = true;
               // this.tbcInfo.Width = 685;
                this.tbcInfo.Height = 452;

                this.FormBorderStyle = FormBorderStyle.Sizable;
                this.MaximizeBox = true;
            }
            else
            {
                this.btnAdvanced.Text = "Advanced >>";

                this.Width = 691;
                this.Height = 180;

                this.tbcInfo.Visible = false;
                //this.tbcInfo.Width = 685;
                //this.tbcInfo.Height = 452;

                this.FormBorderStyle = FormBorderStyle.FixedSingle;
                this.MaximizeBox = false;
            }
        }

        private void cmbFormat_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.txtOtherFormat.Text = getShowString();
        }

        string getShowString()
        {
            var rval = "";
            txtOtherFormat.Enabled = false;
            switch (this.cmbFormat.SelectedIndex)
            {
                case 0:
                    rval = "{3} - {4}";
                    break;
                case 1:
                    rval = "{2}x{3} - {4}";
                    break;
                case 2:
                    rval = "{3} - {4} ({5})";
                    break;
                case 3:
                    rval = "{2}x{3} {4} - ({5})";
                    break;
                case 4:
                    rval = "S{2}E{3} - {4}";
                    break;
                default :
                    txtOtherFormat.Enabled = true;
                    return txtOtherFormat.Text;
                    break;
            }
            if (cbPrefixwithshow.Checked) rval = "{1} - " + rval;
            return rval;
        }

        private void frmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            UISettings uiSettings = new UISettings();

            uiSettings.DefaultDirectory = this.txtGetDirectory.Text;
            uiSettings.DropFolder = this.txtDropFolder.Text;
            uiSettings.FileFormat = this.cmbFormat.Text;
            uiSettings.ForceRefresh = this.chkForceRefresh.Checked;
            uiSettings.PromptEachFilesChecked = this.chkPromptEachFile.Checked;
            uiSettings.RenameFilesChecked = this.chkRenameFiles.Checked;
            uiSettings.SaveMetaData = this.chkSaveMetaData.Checked;
            uiSettings.MiminimizeToTray = this.chkMinimizeToTray.Checked;
            uiSettings.LastDirectory = this.lastDirectory;
            uiSettings.SaveBannerArt = this.chkSaveBannerArt.Checked;
            uiSettings.HideMetaData = this.chkHideMetaData.Checked;
            uiSettings.ExtractFromVideo = this.chkExtractImage.Checked;
            uiSettings.OtherFileFormat = this.txtOtherFormat.Text;
            uiSettings.CheckForUpgrade = this.chkCheckForUpdates.Checked;
            uiSettings.SaveMyFile = this.chkSaveMyFile.Checked;
            uiSettings.TVShowExtractor = matchers.Select(s => s.ToString()).ToArray();
            uiSettings.TVShowReplacer = tVShowReplacer.Select( s => new UISettings.SearchAndReplace(s.Key , s.Value ) ).ToArray();
            uiSettings.ShowMenuExtenions = showmenuExtenions;

            var path = Path.Combine(Environment.GetFolderPath(System.Environment.SpecialFolder.ApplicationData), "TVMetaDataFinder");
            if (!Directory.Exists(path)) Directory.CreateDirectory(path);
            path = Path.Combine(path, "UISettings.xml");

            UISettings.IO.SaveDataXML(uiSettings, path);
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new frmAbout().ShowDialog();
        }

        private void pctDonate_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Please make a donation to this applications future.  The next major release of this application (v2.0) will require its own servers, thus will be more stable, and much faster.  Please support this product.\r\n\r" +
                          "I will take you to the donations page once you click ok.  Donations will be sent via PayPal and to my email address billsecond@yahoo.com" +
                          "\r\n\rThanks!\r\n\r\n-Bill");
            Process.Start("http://wmediacenter.com/whereamifrom/?Action=DonateToTVMetaDataFinder&dl=https://www.paypal.com/cgi-bin/webscr%3fcmd=_s-xclick%26hosted_button_id=111904");

        }

        private void lbllnkDonate_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            pctDonate_Click(sender, null);
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            pctDonate_Click(sender, null);
        }

        private void tlsHelp_Click(object sender, EventArgs e)
        {
            Process.Start("http://wmediacenter.com/whereamifrom/?Action=ViewHelpFromApp" + GetCurrentVersionString() + "&dl=http://tvmetadatafinder.com/apphelp/%3fHelpVersion=" + GetCurrentVersionString() + "%26MachineID=" + MachineIdentification.GetMachineID());
        }

        private void txtStartStopMonitor_Click(object sender, EventArgs e)
        {
            
            if (txtStartStopMonitor.Text.Equals("Monitor"))
            {
                Program.FileFormatRenameSelectedIndex = this.cmbFormat.SelectedIndex;
                this.txtStartStopMonitor.Text = "Monitoring";
                panel1.Enabled = false;
                label10.Visible = true;
                setupMDF();

                mdf.CreateWatcher();
                this.startStopMonitorToolStripMenuItem.Checked = true;
            }
            else
            {
                label10.Visible = false;
                panel1.Enabled = true;
                Program.FileFormatRenameSelectedIndex = this.cmbFormat.SelectedIndex;
                this.txtStartStopMonitor.Text = "Monitor";
                mdf.StopWatcher();
                this.startStopMonitorToolStripMenuItem.Checked = false;
                
            }
        }

        private void setupMDF()
        {
            mdf.DropFolder = txtDropFolder.Text;
            mdf.ShowFolder = txtGetDirectory.Text;
            mdf.ForceRefresh = chkForceRefresh.Checked;
            mdf.HideMetaData = chkHideMetaData.Checked;
            mdf.SaveMetaData = chkSaveMetaData.Checked;
            mdf.SaveBannerArt = chkSaveBannerArt.Checked;
            mdf.ExtractImage = chkExtractImage.Checked;
            mdf.RenameFiles = chkRenameFiles.Checked;
            mdf.SaveMy = chkSaveMyFile.Checked;
            mdf.ShowFormat = txtOtherFormat.Text;
            mdf.TVShowRegx = matchers;
            mdf.PromptEachFile = chkPromptEachFile.Checked;
            mdf.TVShowNameReplacers = tVShowReplacer;
        }

       

       
        private void AddToLog(string text)
        {

            lock (Program.AppendToLog)
            {
                Program.AppendToLog = DateTime.Now + ":  " + text + "\r\n" + Program.AppendToLog;
            }
            
        }

        private void browseToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.btnGetDirectory_Click(sender, e);
        }

        private void startScanToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.btnStart_Click(sender, e);
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void startStopMonitorToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.txtStartStopMonitor_Click(sender, e);
        }

        private void frmMain_Resize(object sender, EventArgs e)
        {
            if (FormWindowState.Minimized == this.WindowState)
            {
                if (this.chkMinimizeToTray.Checked)
                {
                    this.ntfMonitor.BalloonTipText = "TV Meta Data Finder is still running...";
                    this.ntfMonitor.BalloonTipTitle = "TV Meta Data Finder";
                    this.ntfMonitor.BalloonTipIcon = ToolTipIcon.Info;
                    this.ntfMonitor.ShowBalloonTip(800);

                    this.Hide();
                }
            }
        }

        private void tmrUpdateUI_Tick(object sender, EventArgs e)
        {
            if (Program.AppendToLog.Length > 0)
            {
                string stringToAddToLog = Program.AppendToLog;
                Program.AppendToLog = string.Empty;
                this.txtStatus.Text = stringToAddToLog + this.txtStatus.Text;
            }

        }

        private void tmrStatus_Tick(object sender, EventArgs e)
        {
            Program.DateTimeStopTimer = DateTime.Now;
            TimeSpan duration = Program.DateTimeStopTimer - Program.DateTimeStartTimer;
            this.txtTimerStatus.Text =
                duration.Days.ToString("0") + ":" +
                duration.Hours.ToString("00") + ":" +
                duration.Minutes.ToString("00") + ":" +
                duration.Seconds.ToString("00");
        }

        private void ntfMonitor_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            this.Show();
            this.WindowState = FormWindowState.Normal;
            this.ntfMonitor.Visible = false;
        }

        private void btnGetDirectory_Click(object sender, EventArgs e)
        {
            string targetDirectory = string.Empty;

            using (FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog())
            {
                folderBrowserDialog.ShowNewFolderButton = true;
                folderBrowserDialog.Description = "Select the folder where your TV shows are located";
                folderBrowserDialog.SelectedPath = this.lastDirectory;
                DialogResult folderBrowserDialogResult = folderBrowserDialog.ShowDialog();

                if (folderBrowserDialogResult != DialogResult.OK)
                {
                    return;
                }

                targetDirectory = folderBrowserDialog.SelectedPath;
                lastDirectory = targetDirectory;
                this.txtGetDirectory.Text = targetDirectory;

                AddToLog("Changed Root Directory To: " + targetDirectory);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string targetDirectory = string.Empty;

            using (FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog())
            {
                folderBrowserDialog.ShowNewFolderButton = true;
                folderBrowserDialog.Description = "Select the folder where your TV shows are located";
                DialogResult folderBrowserDialogResult = folderBrowserDialog.ShowDialog();

                if (folderBrowserDialogResult != DialogResult.OK)
                {
                    return;
                }
                this.txtDropFolder.Text = folderBrowserDialog.SelectedPath;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.backgroundWorker1.RunWorkerAsync("drop");
        }
       
        private void processDropFolder(string path)
        {

        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            try
            {
                threadIds.Clear();
                string method = (string)e.Argument;

                if (this.InvokeRequired)
                {
                    this.Invoke((Action)delegate()
                    {
                        pnlStatus.Visible = true;
                        this.prgStatus.Visible = true;
                        this.btnStart.Enabled = false;
                        this.button2.Enabled = false;
                        this.btnGetDirectory.Enabled = false;
                        this.experimentsToolStripMenuItem.Enabled = false;
                        this.button1.Enabled = false;
                        this.button3.Enabled = false;
                    });
                }

                setupMDF();


                if (method.Equals("shows"))
                {

                    //                StartProcess(this.txtGetDirectory.Text, string.Empty, -1, -1);
                    mdf.ProcessShows();
                }
                if(method.Equals("drop"))
                {
                    //processDropFolder(this.txtDropFolder.Text);
                    mdf.ProcessDropFolder();
                }
                if (method.Equals("newshows"))
                {
                    setupMDF();                    
                    ns.ShowFolder = mdf.ShowFolder;
                    
                    ns.FindNewShows();
                   
                }

            }
            catch
            {
                this.Invoke((Action)delegate()
                {
                    this.btnStart.Enabled = true;
                    button2.Enabled = true;
                });
            }
        }

       


        private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            this.Invoke((Action)delegate()
            {
                pnlStatus.Visible = false;
                this.prgStatus.Visible = false;
                this.btnStart.Enabled = true;
                button2.Enabled = true;
                experimentsToolStripMenuItem.Enabled = true;
                this.button1.Enabled = true;
                this.button3.Enabled = true;
                btnGetDirectory.Enabled = true;
                if ( ns.Shows != null && ns.Shows.Count > 0)
                {
                    this.newShowInfoListBindingSource.DataSource = ns.Shows;
                }
                this.dataNewShows.Refresh();

            });

            lock (watcherQue)
            {
                if (watcherQue.Count > 0)
                {
                    // lets do the que
                    backgroundWorker1.RunWorkerAsync("watch");
                }
            }

        }

        private void newShowsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.backgroundWorker1.RunWorkerAsync("newshows");
        }

        private void clearlogToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Program.AppendToLog = "";
            txtStatus.Text = "";
        }

        private void dataNewShows_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataNewShows_CellMouseDoubleClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            openinthetvdb();
        }

        private void openinthetvdb()
        {
            var show = newShowInfoListBindingSource.Current as NewShowInfo;
            var url = string.Format("http://www.thetvdb.com/?tab=series&id={0}", show.ShowID);
            navTo(url);
        }

        void openInCustomUrl()
        {

        }

        private void navTo(string url)
        {
            var show = newShowInfoListBindingSource.Current as NewShowInfo;

            Process proc = new System.Diagnostics.Process();
            proc.EnableRaisingEvents = false;
            url = url.Replace("{show}", show.ShowName);
            url = url.Replace("{eptowatch}", (show.SuggestedEp ).ToString("00"));
            url = url.Replace("{seasontowatch}", show.SuggestedSeason.ToString());

            proc.StartInfo.FileName = url;
            proc.Start();
        }


        private void menuOpenInTheTBDB_Click(object sender, EventArgs e)
        {
            openinthetvdb();
        }

        private void menuOpenIn_Click(object sender, EventArgs e)
        {
            openInCustomUrl();
        }

       
        private void dataNewShows_CellFormatting_1(object sender, DataGridViewCellFormattingEventArgs e)
        {
            try
            {
                if (newShowInfoListBindingSource.Count == 0) return;
                var show = newShowInfoListBindingSource[e.RowIndex] as NewShowInfo;
                if (show.NextSuggetionAired == System.DateTime.MinValue) return;
                var ts = show.NextSuggetionAired.Date - System.DateTime.Today.Date;

               
                if (ts.TotalDays >= -7)
                {
                    e.CellStyle.BackColor = Color.Orange;
                }
 
                if (ts.TotalDays == 0 || e.RowIndex == 0)
                {
                    e.CellStyle.BackColor = Color.Yellow;
                }

                if ((ts.TotalDays > 0) && (ts.TotalDays < 7))
                {
                    e.CellStyle.BackColor = Color.LightYellow;
                    return;
                }

                if (ts.TotalDays > 0)
                {
                    e.CellStyle.BackColor = Color.GreenYellow ;
                    return;
                }

                if (ts.TotalDays < 0)
                {
                    //e.CellStyle.BackColor = Color.Pink ;
                    return;
                }
            }
            catch { };

        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            this.backgroundWorker1.RunWorkerAsync("newshows");
        }

        private void dataNewShows_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {

        }

        private void cbPrefixwithshow_CheckedChanged(object sender, EventArgs e)
        {
            this.txtOtherFormat.Text = getShowString();
        }

        private void txtOtherFormat_Validating(object sender, CancelEventArgs e)
        {
            //04 - TV Show.avi
            //02x04 - TV Show.avi
            //04 - TV Show.avi (format)
            //02x04 - TV Show.avi (format)
            //S01E01 - TV Show.avi
            //Custom

            // rename a test show and extract the ep number
            MetaDataFinder mdf = new MetaDataFinder();
            mdf.ShowFormat  = txtOtherFormat.Text;
            var testFile = txtOtherFormat.Text;
            
            testFile = testFile.Replace("{2}", "2");
            testFile = testFile.Replace("{3}", "12");

            var newFile = mdf.formatFileName("Show", 2, 12, "Episode Name", testFile);
            // Now lets try to extract the epno
            var epNo = MetaDataFinder.GetEpisode(newFile);
            if (epNo != 12)
            {
                MessageBox.Show("If you used this format and processed the files twice you would end up with incorrectly named files, please post a comment on the website if you think this could be wrong");
                e.Cancel = true;
            }
        }

    }
}