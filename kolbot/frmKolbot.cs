using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Net;
using System.Text;
using System.IO;
using System.Xml;

namespace kolbot
{
    /// <summary>
    /// Summary description for Form1.
    /// </summary>
    public class frmKolbot : System.Windows.Forms.Form
    {
        private System.ComponentModel.IContainer components;
        public System.Windows.Forms.Label lblStatus;
        public System.Windows.Forms.Button btnConnect;
        public System.Windows.Forms.Button btnMessages;
        public System.Windows.Forms.Button btnSend;
        public System.Windows.Forms.Button btnCook;
        public System.Windows.Forms.Timer tmrMain;
        public System.Windows.Forms.Button btnAdventure;
        public System.Windows.Forms.Label lblAccount;
        public System.Windows.Forms.TextBox txtNumAdv;
        public System.Windows.Forms.TextBox txtPassword;
        public System.Windows.Forms.Label label1;
        public System.Windows.Forms.Label label2;
        public System.Windows.Forms.Label label3;
        public System.Windows.Forms.TextBox txtWhere;
        public System.Windows.Forms.Label label4;
        public System.Windows.Forms.ComboBox cmbWhere;
        public System.Windows.Forms.Button btnInventory;
        private System.Windows.Forms.Button btnSendResults;
        private System.Windows.Forms.ComboBox cmbRecipient;
        private System.Windows.Forms.CheckBox chkAutoSend;

        //globals
        public bool bLoading;
        public CookieCollection theCookies;
        public System.Windows.Forms.TextBox txtResult;
        public System.Windows.Forms.Button btnRest;
        public KolSystemData oSysData = new KolSystemData();
        public WebProxy theProxy = new WebProxy();
        public System.Windows.Forms.ComboBox cmbUser;
        public LocationData[] AdventurePlaces;
        public UserData[] Users;
        public ItemGain ResultItems = new ItemGain();
        public ItemGain TotalItem = new ItemGain();
        public StatGain ResultStats = new StatGain();
        private System.Windows.Forms.Button txtMallSearch;
        public static ItemGain ItemList = new ItemGain();
        private int nMallGain = 0;
        private System.Windows.Forms.Button btnCampItems;
        private System.Windows.Forms.Button btnEat;
        private System.Windows.Forms.Button btnPurchases;
        private System.Windows.Forms.Label lblFee;
        private System.Windows.Forms.Button btnHeal;
        private bool bStop;
        private System.Windows.Forms.Label label5;
        private string NoNotifyList;
        private System.Windows.Forms.Button btnAutomate;
        private System.Windows.Forms.CheckBox chkPurchase;
        private System.Windows.Forms.CheckBox chkCampground;
        private System.Windows.Forms.CheckBox chkAdventure;
        private System.Windows.Forms.CheckBox chkCook;
        private System.Windows.Forms.CheckBox chkSend;
        private System.Windows.Forms.CheckBox chkConsume;
        private System.Windows.Forms.CheckBox chkTransferAll;
        private bool bAutomated = false;
        private string[] clArgs = null;
        private bool bExitOnComplete = false;
        private string sLogName = string.Empty;
        private bool bLog = false;
        private System.Windows.Forms.Button btnViewInventory;
        public System.Windows.Forms.Button btnClanGet;
        private System.Windows.Forms.CheckBox chkGetClanItems;
        private System.Windows.Forms.Button btnTutorial;
        private TextWriter tw;

        public frmKolbot(string[] args)
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //

            clArgs = args;
            //foreach(string s in args)
            {
                //ProcessCLParam(s);
            }
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (this.bLog)
                CloseLog();
            if (disposing)
            {
                if (components != null)
                {
                    components.Dispose();
                }
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.btnConnect = new System.Windows.Forms.Button();
            this.btnMessages = new System.Windows.Forms.Button();
            this.btnSend = new System.Windows.Forms.Button();
            this.btnCook = new System.Windows.Forms.Button();
            this.lblStatus = new System.Windows.Forms.Label();
            this.tmrMain = new System.Windows.Forms.Timer(this.components);
            this.btnAdventure = new System.Windows.Forms.Button();
            this.lblAccount = new System.Windows.Forms.Label();
            this.txtNumAdv = new System.Windows.Forms.TextBox();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txtWhere = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cmbWhere = new System.Windows.Forms.ComboBox();
            this.txtResult = new System.Windows.Forms.TextBox();
            this.btnRest = new System.Windows.Forms.Button();
            this.cmbUser = new System.Windows.Forms.ComboBox();
            this.btnInventory = new System.Windows.Forms.Button();
            this.btnSendResults = new System.Windows.Forms.Button();
            this.cmbRecipient = new System.Windows.Forms.ComboBox();
            this.chkAutoSend = new System.Windows.Forms.CheckBox();
            this.txtMallSearch = new System.Windows.Forms.Button();
            this.btnCampItems = new System.Windows.Forms.Button();
            this.btnEat = new System.Windows.Forms.Button();
            this.btnPurchases = new System.Windows.Forms.Button();
            this.lblFee = new System.Windows.Forms.Label();
            this.btnHeal = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.btnAutomate = new System.Windows.Forms.Button();
            this.chkPurchase = new System.Windows.Forms.CheckBox();
            this.chkCampground = new System.Windows.Forms.CheckBox();
            this.chkAdventure = new System.Windows.Forms.CheckBox();
            this.chkCook = new System.Windows.Forms.CheckBox();
            this.chkSend = new System.Windows.Forms.CheckBox();
            this.chkConsume = new System.Windows.Forms.CheckBox();
            this.chkTransferAll = new System.Windows.Forms.CheckBox();
            this.btnViewInventory = new System.Windows.Forms.Button();
            this.btnClanGet = new System.Windows.Forms.Button();
            this.chkGetClanItems = new System.Windows.Forms.CheckBox();
            this.btnTutorial = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(352, 8);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(104, 23);
            this.btnConnect.TabIndex = 0;
            this.btnConnect.Text = "Connect";
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // btnMessages
            // 
            this.btnMessages.Enabled = false;
            this.btnMessages.Location = new System.Drawing.Point(208, 40);
            this.btnMessages.Name = "btnMessages";
            this.btnMessages.Size = new System.Drawing.Size(104, 23);
            this.btnMessages.TabIndex = 2;
            this.btnMessages.Text = "Monitor Msgs";
            this.btnMessages.Visible = false;
            this.btnMessages.Click += new System.EventHandler(this.btnMessages_Click);
            // 
            // btnSend
            // 
            this.btnSend.Enabled = false;
            this.btnSend.Location = new System.Drawing.Point(352, 184);
            this.btnSend.Name = "btnSend";
            this.btnSend.Size = new System.Drawing.Size(112, 23);
            this.btnSend.TabIndex = 3;
            this.btnSend.Text = "Send Messages";
            this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
            // 
            // btnCook
            // 
            this.btnCook.Enabled = false;
            this.btnCook.Location = new System.Drawing.Point(352, 216);
            this.btnCook.Name = "btnCook";
            this.btnCook.Size = new System.Drawing.Size(112, 23);
            this.btnCook.TabIndex = 4;
            this.btnCook.Text = "Cook";
            this.btnCook.Click += new System.EventHandler(this.btnCook_Click);
            // 
            // lblStatus
            // 
            this.lblStatus.Location = new System.Drawing.Point(8, 264);
            this.lblStatus.Name = "lblStatus";
            this.lblStatus.Size = new System.Drawing.Size(328, 32);
            this.lblStatus.TabIndex = 5;
            this.lblStatus.Text = "Click Connect to begin...";
            // 
            // tmrMain
            // 
            this.tmrMain.Interval = 60000;
            this.tmrMain.Tick += new System.EventHandler(this.tmrMain_Tick);
            // 
            // btnAdventure
            // 
            this.btnAdventure.Enabled = false;
            this.btnAdventure.Location = new System.Drawing.Point(352, 88);
            this.btnAdventure.Name = "btnAdventure";
            this.btnAdventure.Size = new System.Drawing.Size(104, 23);
            this.btnAdventure.TabIndex = 6;
            this.btnAdventure.Text = "Adventure";
            this.btnAdventure.Click += new System.EventHandler(this.btnAdventure_Click);
            // 
            // lblAccount
            // 
            this.lblAccount.Location = new System.Drawing.Point(192, 8);
            this.lblAccount.Name = "lblAccount";
            this.lblAccount.Size = new System.Drawing.Size(112, 23);
            this.lblAccount.TabIndex = 7;
            // 
            // txtNumAdv
            // 
            this.txtNumAdv.Location = new System.Drawing.Point(80, 120);
            this.txtNumAdv.Name = "txtNumAdv";
            this.txtNumAdv.Size = new System.Drawing.Size(56, 20);
            this.txtNumAdv.TabIndex = 8;
            this.txtNumAdv.Text = "200";
            // 
            // txtPassword
            // 
            this.txtPassword.Location = new System.Drawing.Point(72, 40);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.PasswordChar = '*';
            this.txtPassword.Size = new System.Drawing.Size(112, 20);
            this.txtPassword.TabIndex = 10;
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(8, 8);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 23);
            this.label1.TabIndex = 11;
            this.label1.Text = "User";
            // 
            // label2
            // 
            this.label2.Location = new System.Drawing.Point(8, 40);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(56, 23);
            this.label2.TabIndex = 12;
            this.label2.Text = "Password";
            // 
            // label3
            // 
            this.label3.Location = new System.Drawing.Point(8, 120);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(64, 23);
            this.label3.TabIndex = 13;
            this.label3.Text = "How Many?";
            // 
            // txtWhere
            // 
            this.txtWhere.Location = new System.Drawing.Point(296, 88);
            this.txtWhere.Name = "txtWhere";
            this.txtWhere.Size = new System.Drawing.Size(32, 20);
            this.txtWhere.TabIndex = 14;
            this.txtWhere.Text = "0";
            // 
            // label4
            // 
            this.label4.Location = new System.Drawing.Point(8, 88);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(64, 23);
            this.label4.TabIndex = 15;
            this.label4.Text = "Where?";
            // 
            // cmbWhere
            // 
            this.cmbWhere.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbWhere.Location = new System.Drawing.Point(80, 88);
            this.cmbWhere.Name = "cmbWhere";
            this.cmbWhere.Size = new System.Drawing.Size(208, 21);
            this.cmbWhere.Sorted = true;
            this.cmbWhere.TabIndex = 16;
            this.cmbWhere.SelectedIndexChanged += new System.EventHandler(this.cmbWhere_SelectedIndexChanged);
            // 
            // txtResult
            // 
            this.txtResult.Location = new System.Drawing.Point(472, 16);
            this.txtResult.Multiline = true;
            this.txtResult.Name = "txtResult";
            this.txtResult.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtResult.Size = new System.Drawing.Size(272, 240);
            this.txtResult.TabIndex = 17;
            // 
            // btnRest
            // 
            this.btnRest.Enabled = false;
            this.btnRest.Location = new System.Drawing.Point(352, 120);
            this.btnRest.Name = "btnRest";
            this.btnRest.Size = new System.Drawing.Size(104, 23);
            this.btnRest.TabIndex = 18;
            this.btnRest.Text = "Rest(1)";
            this.btnRest.Click += new System.EventHandler(this.btnRest_Click);
            // 
            // cmbUser
            // 
            this.cmbUser.Location = new System.Drawing.Point(72, 8);
            this.cmbUser.Name = "cmbUser";
            this.cmbUser.Size = new System.Drawing.Size(112, 21);
            this.cmbUser.TabIndex = 19;
            this.cmbUser.Text = "Select User...";
            this.cmbUser.SelectedIndexChanged += new System.EventHandler(this.cmbUser_SelectedIndexChanged);
            // 
            // btnInventory
            // 
            this.btnInventory.Location = new System.Drawing.Point(352, 264);
            this.btnInventory.Name = "btnInventory";
            this.btnInventory.Size = new System.Drawing.Size(112, 23);
            this.btnInventory.TabIndex = 20;
            this.btnInventory.Text = "Transfer Inventory";
            this.btnInventory.Click += new System.EventHandler(this.btnInventory_Click);
            // 
            // btnSendResults
            // 
            this.btnSendResults.Enabled = false;
            this.btnSendResults.Location = new System.Drawing.Point(672, 264);
            this.btnSendResults.Name = "btnSendResults";
            this.btnSendResults.Size = new System.Drawing.Size(75, 23);
            this.btnSendResults.TabIndex = 21;
            this.btnSendResults.Text = "Send";
            this.btnSendResults.Click += new System.EventHandler(this.btnSendResults_Click);
            // 
            // cmbRecipient
            // 
            this.cmbRecipient.Location = new System.Drawing.Point(544, 264);
            this.cmbRecipient.Name = "cmbRecipient";
            this.cmbRecipient.Size = new System.Drawing.Size(121, 21);
            this.cmbRecipient.TabIndex = 22;
            this.cmbRecipient.Text = "Select Recipient...";
            this.cmbRecipient.SelectedIndexChanged += new System.EventHandler(this.cmbRecipient_SelectedIndexChanged_1);
            // 
            // chkAutoSend
            // 
            this.chkAutoSend.Checked = true;
            this.chkAutoSend.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chkAutoSend.Enabled = false;
            this.chkAutoSend.Location = new System.Drawing.Point(480, 264);
            this.chkAutoSend.Name = "chkAutoSend";
            this.chkAutoSend.Size = new System.Drawing.Size(56, 24);
            this.chkAutoSend.TabIndex = 23;
            this.chkAutoSend.Text = "Auto?";
            this.chkAutoSend.CheckedChanged += new System.EventHandler(this.chkAutoSend_CheckedChanged_1);
            // 
            // txtMallSearch
            // 
            this.txtMallSearch.Location = new System.Drawing.Point(128, 216);
            this.txtMallSearch.Name = "txtMallSearch";
            this.txtMallSearch.Size = new System.Drawing.Size(112, 23);
            this.txtMallSearch.TabIndex = 24;
            this.txtMallSearch.Text = "Mall Search";
            this.txtMallSearch.Visible = false;
            // 
            // btnCampItems
            // 
            this.btnCampItems.Enabled = false;
            this.btnCampItems.Location = new System.Drawing.Point(128, 184);
            this.btnCampItems.Name = "btnCampItems";
            this.btnCampItems.Size = new System.Drawing.Size(112, 23);
            this.btnCampItems.TabIndex = 25;
            this.btnCampItems.Text = "Get Camp. Items";
            this.btnCampItems.Click += new System.EventHandler(this.btnCampItems_Click);
            // 
            // btnEat
            // 
            this.btnEat.Enabled = false;
            this.btnEat.Location = new System.Drawing.Point(248, 184);
            this.btnEat.Name = "btnEat";
            this.btnEat.Size = new System.Drawing.Size(96, 23);
            this.btnEat.TabIndex = 26;
            this.btnEat.Text = "Eat / Drink";
            this.btnEat.Click += new System.EventHandler(this.btnEat_Click);
            // 
            // btnPurchases
            // 
            this.btnPurchases.Enabled = false;
            this.btnPurchases.Location = new System.Drawing.Point(8, 184);
            this.btnPurchases.Name = "btnPurchases";
            this.btnPurchases.Size = new System.Drawing.Size(112, 23);
            this.btnPurchases.TabIndex = 27;
            this.btnPurchases.Text = "Purchases";
            this.btnPurchases.Click += new System.EventHandler(this.btnPurchases_Click);
            // 
            // lblFee
            // 
            this.lblFee.Location = new System.Drawing.Point(472, 0);
            this.lblFee.Name = "lblFee";
            this.lblFee.Size = new System.Drawing.Size(256, 16);
            this.lblFee.TabIndex = 28;
            this.lblFee.Text = "Note: Connecting costs 100 meat (on success).";
            // 
            // btnHeal
            // 
            this.btnHeal.Enabled = false;
            this.btnHeal.Location = new System.Drawing.Point(232, 120);
            this.btnHeal.Name = "btnHeal";
            this.btnHeal.Size = new System.Drawing.Size(96, 23);
            this.btnHeal.TabIndex = 29;
            this.btnHeal.Text = "Heal";
            // 
            // label5
            // 
            this.label5.Location = new System.Drawing.Point(24, 344);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(400, 40);
            this.label5.TabIndex = 31;
            this.label5.Text = "All users will be processed according to the individual settings of the user.  (C" +
                "amp items, purchases, adventure, eat/drink, cook, send items.)";
            this.label5.Click += new System.EventHandler(this.label5_Click);
            // 
            // btnAutomate
            // 
            this.btnAutomate.Location = new System.Drawing.Point(32, 312);
            this.btnAutomate.Name = "btnAutomate";
            this.btnAutomate.Size = new System.Drawing.Size(168, 23);
            this.btnAutomate.TabIndex = 32;
            this.btnAutomate.Text = "Start Automated Processing";
            this.btnAutomate.Click += new System.EventHandler(this.btnAutomate_Click);
            // 
            // chkPurchase
            // 
            this.chkPurchase.Location = new System.Drawing.Point(440, 304);
            this.chkPurchase.Name = "chkPurchase";
            this.chkPurchase.Size = new System.Drawing.Size(152, 24);
            this.chkPurchase.TabIndex = 33;
            this.chkPurchase.Text = "Make Purchases";
            this.chkPurchase.CheckedChanged += new System.EventHandler(this.chkPurchase_CheckedChanged);
            // 
            // chkCampground
            // 
            this.chkCampground.Location = new System.Drawing.Point(440, 328);
            this.chkCampground.Name = "chkCampground";
            this.chkCampground.Size = new System.Drawing.Size(120, 24);
            this.chkCampground.TabIndex = 34;
            this.chkCampground.Text = "Get Camp Items";
            this.chkCampground.CheckedChanged += new System.EventHandler(this.checkBox1_CheckedChanged);
            // 
            // chkAdventure
            // 
            this.chkAdventure.Location = new System.Drawing.Point(440, 352);
            this.chkAdventure.Name = "chkAdventure";
            this.chkAdventure.Size = new System.Drawing.Size(104, 24);
            this.chkAdventure.TabIndex = 35;
            this.chkAdventure.Text = "Adventure";
            this.chkAdventure.CheckedChanged += new System.EventHandler(this.chkAdventure_CheckedChanged);
            // 
            // chkCook
            // 
            this.chkCook.Location = new System.Drawing.Point(600, 304);
            this.chkCook.Name = "chkCook";
            this.chkCook.Size = new System.Drawing.Size(104, 24);
            this.chkCook.TabIndex = 36;
            this.chkCook.Text = "Cook";
            this.chkCook.CheckedChanged += new System.EventHandler(this.chkCook_CheckedChanged);
            // 
            // chkSend
            // 
            this.chkSend.Location = new System.Drawing.Point(600, 328);
            this.chkSend.Name = "chkSend";
            this.chkSend.Size = new System.Drawing.Size(104, 24);
            this.chkSend.TabIndex = 37;
            this.chkSend.Text = "Send Results";
            this.chkSend.CheckedChanged += new System.EventHandler(this.chkSend_CheckedChanged);
            // 
            // chkConsume
            // 
            this.chkConsume.Location = new System.Drawing.Point(600, 352);
            this.chkConsume.Name = "chkConsume";
            this.chkConsume.Size = new System.Drawing.Size(104, 24);
            this.chkConsume.TabIndex = 38;
            this.chkConsume.Text = "Eat and Drink";
            this.chkConsume.CheckedChanged += new System.EventHandler(this.chkConsume_CheckedChanged);
            // 
            // chkTransferAll
            // 
            this.chkTransferAll.Location = new System.Drawing.Point(440, 376);
            this.chkTransferAll.Name = "chkTransferAll";
            this.chkTransferAll.Size = new System.Drawing.Size(144, 24);
            this.chkTransferAll.TabIndex = 39;
            this.chkTransferAll.Text = "Transfer Entire Inv.";
            this.chkTransferAll.CheckedChanged += new System.EventHandler(this.chkTransferAll_CheckedChanged);
            // 
            // btnViewInventory
            // 
            this.btnViewInventory.Location = new System.Drawing.Point(352, 48);
            this.btnViewInventory.Name = "btnViewInventory";
            this.btnViewInventory.Size = new System.Drawing.Size(104, 23);
            this.btnViewInventory.TabIndex = 40;
            this.btnViewInventory.Text = "Inventory";
            this.btnViewInventory.Click += new System.EventHandler(this.btnViewInventory_Click);
            // 
            // btnClanGet
            // 
            this.btnClanGet.Location = new System.Drawing.Point(248, 216);
            this.btnClanGet.Name = "btnClanGet";
            this.btnClanGet.Size = new System.Drawing.Size(96, 23);
            this.btnClanGet.TabIndex = 41;
            this.btnClanGet.Text = "Clan Get";
            this.btnClanGet.Click += new System.EventHandler(this.btnClanGet_Click);
            // 
            // chkGetClanItems
            // 
            this.chkGetClanItems.Location = new System.Drawing.Point(600, 376);
            this.chkGetClanItems.Name = "chkGetClanItems";
            this.chkGetClanItems.Size = new System.Drawing.Size(80, 16);
            this.chkGetClanItems.TabIndex = 42;
            this.chkGetClanItems.Text = "Get Clan Items";
            this.chkGetClanItems.CheckedChanged += new System.EventHandler(this.chkGetClanItems_CheckedChanged);
            // 
            // btnTutorial
            // 
            this.btnTutorial.Location = new System.Drawing.Point(8, 216);
            this.btnTutorial.Name = "btnTutorial";
            this.btnTutorial.Size = new System.Drawing.Size(112, 24);
            this.btnTutorial.TabIndex = 43;
            this.btnTutorial.Text = "Toot Oriole";
            this.btnTutorial.Click += new System.EventHandler(this.btnTutorial_Click);
            // 
            // frmKolbot
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.ClientSize = new System.Drawing.Size(760, 405);
            this.Controls.Add(this.btnTutorial);
            this.Controls.Add(this.chkGetClanItems);
            this.Controls.Add(this.btnClanGet);
            this.Controls.Add(this.btnViewInventory);
            this.Controls.Add(this.chkTransferAll);
            this.Controls.Add(this.chkConsume);
            this.Controls.Add(this.chkSend);
            this.Controls.Add(this.chkCook);
            this.Controls.Add(this.chkAdventure);
            this.Controls.Add(this.chkCampground);
            this.Controls.Add(this.chkPurchase);
            this.Controls.Add(this.btnAutomate);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btnHeal);
            this.Controls.Add(this.lblFee);
            this.Controls.Add(this.btnPurchases);
            this.Controls.Add(this.btnEat);
            this.Controls.Add(this.btnCampItems);
            this.Controls.Add(this.txtMallSearch);
            this.Controls.Add(this.chkAutoSend);
            this.Controls.Add(this.cmbRecipient);
            this.Controls.Add(this.btnSendResults);
            this.Controls.Add(this.btnInventory);
            this.Controls.Add(this.cmbUser);
            this.Controls.Add(this.btnRest);
            this.Controls.Add(this.txtResult);
            this.Controls.Add(this.txtWhere);
            this.Controls.Add(this.txtPassword);
            this.Controls.Add(this.txtNumAdv);
            this.Controls.Add(this.cmbWhere);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.lblAccount);
            this.Controls.Add(this.btnAdventure);
            this.Controls.Add(this.lblStatus);
            this.Controls.Add(this.btnCook);
            this.Controls.Add(this.btnSend);
            this.Controls.Add(this.btnMessages);
            this.Controls.Add(this.btnConnect);
            this.Name = "frmKolbot";
            this.Text = "Kolbot";
            this.Load += new System.EventHandler(this.frmKolbot_Load);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.frmKolbot_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }
        #endregion

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            Application.Run(new frmKolbot(args));


        }

        public void frmKolbot_Load(object sender, System.EventArgs e)
        {
            bLoading = false;
            if (XmlInit())
            {
                for (int i = 0; i < oSysData.numberOfLocations; i++)
                    cmbWhere.Items.Add(AdventurePlaces[i].sName);

                LoadItemList();
            }
            NoNotifyList = "kimbo,discodebbie,fangorious,smuckers,scrabbie,spagheddi,pastapeggy,turtleyclub,ridnar,sqeakeybox";
            //if (bAutomated) PerformAutomation(sender, e);

            //get command line args
            //System.Windows.Forms.com
            Application.DoEvents();

            ProcessCLParams(sender, e);

            if (this.bExitOnComplete)
                Application.Exit();

            //TakeFromClanStash("814", "3");

        }

        private void ProcessCLParams(object sender, System.EventArgs e)
        {
            bool bAutomate = false, bSingleUser = false, bLog = false;
            bool bMeatCheck = false;
            string sSingleName = string.Empty, sLog = string.Empty;

            foreach (string s in this.clArgs)
            {
                if (bLog)
                {
                    sLog = s;
                    bLog = false;
                }
                else if (bSingleUser)
                {
                    sSingleName = s;
                    bSingleUser = false;
                }
                else if (s == "automate")
                    bAutomate = true;
                else if (s == "singleuser")
                    bSingleUser = true;
                else if (s == "log")
                    bLog = true;
                else if (s == "meatcheck")
                    bMeatCheck = true;
            }
            if (sSingleName != string.Empty)
                bSingleUser = true;
            if (sLog != string.Empty)
                bLog = true;

            if ((bSingleUser) || (bAutomate) || (bMeatCheck))
                this.bExitOnComplete = true;

            if (bLog)
            {
                this.sLogName = sLog;
                this.bLog = true;
                OpenLogfile();
            }

            if (bSingleUser) //overrides "automate"
                PerformAutomation(sSingleName, sender, e);
            else if (bAutomate)
            {
                PerformAutomation(null, sender, e);
                DisplayAllResults();
            }
            else if (bMeatCheck)
                DoMeatCheck(sender, e);
        }

        private void OpenLogfile()
        {
            // create a writer and open the file
            if (this.sLogName.IndexOf("@DATE") != -1)
            {
                string sDate = string.Empty;
                sDate += DateTime.Today.Year + "_";
                sDate += DateTime.Today.Month + "_";
                sDate += DateTime.Today.Day + "_";
                this.sLogName = this.sLogName.Replace("@DATE", sDate);
            }

            this.tw = new StreamWriter(this.sLogName);

            // write a line of text to the file
            this.WriteLogLine("****LOG BEGIN**** " + DateTime.Now);

        }

        private void WriteLogLine(string sLine)
        {
            this.tw.WriteLine(sLine);
            this.tw.Flush();
        }

        private void CloseLog()
        {
            // close the stream
            this.tw.Close();

        }

        private void DoMeatCheck(object sender, System.EventArgs e)
        {
            string sPage = string.Empty;
            cmbUser.SelectedItem = oSysData.meatCheckUser;
            btnConnect_Click(sender, e);//connect;
            if (lblStatus.Text == "Connected.")
            {
                //http://www3.kingdomofloathing.com/charpane.php

                sPage = GetPage("http://www.kingdomofloathing.com/charpane.php");

                //meat.gif" width=30 height=30 border=0></a><br><b><font size=2>
                int nStart = sPage.IndexOf("meat.gif");
                nStart = sPage.IndexOf("<b><font size=2>", nStart) + 16;
                int nEnd = sPage.IndexOf("</font>", nStart);

                string sMeat = sPage.Substring(nStart, nEnd - nStart);
                sMeat = sMeat.Replace(",", string.Empty);
                long nMeat = Convert.ToInt64(sMeat);

                if ((oSysData.meatCheckAmount + 20000) < nMeat) //we have more, send message...
                {
                    HttpWebResponse postResponse = null, response = null;
                    StreamReader readPostStream = null, readStream = null;

                    try
                    {
                        //get page for cookies
                        //sPage = GetPage("http://messaging.sprintpcs.com/textmessaging/compose");
                        HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create("http://messaging.sprintpcs.com/textmessaging/compose");

                        //COMPLETE SETUP
                        myReq.CookieContainer = new CookieContainer();
                        myReq.MaximumAutomaticRedirections = 4;
                        myReq.MaximumResponseHeadersLength = 4;
                        myReq.Credentials = CredentialCache.DefaultCredentials;

                        //POST
                        myReq.Method = "GET";
                        myReq.ContentType = "application/x-www-form-urlencoded";
                        //Stream newStream=myReq.GetRequestStream();
                        //newStream.Close();

                        //READ
                        Application.DoEvents();
                        response = (HttpWebResponse)myReq.GetResponse();
                        Application.DoEvents();
                        response.Cookies = myReq.CookieContainer.GetCookies(myReq.RequestUri);
                        Stream receiveStream = response.GetResponseStream();
                        readStream = new StreamReader(receiveStream, Encoding.UTF8);

                        string sMessagePage = readStream.ReadToEnd();
                        CookieCollection Cookies = response.Cookies;
                        //response.Close ();
                        //readStream.Close ();

                        //form up post
                        string sPost = string.Empty, sResult = string.Empty;
                        string sURL = "http://messaging.sprintpcs.com/textmessaging/composeconfirm";
                        sPost += "phoneNumber=7209873540";
                        sPost += "&message=" + oSysData.meatCheckUser + " has " + sMeat + " meat.";

                        HttpWebRequest myPostReq = (HttpWebRequest)WebRequest.Create(sURL);
                        myPostReq.CookieContainer = new CookieContainer();
                        //COMPLETE SETUP
                        myPostReq.MaximumAutomaticRedirections = 4;
                        myPostReq.MaximumResponseHeadersLength = 4;
                        myPostReq.Credentials = CredentialCache.DefaultCredentials;
                        myPostReq.CookieContainer.Add(myPostReq.Address, Cookies);

                        //POST
                        myPostReq.Method = "POST";
                        ASCIIEncoding encoding = new ASCIIEncoding();
                        byte[] byte1 = encoding.GetBytes(sPost);
                        myPostReq.ContentType = "application/x-www-form-urlencoded";
                        Stream newStream = myPostReq.GetRequestStream();
                        newStream.Write(byte1, 0, byte1.Length);
                        newStream.Close();

                        //myReq.Proxy=theProxy;

                        //READ
                        Application.DoEvents();
                        postResponse = (HttpWebResponse)myPostReq.GetResponse();
                        Application.DoEvents();
                        Stream receivePostStream = postResponse.GetResponseStream();
                        readPostStream = new StreamReader(receivePostStream, Encoding.UTF8);

                        sResult = readPostStream.ReadToEnd();
                    }
                    catch (Exception ex)
                    {
                        //maybe log it
                        string sJunk = ex.Message;
                    }
                    finally
                    {
                        try
                        {
                            response.Close();
                            readStream.Close();
                            postResponse.Close();
                            readPostStream.Close();
                        }
                        catch (Exception ex) { }//disposing errored, ignore it.
                    }
                }

                //store meat amount... regardless of > or <  (we could have spent some...)
                StoreMeatCheckAmount(sMeat);
            }

        }

        private void StoreMeatCheckAmount(string sMeat)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;

            oKolXml.Load("kolbot.xml");
            XmlElement root = oKolXml.DocumentElement;

            oNode = root.SelectSingleNode("//meatCheck");
            oNode.Attributes.GetNamedItem("meat").Value = sMeat;

            oKolXml.Save("kolbot.xml");
        }

        private void PerformAutomation(string svUser, object sender, System.EventArgs e)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;

            oKolXml.Load("users.xml");
            XmlElement root = oKolXml.DocumentElement;

            string sUser = string.Empty;
            oNode = root.SelectSingleNode("//users");
            oNodes = oNode.SelectNodes("user");
            //i = 0;
            foreach (XmlNode oTempNode in oNodes)
            {
                oNode = oTempNode.SelectSingleNode("name");
                sUser = oNode.InnerText;
                cmbUser.SelectedItem = sUser;
                //cmbUser_SelectedIndexChanged(sender, e);				
                //GetUserState(cmbUser.Text.ToLower());

                //svUser is null if we're doing everyone
                //else just go when matched
                if ((svUser == null) || (sUser == svUser))
                {
                    if (this.bLog)
                    {
                        this.WriteLogLine(string.Empty);
                        this.WriteLogLine("****BEGIN AUTOMATION FOR " + sUser + "**** " + DateTime.Now);
                    }


                    btnConnect_Click(sender, e);//connect;
                    if (lblStatus.Text == "Connected.")
                    {
                        if (this.bLog)//track char stats
                        {
                            LogCharInfo();
                        }
                        //always attempt tutorial (visits council to start)
                        //new players need it, and level ups unlock new areas
                        btnTutorial_Click(sender, e);

                        if (chkPurchase.Checked) btnPurchases_Click(sender, e);//purchase
                        if (chkCampground.Checked) btnCampItems_Click(sender, e);//camp items
                        if (btnCook.Enabled)//cook
                        {
                            if (chkCook.Checked) btnCook_Click(sender, e);
                        }
                        if (chkAdventure.Checked) btnAdventure_Click(sender, e);//adventure
                        if (btnSend.Enabled)//distribute
                        {
                            if (chkSend.Checked) btnSend_Click(sender, e);
                        }
                        if (chkGetClanItems.Checked) btnClanGet_Click(sender, e);

                        if (chkConsume.Checked) btnEat_Click(sender, e);//eat

                        if (chkTransferAll.Checked) btnInventory_Click(sender, e);

                    }
                }
            }

        }

        public void LogCharInfo()
        {
            string sPage = string.Empty;
            string sItem = string.Empty;

            this.WriteLogLine("*********************");
            this.WriteLogLine("******CHAR INFO******");

            sPage = GetPage("http://www.kingdomofloathing.com/charsheet.php");
            this.WriteLogLine(sGetLevel(sPage));
            sItem = sGetStat("Muscle", sPage);
            this.WriteLogLine("Muscle: " + sItem);
            sItem = sGetStat("Mysticality", sPage);
            this.WriteLogLine("Mysticality: " + sItem);
            sItem = sGetStat("Moxie", sPage);
            this.WriteLogLine("Moxie: " + sItem);
            sPage = GetPage("http://www.kingdomofloathing.com/inventory.php?which=2");
            sItem = sGetItem("Hat", sPage);
            this.WriteLogLine("Hat: " + sItem);
            sItem = sGetItem("Pants", sPage);
            this.WriteLogLine("Pants: " + sItem);
            sItem = sGetItem("Weapon", sPage);
            this.WriteLogLine("Weapon: " + sItem);

            this.WriteLogLine("*********************");
            this.WriteLogLine("*********************");


        }

        public string sGetItem(string sItem, string sPage)
        {
            string sFound = string.Empty;
            int nStart = sPage.IndexOf(sItem + ":</td>");
            int nEnd = sPage.IndexOf("</font>", nStart);//will be after item name
            if (nStart != -1)
            {
                //nStart += 9;
                int nItemStart = sPage.IndexOf("<b>", nStart, nEnd - nStart);
                if (nItemStart != -1)
                {
                    nItemStart += 3;
                    int nItemEnd = sPage.IndexOf("</b>", nItemStart);
                    sFound = sPage.Substring(nItemStart, nItemEnd - nItemStart);

                    nItemStart = sPage.IndexOf("(Power: ", nStart, nEnd - nStart) + 8;
                    nItemEnd = sPage.IndexOf(")", nItemStart);
                    sFound += " (Power: " + sPage.Substring(nItemStart, nItemEnd - nItemStart) + ")";
                }
                else
                {
                    sFound = "none";
                }
            }
            return sFound;
        }

        public string sGetStat(string sItem, string sPage)
        {
            string sFound = string.Empty;
            int nStart = sPage.IndexOf(sItem + ":</td>");
            if (nStart != -1)
            {
                //nStart += 9;
                int nItemStart = sPage.IndexOf("<b>", nStart);
                if (nItemStart != -1)
                {
                    nItemStart += 3;
                    int nItemEnd = sPage.IndexOf("</b>", nItemStart);
                    sFound = sPage.Substring(nItemStart, nItemEnd - nItemStart);

                    nItemStart = sPage.IndexOf("(base: ", nItemStart);
                    if (nItemStart != -1)
                    {
                        nItemStart += 7;
                        nItemEnd = sPage.IndexOf(")", nItemStart);
                        sFound += " (base: " + sPage.Substring(nItemStart, nItemEnd - nItemStart) + ")";
                    }
                }
                else
                {
                    sFound = "none";
                }
            }
            return sFound;
        }

        public string sGetLevel(string sPage)
        {
            string sFound = string.Empty;
            int nStart = sPage.IndexOf("<br>Level ");
            int nEnd = 0;
            if (nStart != -1)
            {
                nStart += 10;
                //<br>Level 9<br>
                nEnd = sPage.IndexOf("<br>", nStart);
                sFound = "Level " + sPage.Substring(nStart, nEnd - nStart);
            }
            return sFound;
        }

        public void btnConnect_Click(object sender, System.EventArgs e)
        {
            if (Connect())
            {
                InitButtons();

                /*if (NoNotifyList.IndexOf(cmbUser.SelectedText.ToLower()) == -1)
                {
                    if (oSysData.useForFree)
                    {
                        //SendMessage("kimbo", "Thank you for free use.", "0", new string [0], new string [0]);
                    }
                    else
                    {
                        //SendMessage("kimbo", "Thank you.", "100", new string [0], new string [0]);
                    }
                }*/
                lblStatus.Text = "Connected.";
                if (this.bLog)
                    this.WriteLogLine("Connected.");
            }
            else
            {
                btnConnect.Enabled = true;
                lblStatus.Text = "Connection failure.";
                if (this.bLog)
                    this.WriteLogLine("Connection failure.");
            }

            //<option value=998>maiden wig (16)</option><option value=126>meat engine (19)</option>
            //AddToClanStash("998", "2");

        }

        public void InitButtons()
        {
            btnAdventure.Enabled = true;
            btnHeal.Enabled = true;
            btnRest.Enabled = true;

            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;
            //string sItem = string.Empty, sItemCount = string.Empty, sStore = string.Empty, sPrice = string.Empty;
            //string sPost = string.Empty, sResult = string.Empty, sItemName = string.Empty, sTemp = string.Empty;
            //bool bTrack = true;

            try
            {
                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                //direct buy
                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                oNodes = oNode.SelectNodes("daily/purchase/buy");
                if (oNodes.Count > 0)
                    btnPurchases.Enabled = true;
                oNodes = oNode.SelectNodes("descendant::daily/campground/item");
                if (oNodes.Count > 0)
                    btnCampItems.Enabled = true;
                oNodes = oNode.SelectNodes("daily/consume");
                if (oNodes.Count > 0)
                    btnEat.Enabled = true;
                oNodes = oNode.SelectNodes("daily/distribute/item");
                if (oNodes.Count > 0)
                    btnSend.Enabled = true;
                oNodes = oNode.SelectNodes("cooking/items");
                if (oNodes.Count > 0)
                    btnCook.Enabled = true;





            }
            catch
            {
                txtResult.Text = "Exception in InitButtons()";
                if (this.bLog)
                    this.WriteLogLine("Exception in InitButtons()");

            }
        }

        public void btnMessages_Click(object sender, System.EventArgs e)
        {
            lblStatus.Text = "Checking messages...";
            lblStatus.Refresh();
            tmrMain.Interval = 120000;
            tmrMain.Enabled = true;
            tmrMain.Start();

            string sPage = GetPage(oSysData.messageURL);

            ParseMessages(sPage);
            lblStatus.Text = "Messages retrieved.";
        }

        public void btnSend_Click(object sender, System.EventArgs e)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;
            string[] sItem = new string[1];
            string[] sItemCount = new string[1];
            string sRecipient = string.Empty;
            //string sPost = string.Empty, sResult = string.Empty, sItemName = string.Empty;

            try
            {
                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                //direct buy
                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                oNodes = oNode.SelectNodes("daily/distribute/item");
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem[0] = oTempNode.Attributes.GetNamedItem("id").Value;
                    sItemCount[0] = oTempNode.Attributes.GetNamedItem("count").Value;
                    sRecipient = oTempNode.Attributes.GetNamedItem("recipient").Value;
                    txtResult.Text += "Sending " + sItemCount[0] + " " + sItem[0] + " to " + sRecipient + "\r\n";
                    if (this.bLog)
                        this.WriteLogLine("Sending " + sItemCount[0] + " " + sItem[0] + " to " + sRecipient);

                    SendMessage(sRecipient, "daily distribution", "0", sItemCount, sItem);
                }
            }
            catch
            {
                txtResult.Text = "Exception in btnSend_Click()";
                if (this.bLog)
                    this.WriteLogLine("Exception in btnSend_Click()");
            }
            txtResult.Text += "Distribution done.\r\n";
            if (this.bLog)
                this.WriteLogLine("Distribution done.");
            /*lblStatus.Text= "Sending messages...";
            lblStatus.Refresh();
            SendMessage("kimbo", "This is a test", "1", new string [0], new string [0]);
            lblStatus.Text= "Messages sent.";*/
        }

        public void btnCook_Click(object sender, System.EventArgs e)
        {
            /*lblStatus.Text= "Begin cooking...";
            lblStatus.Refresh();
            //validate ingredients were sent before actual bot cooking...
            cook("plain pizza", false);
            lblStatus.Text= "Cooking finished.";
            */
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;
            string sItem1 = string.Empty, sItem2 = string.Empty, sItemCount = string.Empty;
            //string sPost = string.Empty, sResult = string.Empty, sItemName = string.Empty, sTemp = string.Empty;
            bool bAll = false;
            int nNumItems = 0;

            try
            {
                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                oNodes = oNode.SelectNodes("cooking/items");
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem1 = oTempNode.Attributes.GetNamedItem("item1").Value;
                    sItem2 = oTempNode.Attributes.GetNamedItem("item2").Value;
                    sItemCount = oTempNode.Attributes.GetNamedItem("count").Value;
                    if (sItemCount == "all")
                        bAll = true;
                    else
                        nNumItems = Convert.ToInt32(sItemCount);

                    //sItem1 = FindItemNum(sItem1);
                    //sItem2 = FindItemNum(sItem2);

                    if (bAll)
                    {
                        lblStatus.Text = "Cooking all " + sItem1 + " and " + sItem2;
                        if (this.bLog)
                            this.WriteLogLine("Cooking all " + sItem1 + " and " + sItem2);

                        cook(FindItemNum(sItem1), FindItemNum(sItem2), -1);
                    }
                    else
                    {
                        //for (int i = 1; i <= nNumItems; i++)
                        {
                            lblStatus.Text = "Cooking " + nNumItems + " (" + sItem1 + " and " + sItem2 + ")";
                            if (this.bLog)
                                this.WriteLogLine("Cooking " + nNumItems + " (" + sItem1 + " and " + sItem2 + ")");
                            cook(FindItemNum(sItem1), FindItemNum(sItem2), nNumItems);
                        }
                    }

                }
            }
            catch
            {
                txtResult.Text = "Exception in cooking.";
                if (this.bLog)
                    this.WriteLogLine("Exception in cooking.");
            }

        }

        public string FindItemNum(string sItemName)
        {
            for (int i = 0; i < ItemList.Length; i++)
            {
                if (ItemList.Key[i].ToLower() == sItemName.ToLower())
                    return ItemList.ItemID[i];
            }
            return string.Empty;
        }

        public void btnAdventure_Click(object sender, System.EventArgs e)
        {
            Adventure(sender, e, null);


        }

        private string Adventure(object sender, System.EventArgs e, string terminatingItem)
        {
            //inv_use.php?which=3&whichitem=775"
            string sResult = string.Empty, sReason = string.Empty;
            bStop = false;
            if ((txtNumAdv.Text != string.Empty) && (txtWhere.Text != string.Empty))
            {
                if (btnAdventure.Text == "Stop")
                {
                    btnAdventure.Text = "Adventure";
                    bStop = true;
                    sReason = "stopped by user";
                }
                else
                {
                    btnAdventure.Text = "Stop";
                    if (this.bLog)
                        this.WriteLogLine("Adventuring begins. (" + cmbWhere.SelectedItem.ToString() + ")");
                }

                //btnAdventure.Enabled = false;
                bool bState = tmrMain.Enabled;
                if (bState)
                {
                    tmrMain.Enabled = false;
                    tmrMain.Stop();
                }
                int nCount = 0;
                //txtResult.Text = cmbWhere.SelectedItem.ToString() + " (" + nCount + ")\r\n";
                while (++nCount <= Convert.ToInt32(txtNumAdv.Text))
                {
                    if (bStop)
                        break;
                    //txtResult.Text += cmbWhere.SelectedItem.ToString() + " (" + nCount.ToString() + ")\r\n";
                    if (txtWhere.Text.IndexOf("SH") != -1) //shore
                    {
                        string whichtrip = txtWhere.Text.Substring(2, 1);
                        if (PostPage(oSysData.shoreURL, "pwd=acd2625bcd14c3fb23eef53abce16d8f&whichtrip=" + whichtrip, out sResult))
                        {
                            if (!bAdvSucceeded(sResult, out sReason))
                                bStop = true;
                            else
                                bStop = adventureResults(sResult, terminatingItem);
                        }
                        else
                            break;

                    }
                    else if (txtWhere.Text.IndexOf("YPS") != -1) //yeti protest
                    {
                        sResult = GetPage(oSysData.inventoryUsePage + "?which=3&whichitem=775");
                        if (!bAdvSucceeded(sResult, out sReason)) bStop = true;
                    }
                    else if (txtWhere.Text.IndexOf("TOT") != -1) //trick or treat
                    {
                        PostPage("http://www.kingdomofloathing.com/trickortreat.php", "action=Yep.", out sResult);
                        if (!bAdvSucceeded(sResult, out sReason)) bStop = true;
                        bStop = adventureResults(sResult, terminatingItem);
                    }
                    else
                    {

                        sResult = GetPage(oSysData.adventurePage + "?snarfblat=" + txtWhere.Text);
                        if (!bAdvSucceeded(sResult, out sReason))
                        {
                            if (sReason == "beaten up")
                            {
                                for (int i = 1; i <= 3; i++)//rest 3 times
                                {
                                    if (!bRest(out sReason))
                                    {
                                        bStop = true;
                                        break;
                                    }
                                    nCount++;
                                }
                            }
                            else
                            {
                                bStop = true;
                            }
                        }
                        while (sResult.IndexOf("<form name=attack action=fight.php method=post>") != -1) //keep fighting
                        {
                            if (this.bLog)
                                this.WriteLogLine("Fighting - Adv:" + nCount);

                            if (PostPage(oSysData.fightPage, "action=attack", out sResult))
                            {
                                if (!bAdvSucceeded(sResult, out sReason))
                                {
                                    if (sReason == "beaten up")
                                    {
                                        for (int i = 1; i <= 4; i++)//rest 4 times
                                        {
                                            if (!bRest(out sReason))
                                            {
                                                bStop = true;
                                                break;
                                            }
                                            nCount++;
                                        }
                                    }
                                    else
                                    {
                                        bStop = true;
                                        break;
                                    }
                                }
                            }
                            else
                            {
                                bStop = true;
                                sReason = "connection failure";
                                break;
                            }

                        }
                        if (!bStop)
                        {
                            bStop = adventureResults(sResult, terminatingItem);
                        }
                    }
                    if (bStop)
                        break;
                    lblStatus.Text = "Adventure " + nCount + " finished.";

                    DisplayResults();
                }
                if (bStop)
                {
                    lblStatus.Text = "Adventuring aborted: " + sReason + ", " + (nCount - 1) + " finished.";
                    if (this.bLog)
                        this.WriteLogLine("Adventuring aborted: " + sReason + ", " + (nCount - 1) + " finished.");
                }
                if (bState)
                {
                    tmrMain.Enabled = true;
                    tmrMain.Start();
                }
                if (this.bLog)
                    LogDisplayResults();
                //auto send
                if (chkAutoSend.Checked)
                {
                    btnSendResults_Click(sender, e);

                }

                btnAdventure.Text = "Adventure";


                //btnAdventure.Enabled = true;
            }
            return sResult;
        }

        public void LogDisplayResults()
        {

            this.WriteLogLine(ResultStats.Str + " Strength.");
            this.WriteLogLine(ResultStats.Myst + " Mysticality.");
            this.WriteLogLine(ResultStats.Mox + " Moxie.");

            for (int i = 0; i < ResultItems.Length; i++)
                this.WriteLogLine(ResultItems.Key[i] + " (" + ResultItems.Count[i] + ")");
            Application.DoEvents();

        }

        public void DisplayResults()
        {
            txtResult.Text = string.Empty;

            txtResult.Text += ResultStats.Str + " Strength.\r\n";
            txtResult.Text += ResultStats.Myst + " Mysticality.\r\n";
            txtResult.Text += ResultStats.Mox + " Moxie.\r\n";

            for (int i = 0; i < ResultItems.Length; i++)
                txtResult.Text += ResultItems.Key[i] + " (" + ResultItems.Count[i] + ")\r\n";
            Application.DoEvents();

        }

        public void DisplayAllResults()
        {
            this.WriteLogLine("\r\n*****TOTAL ADVENTURE TOTALS (ALL USERS)*****");
            for (int i = 0; i < TotalItem.Length; i++)
                this.WriteLogLine(TotalItem.Key[i] + " (" + TotalItem.Count[i] + ")");
            Application.DoEvents();

        }

        public bool Connect()
        {
            try
            {
                lblStatus.Text = "Connecting...";
                if (this.bLog)
                    this.WriteLogLine("Connecting...");
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(oSysData.loginPage);

                //PROXY STUFF
                //theProxy = WebProxy.GetDefaultProxy();//new WebProxy("http://usweb.ey.com:80", true);
                /*//string proxyAddress = "/";
                string username = "chambso";*/
                //																					string password = "beezer1";
                //Uri newUri=new Uri(proxyAddress);
                //theProxy.Address=newUri;
                //theProxy.Credentials=new NetworkCredential(username,password);
                //myReq.Proxy=theProxy;

                //COMPLETE SETUP
                myReq.CookieContainer = new CookieContainer();
                myReq.MaximumAutomaticRedirections = 4;
                myReq.MaximumResponseHeadersLength = 4;
                myReq.Credentials = CredentialCache.DefaultCredentials;

                //POST
                myReq.Method = "POST";
                string sUserName = cmbUser.SelectedItem.ToString();//txtUser.Text;
                string sPassword = txtPassword.Text;
                lblAccount.Text = sUserName;
                lblAccount.Refresh();
                string postData = "loggingin=Yup.&loginname=" + sUserName + "&password=" + sPassword;
                ASCIIEncoding encoding = new ASCIIEncoding();
                byte[] byte1 = encoding.GetBytes(postData);
                myReq.ContentType = "application/x-www-form-urlencoded";
                Stream newStream = myReq.GetRequestStream();
                newStream.Write(byte1, 0, byte1.Length);
                newStream.Close();

                //READ
                Application.DoEvents();
                HttpWebResponse response = (HttpWebResponse)myReq.GetResponse();
                Application.DoEvents();
                response.Cookies = myReq.CookieContainer.GetCookies(myReq.RequestUri);
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);

                string sFramesPage = readStream.ReadToEnd();
                theCookies = response.Cookies;
                response.Close();
                readStream.Close();

                if (sFramesPage.IndexOf("The system is currently down for nightly maintenance") != -1)
                    return false;
                else if (sFramesPage.IndexOf("Bad password.") != -1)
                    return false;
                else
                    return true;
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
                if (this.bLog)
                    this.WriteLogLine(ex.Message);
                return false;
            }
        }

        public string GetPage(string sURL)
        {
            string sResult = string.Empty;

            try
            {
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(sURL);
                myReq.CookieContainer = new CookieContainer();
                myReq.MaximumAutomaticRedirections = 4;
                myReq.MaximumResponseHeadersLength = 4;
                myReq.Credentials = CredentialCache.DefaultCredentials;

                //myReq.Proxy=theProxy;

                Application.DoEvents();
                myReq.CookieContainer.Add(myReq.Address, theCookies);
                HttpWebResponse response = (HttpWebResponse)myReq.GetResponse();
                Application.DoEvents();
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);
                sResult = readStream.ReadToEnd();

                response.Close();
                readStream.Close();
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
                if (this.bLog)
                    this.WriteLogLine(ex.Message);
            }

            return sResult;
        }
        public bool SendMessage(string sToWho, string sMessage, string sMeat, string[] sNumItems, string[] sItems)
        {
            string sArgs = string.Empty, sResult = string.Empty;
            sResult = GetPage(oSysData.sendMessageURL);
            int nTokenStart = sResult.IndexOf("pwd value=") + 11;
            int nTokenEnd = sResult.IndexOf("><", nTokenStart) - 1;
            string sPwd = sResult.Substring(nTokenStart, nTokenEnd - nTokenStart);


            sArgs += "action=send";
            sArgs += "&pwd=" + sPwd;
            sArgs += "&towho=" + sToWho;
            sArgs += "&message=" + sMessage;
            sArgs += "&sendmeat=" + sMeat;

            for (int i = 0; i < sItems.GetLength(0); i++)
            {
                sArgs += "&howmany" + (i + 1) + "=" + sNumItems[i];
                sArgs += "&whichitem" + (i + 1) + "=" + sItems[i];
            }

            return PostPage(oSysData.sendMessageURL + "?toid=", sArgs, out sResult);

        }
        public bool PostPage(string sURL, string sArgs, out string sResult)
        {
            sResult = string.Empty;
            try
            {
                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(sURL);
                myReq.CookieContainer = new CookieContainer();
                //COMPLETE SETUP
                myReq.MaximumAutomaticRedirections = 4;
                myReq.MaximumResponseHeadersLength = 4;
                myReq.Credentials = CredentialCache.DefaultCredentials;
                myReq.CookieContainer.Add(myReq.Address, theCookies);

                //POST
                myReq.Method = "POST";
                ASCIIEncoding encoding = new ASCIIEncoding();
                byte[] byte1 = encoding.GetBytes(sArgs);
                myReq.ContentType = "application/x-www-form-urlencoded";
                Stream newStream = myReq.GetRequestStream();
                newStream.Write(byte1, 0, byte1.Length);
                newStream.Close();

                //myReq.Proxy=theProxy;

                //READ
                Application.DoEvents();
                HttpWebResponse response = (HttpWebResponse)myReq.GetResponse();
                Application.DoEvents();
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);

                sResult = readStream.ReadToEnd();
                response.Close();
                readStream.Close();

                if (sResult.IndexOf("The system is currently down for nightly maintenance") != -1)
                    return false;
                //else if (sResult.IndexOf("Invalid PlayerID.")!= -1)
                //return false;
                //else if (sResult.IndexOf("You don't have enough of one of the items you're trying to send.")!= -1)
                //return false;
                else
                    return true;
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
                if (this.bLog)
                    this.WriteLogLine(ex.Message);
                return false;
            }
        }

        public void ParseMessages(string sHTML)
        {
            /*int nMessageStart = 0;
            int nMessageEnd = 0, nNumItems = 0;
            string sMessage = string.Empty, sMessageID = string.Empty, sFromID = string.Empty, sFromName = string.Empty, sText = string.Empty;

            try
            {
                nMessageStart = sHTML.IndexOf("name=\"sel");
                while (nMessageStart != -1)
                {
                    nMessageEnd = sHTML.IndexOf("</blockquote>", nMessageStart) + 13;

                    sMessage = sHTML.Substring(nMessageStart, nMessageEnd - nMessageStart);

                    int nTokenStart = 9;
                    int nTokenEnd = sMessage.IndexOf("\">", nTokenStart);
                    sMessageID = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
			
                    nTokenStart = sMessage.IndexOf("who=") + 4;
                    nTokenEnd = sMessage.IndexOf("\">", nTokenStart);
                    sFromID = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
			
				
                    nTokenStart = nTokenEnd + 2;
                    nTokenEnd = sMessage.IndexOf("</a>", nTokenStart);
                    sFromName = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
				
                    nTokenStart = sMessage.IndexOf("<blockquote>") + 12;
                    nTokenEnd = sMessage.IndexOf("<center>", nTokenStart);
                    if (nTokenEnd == -1)//no items or meat
                        nTokenEnd = sMessage.IndexOf("</blockquote>", nTokenStart);
                    sText = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);

				
                    nTokenStart = sMessage.IndexOf("center>You acquire");
                    string sItems = string.Empty;
                    while(nTokenStart != -1)
                    {
                        nTokenStart = sMessage.IndexOf("<b>", nTokenStart) + 3;
                        nTokenEnd = sMessage.IndexOf("</b>", nTokenStart);
                        sItems = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart) + "\r\n";
						
                        int nStart = sItems.IndexOf("(");
                        if (nStart != -1) //multiples
                        {
                            nStart += 1;
                            int nEnd = sItems.IndexOf(")");

                            nNumItems = Convert.ToInt32(sItems.Substring(nStart, nEnd - nStart));
                        }
                        else
                            nNumItems = 1;


                        nTokenStart = sMessage.IndexOf("center>You acquire", nTokenEnd);
                    }
                    //xml to here
                    nTokenStart = sMessage.IndexOf("alt=\"Meat\"></td><td valign=center>You gain ");
                    string sMeat = "0";
                    if (nTokenStart != -1)
                    {
                        nTokenStart += 43;
                        nTokenEnd = sMessage.IndexOf(" Meat.</td>", nTokenStart);
                        sMeat = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
                    }
				
                    nMessageStart = sHTML.IndexOf("name=\"sel", nMessageEnd);

                    if (((sText != string.Empty) && (sFromName.ToLower() == "kimbo")) || ((sText != string.Empty) && (sFromName.ToLower() == "qat")))
                    {
                        if (sText.IndexOf("get|") != -1)
                        {
                            nTokenStart = sText.IndexOf("|") + 1;
                            string [] sItemNum = new string [1];
                            sItemNum[0] = sText.Substring(nTokenStart);
                            SendMessage(sFromName, "sending item.", "0", new string [] {"1"}, sItemNum);
                            DeleteMessage(sMessageID);					
                        }
                        else
                        {
                            string sResultItem = cook(sText, true);
                            if (sResultItem != "0")
                            {
                                SendMessage(sFromName, "sending " + sText + " (" + nNumItems + ")", "0", new string [] {nNumItems.ToString()}, new string [] {sResultItem});
                                DeleteMessage(sMessageID);
                            }
                            else
                                SendMessage(sFromName, "No item created by request for " + sText + ".  Human intervention required.", "0", new string [0], new string [0]);
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
            }
*/
        }

        public string cook(string item1, string item2, int nQuantity)
        {

            string sResultItem = "0";
            string sArgs = string.Empty;
            string sResult = GetPage(oSysData.cookPage);
            int nTokenStart = sResult.IndexOf("pwd value=") + 11;
            int nTokenEnd = sResult.IndexOf("><", nTokenStart) - 1;
            string sPwd = sResult.Substring(nTokenStart, nTokenEnd - nTokenStart);

            sArgs += "action=combine";
            sArgs += "&pwd=" + sPwd;
            sArgs += "&item1=" + item1;
            sArgs += "&item2=" + item2;
            /*			else if (what.ToLower() == "skullheads")
                        {
                            sArgs += "&item1=" + "304";
                            sArgs += "&item2=" + "580";
                            sResultItem = "584";
                        }
                        else
                        {
                            sResultItem = "0";
                        }
            */
            if (nQuantity == -1)
                sArgs += "&makemax=true";
            else
                sArgs += "&quantity=" + nQuantity;

            //string sResult;
            if (!PostPage(oSysData.cookPage, sArgs, out sResult))
                sResultItem = "0";

            return sResultItem;
        }
        public bool DeleteMessage(string sID)
        {
            string sArgs = string.Empty, sResult = string.Empty;

            sArgs += "action=delete";
            sArgs += "&pwd=acd2625bcd14c3fb23eef53abce16d8f"; //FIX LATER
            sArgs += "&box=Inbox";
            sArgs += "&sel" + sID + "=checked";

            return PostPage(oSysData.messageURL, sArgs, out sResult);
        }

        public void tmrMain_Tick(object Sender, EventArgs e)
        {
            // Set the caption to the current time.
            lblStatus.Text = "Timer: " + DateTime.Now.ToString();
            btnMessages_Click(Sender, e);
        }

        public void cmbWhere_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            txtWhere.Text = string.Empty;
            for (int i = 0; i < oSysData.numberOfLocations; i++)
            {
                if (cmbWhere.SelectedItem.ToString() == AdventurePlaces[i].sName)
                {
                    txtWhere.Text = AdventurePlaces[i].sID;
                    break;
                }
            }
            SetUserState("where");
        }

        public class KolSystemData
        {
            public int numberOfLocations;
            public string loginPage;
            //public string currentUser;
            public string sendMessageURL;
            public string messageURL;
            public string campgroundURL;
            public string shoreURL;
            public string inventoryUsePage;
            public string adventurePage;
            public string fightPage;
            public string cookPage;
            public string searchMallPage;
            public string continueFightText;
            public string systemDownText;
            public string messageStartToken;
            public string messageEndToken;
            public string messageIDStartToken;
            public string messageIDEndToken;
            public string messageFromIDStartToken;
            public string messageFromIDEndToken;
            public string messageFromNameStartToken;
            public string messageFromNameEndToken;
            public string messageTextStartToken;
            public string messageTextEndToken;
            public string messageAquireStart1Token;
            public string messageAquireStart2Token;
            public string messageAquireEndToken;
            public string messageItemDelimStartToken;
            public string messageItemDelimEndToken;
            public bool useForFree;
            public string meatCheckUser;
            public long meatCheckAmount;
        }

        public bool XmlInit()
        {
            bool bResult = true;
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            int nNumLocs = 0;

            try
            {

                // Load the XML data from a file.
                // This code assumes that the XML file is in the same folder.
                oKolXml.Load("kolbot.xml");
                XmlElement root = oKolXml.DocumentElement;
                oNode = root.SelectSingleNode("//loginPage");
                oSysData.loginPage = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//messageURL");
                oSysData.messageURL = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//campgroundURL");
                oSysData.campgroundURL = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//shoreURL");
                oSysData.shoreURL = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//inventoryUsePage");
                oSysData.inventoryUsePage = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//adventurePage");
                oSysData.adventurePage = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//cookPage");
                oSysData.cookPage = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//fightPage");
                oSysData.fightPage = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//sendMessageURL");
                oSysData.sendMessageURL = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//searchMallPage");
                oSysData.searchMallPage = oNode.InnerText.ToString();
                oNode = root.SelectSingleNode("//useForFree");
                if (oNode != null)
                {
                    oSysData.useForFree = Convert.ToBoolean(oNode.InnerText.ToString());
                    if (oSysData.useForFree == true)
                        lblFee.Text = "Free use.";
                }
                oNode = root.SelectSingleNode("//meatCheck");
                oSysData.meatCheckUser = oNode.Attributes.GetNamedItem("user").Value;
                oSysData.meatCheckAmount = Convert.ToInt64(oNode.Attributes.GetNamedItem("meat").Value);

                //process location info
                oNode = root.SelectSingleNode("//locations");
                nNumLocs = Convert.ToInt32(oNode.Attributes.GetNamedItem("count").Value);
                AdventurePlaces = new LocationData[nNumLocs];
                oSysData.numberOfLocations = nNumLocs;
                XmlNodeList oNodes = oNode.SelectNodes("location");
                int i = 0;
                foreach (XmlNode oTempNode in oNodes)
                {
                    AdventurePlaces[i] = new LocationData();
                    AdventurePlaces[i].sName = oTempNode.Attributes.GetNamedItem("name").Value;
                    AdventurePlaces[i].sID = oTempNode.Attributes.GetNamedItem("id").Value;
                    i++;
                }


                //process preference info
                oNode = root.SelectSingleNode("//preferences");
                oNode = oNode.SelectSingleNode("automation");
                if (oNode.InnerText == "on")
                {
                    bAutomated = true;
                }


                //load user info to user drop down
                oKolXml.Load("users.xml");
                root = oKolXml.DocumentElement;



                string sUser = string.Empty;
                oNode = root.SelectSingleNode("//users");
                oNodes = oNode.SelectNodes("user");
                i = 0;
                foreach (XmlNode oTempNode in oNodes)
                {
                    oNode = oTempNode.SelectSingleNode("name");
                    sUser = oNode.InnerText;
                    cmbUser.Items.Add(sUser);
                    cmbRecipient.Items.Add(sUser);
                    cmbRecipient.Items.Add("CLAN STASH");
                    i++;
                }
                Users = new UserData[i];
                i = 0;
                foreach (XmlNode oTempNode in oNodes)
                {
                    Users[i] = new UserData();
                    oNode = oTempNode.SelectSingleNode("name");
                    Users[i].sName = oNode.InnerText;
                    oNode = oTempNode.SelectSingleNode("password");
                    Users[i].sPassword = oNode.InnerText;
                    //oNode = oTempNode.SelectSingleNode("lastAdventure");
                    //Users[i].sLastAdventure = oNode.InnerText;
                    i++;
                }


            }
            catch (Exception ex)
            {
                string sMessage = ex.Message;
                bResult = false;
            }

            return bResult;
        }


        public void LoadItemList()
        {
            XmlDocument oKolXml = new XmlDocument();
            //XmlNode oNode;
            XmlNodeList oNodes;

            try
            {
                oKolXml.Load("items.xml");
                XmlElement root = oKolXml.DocumentElement;
                //oNode = root.SelectSingleNode("//loginPage");
                //oSysData.loginPage = oNode.InnerText.ToString();
                //oNode = root.SelectSingleNode("//messageURL");
                //oSysData.messageURL = oNode.InnerText.ToString();

                oNodes = root.SelectNodes("item");
                foreach (XmlNode oTempNode in oNodes)
                {
                    ItemList.Add(oTempNode.Attributes.GetNamedItem("name").Value, 0, oTempNode.Attributes.GetNamedItem("id").Value);
                }
            }
            catch
            {
                txtResult.Text = "Exception in LoadItemList()";
                if (this.bLog)
                    this.WriteLogLine("Exception in LoadItemList()");
            }
        }
        public bool bAdvSucceeded(string sHtml, out string sFailure)
        {
            bool bResult = true;
            sFailure = string.Empty;

            ClearClickThroughAdventures(sHtml);

            if (sHtml.IndexOf("too drunk") != -1)
            {
                bResult = false;
                sFailure = "too drunk";
            }
            else if (sHtml.IndexOf("You can't afford") != -1)
            {
                bResult = false;
                sFailure = "not enough money";
            }
            else if (sHtml.IndexOf("don't have any time left for today") != -1)
            {
                bResult = false;
                sFailure = "not enough adventures";
            }
            else if (sHtml.IndexOf("don't have enough Adventures") != -1)
            {
                bResult = false;
                sFailure = "not enough adventures";
            }
            else if (sHtml.IndexOf("You're out of adventures.") != -1)
            {
                bResult = false;
                sFailure = "out of adventures";
            }
            else if (sHtml.IndexOf("Wanna wrestle?") != -1)
            {
                bResult = false;
                sFailure = "trying to wrestle the arena mistress";
            }
            else if (sHtml.IndexOf("What's that smell?") != -1)
            {
                bResult = false;
                sFailure = "vomiting on yourself";
            }
            else if (sHtml.IndexOf("Too-Much Booze Blues") != -1)
            {
                bResult = false;
                sFailure = "fighting pink elephants";
            }
            else if (sHtml.IndexOf("Gutterbound") != -1)
            {
                bResult = false;
                sFailure = "falling into the gutter";
            }
            else if (sHtml.IndexOf("Coyote Ugly") != -1)
            {
                bResult = false;
                sFailure = "questionable encounter";
            }
            else if (sHtml.IndexOf("way too beaten up") != -1)
            {
                bResult = false;
                sFailure = "beaten up";
            }
            else if (sHtml.IndexOf("Enter the kingdom") != -1)
            {
                bResult = false;
                sFailure = "logged out";
            }
            else if (sHtml.IndexOf("The system is currently down for nightly maintenance") != -1)
            {
                bResult = false;
                sFailure = "nightly maintenance";
            }

            return bResult;
        }

        private void ClearClickThroughAdventures(string sPage)
        {
            //sleazy back alley - Gender bender adventure
            if (sPage.IndexOf("Under the Knife") != -1)
            {
                //get pwd
                //postback
                //parse out pwd
                int nStart = sPage.IndexOf("pwd value='") + 11;
                int nEnd = sPage.IndexOf("'>", nStart);

                string sPwd = sPage.Substring(nStart, nEnd - nStart);
                string sPost = "pwd=" + sPwd;
                sPost += "&whichchoice=21"; //gender adv?
                sPost += "&option=2";//no thanks

                //maybe they all use choice.php?

                PostPage("http://www.kingdomofloathing.com/choice.php", sPost, out sPage);

            }
            else if (sPage.IndexOf("The leader of each squad appears to be trying to rally his troops") != -1)
            {
                //get pwd
                //postback
                //parse out pwd
                int nStart = sPage.IndexOf("pwd value='") + 11;
                int nEnd = sPage.IndexOf("'>", nStart);

                string sPwd = sPage.Substring(nStart, nEnd - nStart);
                string sPost = "pwd=" + sPwd;
                sPost += "&whichchoice=40";
                sPost += "&option=3";//not involved

                //maybe they all use choice.php?

                PostPage("http://www.kingdomofloathing.com/choice.php", sPost, out sPage);

            }
            else if (sPage.IndexOf("a shabbily-dressed man hunched over a cart laden with the corpses") != -1)
            {
                //get pwd
                //postback
                //parse out pwd
                int nStart = sPage.IndexOf("pwd value='") + 11;
                int nEnd = sPage.IndexOf("'>", nStart);

                string sPwd = sPage.Substring(nStart, nEnd - nStart);
                string sPost = "pwd=" + sPwd;
                sPost += "&whichchoice=41";
                sPost += "&option=3";//not involved

                //maybe they all use choice.php?

                PostPage("http://www.kingdomofloathing.com/choice.php", sPost, out sPage);

            }
            else if (sPage.IndexOf("see two soldiers charging at each other") != -1)
            {
                //get pwd
                //postback
                //parse out pwd
                int nStart = sPage.IndexOf("pwd value='") + 11;
                int nEnd = sPage.IndexOf("'>", nStart);

                string sPwd = sPage.Substring(nStart, nEnd - nStart);
                string sPost = "pwd=" + sPwd;
                sPost += "&whichchoice=42";
                sPost += "&option=3";//not involved

                //maybe they all use choice.php?

                PostPage("http://www.kingdomofloathing.com/choice.php", sPost, out sPage);

            }
            else if (sPage.IndexOf("Hail Drunken Master!") != -1)//eXtreme Haiku Challenge
            {
                string sTargetPage = "http://www.kingdomofloathing.com/haiku.php";
                string sPost = string.Empty;
                sPost += "&action=Yep.";
                sPost += "&option=";

                PostPage(sTargetPage, sPost + "1", out sPage);//roundhouse
                PostPage(sTargetPage, sPost + "1", out sPage);//ramen
                PostPage(sTargetPage, sPost + "2", out sPage);//junk

            }
            else if (sPage.IndexOf("You feel a strange, thrumming vibration in the ground at your feet") != -1)
            {
                //get pwd
                //postback
                //parse out pwd
                int nStart = sPage.IndexOf("pwd value='") + 11;
                int nEnd = sPage.IndexOf("'>", nStart);

                string sPwd = sPage.Substring(nStart, nEnd - nStart);
                string sPost = "pwd=" + sPwd;
                sPost += "&whichchoice=395";
                sPost += "&option=1";//Uh oh...

                //maybe they all use choice.php?

                PostPage("http://www.kingdomofloathing.com/choice.php", sPost, out sPage);
            }
        }

        public bool adventureResults(string sHtml)
        {
            return adventureResults(sHtml, null);
        }

        public bool adventureResults(string sHtml, string terminatingItem)
        {
            bool terminatingItemFound = false;
            //txtResult.Text += string.Empty;
            int nTokenStart = -1, nTokenEnd = 0, nNumItems = 0;

            nTokenStart = sHtml.IndexOf("center>You acquire");
            string sItems = string.Empty;
            while (nTokenStart != -1)
            {
                nTokenStart = sHtml.IndexOf("<b>", nTokenStart) + 3;
                nTokenEnd = sHtml.IndexOf("</b>", nTokenStart);
                sItems = sHtml.Substring(nTokenStart, nTokenEnd - nTokenStart);
                //txtResult.Text += sItems;
                int nStart = sItems.IndexOf("(");
                if (nStart != -1) //multiples
                {
                    nStart += 1;
                    int nEnd = sItems.IndexOf(")");

                    nNumItems = Convert.ToInt32(sItems.Substring(nStart, nEnd - nStart));
                    sItems = sItems.Substring(0, nStart - 2);
                }
                else
                    nNumItems = 1;

                if (sItems.Contains(terminatingItem))
                {
                    terminatingItemFound = true;
                }

                //handle "bunches of dry noodles"
                nStart = sItems.IndexOf("bunches of dry noodles");
                if (nStart != -1) //found it
                {
                    nStart = 0;
                    int nEnd = sItems.IndexOf(" ");

                    nNumItems = Convert.ToInt32(sItems.Substring(nStart, nEnd));
                    sItems = "dry noodles";
                }


                ResultItems.Add(sItems, nNumItems, string.Empty);
                TotalItem.Add(sItems, nNumItems, string.Empty);

                nTokenStart = sHtml.IndexOf("center>You acquire", nTokenEnd);
            }

            nTokenStart = sHtml.IndexOf("<td>You gain ");//stat
            while (nTokenStart != -1)
            {
                nTokenStart += 12;
                nTokenEnd = sHtml.IndexOf(".<", nTokenStart);
                sItems = sHtml.Substring(nTokenStart, nTokenEnd - nTokenStart);
                int nSpace = sItems.IndexOf(" ");
                //txtResult.Text += sItems;
                nNumItems = Convert.ToInt32(sItems.Substring(0, nSpace));
                ResultStats.Add(sItems.Substring(nSpace + 1), nNumItems);

                nTokenStart = sHtml.IndexOf("bR>You gain ", nTokenEnd);
            }
            nTokenStart = sHtml.IndexOf("center>You gain ");//meat
            if (nTokenStart != -1)
            {
                nTokenStart += 16;
                nTokenEnd = sHtml.IndexOf(" Meat.", nTokenStart);
                if ((nTokenEnd > 0) && ((nTokenEnd - nTokenStart) < 20)) //hp/mp (familliar) can fall into this sometimes
                {
                    sItems = sHtml.Substring(nTokenStart, nTokenEnd - nTokenStart);
                    //txtResult.Text += sItems;
                    nNumItems = Convert.ToInt32(sItems);
                    ResultItems.Add("Meat", nNumItems, string.Empty);
                }
            }

            return terminatingItemFound;
        }

        public void btnRest_Click(object sender, System.EventArgs e)
        {
            string sNothing = string.Empty;
            bRest(out sNothing);
        }

        public bool bRest(out string sReason)
        {
            string sResult = string.Empty;
            sReason = string.Empty;
            if (PostPage(oSysData.campgroundURL, "rest=Yep.", out sResult))
            {
                //what's the error if no adventures...?
                if (bAdvSucceeded(sResult, out sReason))
                    adventureResults(sResult);
                else
                {
                    txtResult.Text += sReason + "\r\n";
                    return false;
                }
                if (this.bLog)
                    this.WriteLogLine(sReason);
            }
            txtResult.Text += "Rested 1 turn...\r\n";
            if (this.bLog)
                this.WriteLogLine("Rested 1 turn...");
            return true;
        }

        public void OutputText(string sText)
        {
            txtResult.Text += sText;
        }

        public void cmbUser_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            ResultStats = new StatGain();
            ResultItems = new ItemGain();
            txtResult.Text = string.Empty;
            lblAccount.Text = string.Empty;
            lblStatus.Text = "Click Connect to begin...";
            btnConnect.Enabled = true;

            //disable buttons
            btnCook.Enabled = false;
            btnSend.Enabled = false;

            //clear checks
            bool bLoadingState = bLoading;
            bLoading = true;
            chkPurchase.Checked = false;
            chkCampground.Checked = false;
            chkAdventure.Checked = false;
            chkSend.Checked = false;
            chkCook.Checked = false;
            chkConsume.Checked = false;
            chkTransferAll.Checked = false;
            chkGetClanItems.Checked = false;
            bLoading = bLoadingState;

            try
            {
                for (int i = 0; i < Users.Length; i++)
                {
                    if (Users[i].sName.ToLower() == cmbUser.Text.ToLower())
                    {
                        txtPassword.Text = Users[i].sPassword;
                        break;
                    }
                }
            }
            catch { }
            GetUserState(cmbUser.Text.ToLower());
        }

        public void btnInventory_Click(object sender, System.EventArgs e)
        {
            //get sendmessage page
            string sHtml = GetPage("http://www.kingdomofloathing.com/sendmessage.php");
            string sItems = string.Empty;
            //ItemGain InvItems = new ItemGain();
            int nTokenEnd = 0, nNumItems = 0, nStart = 0;

            //parse items
            int nTokenStart = sHtml.IndexOf("<select name=whichitem1>");
            nTokenStart = sHtml.IndexOf("><option value=", nTokenStart);
            int nSelectEnd = sHtml.IndexOf("</select>", nTokenStart);

            while ((nTokenStart != -1) && (nTokenStart < nSelectEnd))
            {
                nTokenStart += 15;
                nTokenStart = sHtml.IndexOf(">", nTokenStart) + 1;
                nTokenEnd = sHtml.IndexOf("</option>", nTokenStart);
                sItems = sHtml.Substring(nTokenStart, nTokenEnd - nTokenStart);
                if (sItems != "-select an item-")
                {
                    //int nSpace = sItems.LastIndexOf(" ");
                    //txtResult.Text += sItems;
                    //nNumItems = Convert.ToInt32(sItems.Substring(0, nSpace));


                    nStart = sItems.IndexOf("(");
                    if (nStart != -1) //multiples
                    {
                        nStart += 1;
                        int nEnd = sItems.IndexOf(")");

                        nNumItems = Convert.ToInt32(sItems.Substring(nStart, nEnd - nStart));
                    }
                    else
                        nNumItems = 1;
                    ResultItems.Add(sItems.Substring(0, nStart - 2), nNumItems, string.Empty);
                }

                nTokenStart = sHtml.IndexOf("><option value=", nTokenEnd);
            }



            //send items
            btnSendResults_Click(sender, e);




            //Form2 form = new Form2(); 
            //form.Show(); 
            //frmInventory frmInv = new frmInventory();
            //frmInv.Show();
            //string sPage = GetPage(oSysData.messageURL);
        }

        private void btnSendResults_Click(object sender, System.EventArgs e)
        {
            //string sPage = GetPage(oSysData.messageURL);
            string sRecipient = cmbRecipient.Text;
            string[] sItems = new string[11];
            string[] sNums = new string[11];

            if (sRecipient == "Select Recipient...")
            {
                lblStatus.Text = "You must choose a recipient.";
                return;
            }
            if (sRecipient == "CLAN STASH")
            {
                SendResultsToClanStash();
                return;
            }

            int j = 0;
            if (ResultItems.Length > 0)
            {
                for (int i = 0; i < ResultItems.Length; i++) //loop items found
                {
                    if (ResultItems.ItemID[i] != string.Empty)
                    {
                        sItems[j] = ResultItems.ItemID[i];
                        sNums[j] = ResultItems.Count[i].ToString();

                        txtResult.Text += "Sending " + sNums[j] + " " + sItems[j] + ".\r\n";
                        if (this.bLog)
                            this.WriteLogLine("Sending " + sNums[j] + " " + sItems[j] + ".");

                        if (j == 10) //send what we have, then continue
                        {
                            SendMessage(sRecipient, "sending adventure results", "0", sNums, sItems);
                            sItems = new string[11];
                            sNums = new string[11];
                            j = 0;
                        }
                        else
                            j++;
                    }
                }
                //send remaining
                if ((ResultItems.Length % 11) != 0)
                    SendMessage(sRecipient, "sending adventure results", ResultItems.Meat.ToString(), sNums, sItems);

                ResultItems = new ItemGain();
                txtResult.Text += "Message(s) sent.\r\n";
                if (this.bLog)
                    this.WriteLogLine("Message(s) sent.");
            }

        }

        private void SendResultsToClanStash()
        {
            string sItem = string.Empty, sNum = string.Empty;
            if (ResultItems.Length > 0)
            {
                for (int i = 0; i < ResultItems.Length; i++) //loop items found
                {
                    if (ResultItems.ItemID[i] != string.Empty)
                    {
                        sItem = ResultItems.ItemID[i];
                        sNum = ResultItems.Count[i].ToString();

                        txtResult.Text += "Sending " + sNum + " " + sItem + " to CLAN.\r\n";
                        if (this.bLog)
                            this.WriteLogLine("Sending " + sNum + " " + sItem + " to CLAN.");

                        AddToClanStash(sItem, sNum);
                    }
                }
                //divide meat by 10 = x
                //make x meat paste
                //put paste in clan


                ResultItems = new ItemGain();
                txtResult.Text += "Item(s) sent.\r\n";
                if (this.bLog)
                    this.WriteLogLine("Item(s) sent.");
            }
        }

        private void AddToClanStash(string sItem, string sNum)
        {
            //clan_stash.php method=post><input type=hidden name=action 
            //value="addgoodies"><input class=text type=text size=2 
            //name=quantity value=1> <select name=whichitem>
            string sPost = string.Empty, sPostResult = string.Empty;
            string sPage = GetPage("http://www.kingdomofloathing.com/clan_stash.php");

            //get pwd
            int nStart = sPage.IndexOf("pwd value=\"") + 11;
            int nEnd = sPage.IndexOf("\"<", nStart);
            string sPwd = sPage.Substring(nStart, nEnd - nStart);

            sPost = "pwd=" + sPwd;
            sPost += "&action=addgoodies";
            sPost += "&qty1=" + sNum;
            sPost += "&item1=" + sItem;

            Application.DoEvents();
            PostPage("http://www.kingdomofloathing.com/clan_stash.php", sPost, out sPostResult);

        }

        private void TakeFromClanStash(string sItem, string sNum, string sPage)
        {
            //clan_stash.php method=post><input type=hidden name=action 
            //value="addgoodies"><input class=text type=text size=2 
            //name=quantity value=1> <select name=whichitem>
            string sPost = string.Empty, sPostResult = string.Empty;

            try
            {
                //get pwd
                int nStart = sPage.IndexOf("pwd value=\"") + 11;
                int nEnd = sPage.IndexOf("\"<", nStart);
                string sPwd = sPage.Substring(nStart, nEnd - nStart);

                sPost = "pwd=" + sPwd;
                sPost += "&action=takegoodies";
                sPost += "&whichitem=" + sItem;
                sPost += "&quantity=";

                //how many are there?
                int nStart1 = sPage.IndexOf("takegoodies");//get to add options
                nStart1 = sPage.IndexOf("option value=" + sItem, nStart1);
                nStart1 = sPage.IndexOf("(", nStart1) + 1;
                int nEnd1 = sPage.IndexOf(")", nStart1);
                string sCount = sPage.Substring(nStart1, nEnd1 - nStart1);
                int nCount = Convert.ToInt32(sCount);

                if ((sNum == "all") || (sNum == "leave25") || (sNum == "leave50") || (sNum == "leave100"))//get page, and get count
                {

                    if (sNum == "leave100")
                        nCount -= 100;
                    if (sNum == "leave50")
                        nCount -= 50;
                    if (sNum == "leave25")
                        nCount -= 25;

                    if (nCount > 0)
                        sCount = nCount.ToString();
                    else
                        sCount = string.Empty;

                    if (sCount != string.Empty)
                    {
                        Application.DoEvents();
                        PostPage("http://www.kingdomofloathing.com/clan_stash.php", sPost + sCount, out sPostResult);
                        txtResult.Text += "Retrieved " + sCount + " " + sItem + " from clan\r\n";
                        if (this.bLog)
                            this.WriteLogLine("Retrieved " + sCount + " " + sItem + " from clan");
                    }
                }
                else
                {

                    Application.DoEvents();
                    PostPage("http://www.kingdomofloathing.com/clan_stash.php", sPost + sNum, out sPostResult);
                    txtResult.Text += "Retrieved " + sNum + " " + sItem + " from clan\r\n";
                    if (this.bLog)
                        this.WriteLogLine("Retrieved " + sNum + " " + sItem + " from clan");
                }

            }
            catch (ArgumentOutOfRangeException ex)
            {
                string sJunk = ex.Message;
                //no item so string parse failing
            }

        }

        private bool BuyItemsInMall(string sItem, string sItemID, string sMaxToBuy, string sSellVal)
        {
            //string sResult = string.Empty;//GetPage(oSysData.searchMallPage);
            string sPost = string.Empty, sPostResult = string.Empty;//, sItem = "toast", sItemID = "641000000010";
            int nMessageStart = 0, nMeat = 0, nMax = Convert.ToInt32(sSellVal);
            int nMessageEnd = 0, nNumItems = 0, nLimit = 0, nDisabled = 0;
            string sMessage = string.Empty, sStoreID = string.Empty, sStoreName = string.Empty, sMeat = string.Empty, sItemName = string.Empty;
            string sNumItems = string.Empty, sLimit = string.Empty;
            int nMaxToBuy = Convert.ToInt32(sMaxToBuy);
            //int nGain = 0;

            sPost += "whichitem=" + sItem;

            txtResult.Text = "Searching for " + sItem + " at " + (nMax - 1).ToString() + " or less\r\n";
            txtResult.Text += "Current gain: " + nMallGain + "\r\n";
            Application.DoEvents();
            PostPage(oSysData.searchMallPage, sPost, out sPostResult);


            //try
            nMessageStart = sPostResult.IndexOf("href=\"mallstore");
            while (nMessageStart != -1)
            {
                nMessageStart -= 4;
                nMessageEnd = sPostResult.IndexOf("</a>", nMessageStart);
                nMessageEnd += 6;
                nMessageEnd = sPostResult.IndexOf("</td>", nMessageEnd);
                nMessageEnd += 6;
                nMessageEnd = sPostResult.IndexOf("</td>", nMessageEnd) + 5;

                sMessage = sPostResult.Substring(nMessageStart, nMessageEnd - nMessageStart);

                int nTokenStart = 35;
                int nTokenEnd = sMessage.IndexOf("\">", nTokenStart);
                sStoreID = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);

                nTokenStart = nTokenEnd + 2;
                nTokenEnd = sMessage.IndexOf("<", nTokenStart);
                sStoreName = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);


                nTokenStart = nTokenEnd + 13;
                nTokenEnd = sMessage.IndexOf("&nbsp", nTokenStart);
                nDisabled = sMessage.IndexOf("color: gray", nTokenStart);
                if (nDisabled == -1)
                {
                    sMeat = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
                    sMeat = sMeat.Replace(",", string.Empty);
                    nMeat = Convert.ToInt32(sMeat);
                }
                else
                    nMeat = 0;

                //<b>roll in the hay</b>

                nTokenStart = sMessage.IndexOf("<b>", nTokenEnd) + 3;
                nTokenEnd = sMessage.IndexOf("</b>", nTokenStart);
                sItemName = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);

                if (sItemName == sItem)
                {


                    nTokenStart = sMessage.IndexOf("(", nTokenEnd) + 1;
                    nTokenEnd = sMessage.IndexOf(")", nTokenStart);
                    sNumItems = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
                    nNumItems = Convert.ToInt32(sNumItems);

                    nTokenStart = sMessage.IndexOf("(", nTokenEnd);
                    if (nTokenStart != -1)
                    {
                        nTokenStart += 1;
                        nTokenEnd = sMessage.IndexOf(" / day)", nTokenStart);
                        sLimit = sMessage.Substring(nTokenStart, nTokenEnd - nTokenStart);
                        nLimit = Convert.ToInt32(sLimit);
                    }
                    else
                        nLimit = 0;

                    string sBuyResult = string.Empty;

                    if (nMeat >= nMax)
                        break;
                    else
                    {
                        //buy item(s)
                        if (nDisabled == -1)
                        {
                            int howMany = 0;

                            txtResult.Text += "Found " + sNumItems + " at " + sMeat;
                            if (nLimit > 0)
                                txtResult.Text += " (" + sLimit + " / day)";
                            txtResult.Text += "\r\n";
                            Application.DoEvents();

                            if (nLimit == 0)
                                howMany = nNumItems;
                            else if (nLimit > nNumItems)
                                howMany = nNumItems;
                            else
                                howMany = nLimit;

                            string sStorePage = GetPage("http://www.kingdomofloathing.com/mallstore.php?whichstore=" + sStoreID);

                            nTokenStart = sStorePage.IndexOf("radio value=" + sItemID);
                            if (nTokenStart != -1)
                            {
                                nTokenStart += 12;
                                nTokenEnd = sStorePage.IndexOf("></td>", nTokenStart);
                                string sActualID = sStorePage.Substring(nTokenStart, nTokenEnd - nTokenStart);

                                sPost = "whichitem=" + sActualID + "&quantity=" + howMany;
                                sPost += "&pwd=acd2625bcd14c3fb23eef53abce16d8f"; //FIX LATER
                                sPost += "&whichstore=" + sStoreID;
                                sPost += "&buying=Yep.";

                                txtResult.Text += "Buying " + howMany + " " + sItem + "(s) for " + nMeat + ".\r\n";
                                Application.DoEvents();

                                PostPage("http://www.kingdomofloathing.com/mallstore.php", sPost, out sBuyResult);
                                adventureResults(sBuyResult);
                                DisplayResults();


                                /*								if (sBuyResult.IndexOf("You acquire") != -1)//success
                                {
                                    nMallGain += ((nMax - nMeat) * howMany);

                                    sPost = "whichitem=" + sItemID;
                                    sPost += "&action=sell";
                                    sPost += "&type=quant";
                                    sPost += "&howmany=" + howMany;
									
                                    PostPage("http://www.kingdomofloathing.com/sellstuff.php", sPost, out sBuyResult);
                                    if (sBuyResult.IndexOf("You sell") != -1)//success
                                    {
                                    }
*/
                            }
                            //string sJunk = sBuyResult;
                            //whichitem quantity 641000000010
                        }
                    }
                }
            }

            nMessageStart = sPostResult.IndexOf("href=\"mallstore", nMessageEnd);


            return true;
        }

        private void txtMallSearch_Click(object sender, System.EventArgs e)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNodeList oNodes;
            string sItem = string.Empty, sItemID = string.Empty;
            string sDescID = string.Empty, sSellVal = string.Empty;

            try
            {
                oKolXml.Load("items.xml");
                XmlElement root = oKolXml.DocumentElement;
                oNodes = root.SelectNodes("item");
                int i = 0;
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem = oTempNode.Attributes.GetNamedItem("name").Value;
                    sItemID = oTempNode.Attributes.GetNamedItem("id").Value;
                    sDescID = string.Empty;//oTempNode.Attributes.GetNamedItem("desc_id").Value;
                    sSellVal = oTempNode.Attributes.GetNamedItem("sell_value").Value;
                    BuyItemsInMall(sItem, sItemID, sDescID, sSellVal);
                    i++;
                }
            }
            catch
            {
                txtResult.Text = "Exception in MallSearch()";
            }
        }

        private void GetUserState(string sUserName)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode, oTempNode;
            //XmlNodeList oNodes;
            string sTemp = string.Empty;
            //int nItemCount = 0;

            try
            {
                bLoading = true;

                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                oNode = root.SelectSingleNode("descendant::user[name='" + sUserName + "']");
                oTempNode = oNode.SelectSingleNode("lastAdventure");
                sTemp = oTempNode.InnerText;
                cmbWhere.SelectedItem = sTemp;
                oTempNode = oNode.SelectSingleNode("lastRecipient");
                sTemp = oTempNode.InnerText;
                cmbRecipient.SelectedItem = sTemp;
                oTempNode = oNode.SelectSingleNode("autoSend");
                sTemp = oTempNode.InnerText;
                if (sTemp == "Yes")
                    chkAutoSend.Checked = true;
                else
                    chkAutoSend.Checked = false;
                oTempNode = oNode.SelectSingleNode("AutomationSettings/Purchases");
                sTemp = oTempNode.InnerText;
                chkPurchase.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/Campground");
                sTemp = oTempNode.InnerText;
                chkCampground.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/Adventure");
                sTemp = oTempNode.InnerText;
                chkAdventure.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/Cook");
                sTemp = oTempNode.InnerText;
                chkCook.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/Send");
                sTemp = oTempNode.InnerText;
                chkSend.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/Consume");
                sTemp = oTempNode.InnerText;
                chkConsume.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/TransferAll");
                sTemp = oTempNode.InnerText;
                chkTransferAll.Checked = Convert.ToBoolean(sTemp);
                oTempNode = oNode.SelectSingleNode("AutomationSettings/GetClanItems");
                sTemp = oTempNode.InnerText;
                chkGetClanItems.Checked = Convert.ToBoolean(sTemp);

            }
            catch
            {
                txtResult.Text = "Exception in GetUserState()";
            }
            bLoading = false;
        }

        private void SetUserState(string sWhich)
        {
            if (!bLoading)
            {
                //string sLoc = string.Empty, sRecip = string.Empty;
                XmlDocument oKolXml = new XmlDocument();
                XmlNode oNode, oTempNode;
                //XmlNodeList oNodes;
                //string sTemp = string.Empty;
                //int nItemCount = 0;

                try
                {
                    oKolXml.Load("users.xml");
                    XmlElement root = oKolXml.DocumentElement;

                    oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                    if (sWhich == "where")
                    {
                        oTempNode = oNode.SelectSingleNode("lastAdventure");
                        oTempNode.InnerText = cmbWhere.SelectedItem.ToString();
                    }
                    if (sWhich == "who")
                    {
                        oTempNode = oNode.SelectSingleNode("lastRecipient");
                        oTempNode.InnerText = cmbRecipient.SelectedItem.ToString();
                    }
                    if (sWhich == "auto")
                    {
                        oTempNode = oNode.SelectSingleNode("autoSend");
                        if (chkAutoSend.Checked == true)
                            oTempNode.InnerText = "Yes";
                        else
                            oTempNode.InnerText = "No";

                    }
                    if (sWhich == "AutomationSettings")
                    {
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/Purchases");
                        oTempNode.InnerText = chkPurchase.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/Campground");
                        oTempNode.InnerText = chkCampground.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/Adventure");
                        oTempNode.InnerText = chkAdventure.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/Cook");
                        oTempNode.InnerText = chkCook.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/Send");
                        oTempNode.InnerText = chkSend.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/Consume");
                        oTempNode.InnerText = chkConsume.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/TransferAll");
                        oTempNode.InnerText = chkTransferAll.Checked.ToString();
                        oTempNode = oNode.SelectSingleNode("AutomationSettings/GetClanItems");
                        oTempNode.InnerText = chkGetClanItems.Checked.ToString();

                    }
                    oKolXml.Save("users.xml");
                }
                catch
                {
                    txtResult.Text = "Exception in SetUserState()";
                }
            }
        }

        private void btnCampItems_Click(object sender, System.EventArgs e)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;
            string sItem = string.Empty, sItemCount = string.Empty, sPost = string.Empty, sResult = string.Empty, sPage = string.Empty;
            int nItemCount = 0;

            try
            {
                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                //oNode = root.SelectSingleNode("descendant::user[name='kimbo']");
                oNodes = oNode.SelectNodes("daily/campground/item");
                //int i = 0;
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem = oTempNode.Attributes.GetNamedItem("name").Value;
                    sItemCount = oTempNode.Attributes.GetNamedItem("count").Value;
                    nItemCount = Convert.ToInt32(sItemCount);

                    if (sItem == "reagent")//check this with new campground
                    {
                        sPage = "http://www.kingdomofloathing.com/skills.php";

                        sResult = GetPage(sPage);
                        int nTokenStart = sResult.IndexOf("pwd value='") + 11;
                        int nTokenEnd = sResult.IndexOf("'><", nTokenStart);
                        string sPwd = sResult.Substring(nTokenStart, nTokenEnd - nTokenStart);

                        sPost = "pwd=" + sPwd + "&action=Skillz&whichskill=4006&quantity=" + nItemCount;
                        nItemCount = 1;
                        //<form name=skill2form action=campground.php method=post><input type=hidden name=action value="skill2">Up to three times per day, you can use your inherent skills as a Sauceror to convert 100 Meat into a Scrumptious Reagent, a key ingredient in many sauces and salves.  The process takes 1 Adventure.<br><center><input class=button type=submit value="Make a Scrumptious Reagent (100 Meat)"></center></form>
                    }
                    else if (sItem == "noodles")
                    {
                        sPage = "http://www.kingdomofloathing.com/skills.php";

                        sResult = GetPage(sPage);
                        int nTokenStart = sResult.IndexOf("pwd value='") + 11;
                        int nTokenEnd = sResult.IndexOf("'><", nTokenStart);
                        string sPwd = sResult.Substring(nTokenStart, nTokenEnd - nTokenStart);

                        sPost = "pwd=" + sPwd + "&action=Skillz&whichskill=3006&quantity=" + nItemCount;
                        nItemCount = 1;
                        //<form name=class3skill2form action=campground.php method=post><input type=hidden name=action value="skill2">You can use your mad Pastamancer skills to conjure forth, out of the very starch of reality, a bunch of dry noodles.  This can be done three times per day, and requires 1 Adventure.<br><center><input class=button type=submit value="Conjure some Noodles(1)"></center></form>
                    }
                    else if (sItem == "evil food")
                    {
                        sPage = oSysData.campgroundURL;
                        sPost = "order=Yep.";
                        //<form name=orderform action=campground.php method=post><input type=hidden name=order value="Yep.">You can place an order at the Evil Golden Arches.<br><center><input class=button type=submit value="Order some Evil Food">
                    }
                    else if (sItem == "toast")
                    {
                        sPage = oSysData.campgroundURL;
                        sPost = "maketoast=Yep.";
                        //<form name=toastform action=campground.php method=post><input type=hidden name=maketoast value="Yep.">You can use your cheap toaster to make some toast.<br><center><input class=button type=submit value="Make Toast">
                    }

                    for (int i = 0; i < nItemCount; i++)
                    {
                        txtResult.Text += "Retrieving " + sItem + ".\r\n";
                        if (this.bLog)
                            this.WriteLogLine("Retrieving " + sItem + ".");
                        PostPage(sPage, sPost, out sResult);
                        adventureResults(sResult);
                        DisplayResults();
                    }
                }
            }
            catch
            {
                txtResult.Text = "Exception in btnCampItems_Click()";
            }
        }

        private void btnEat_Click(object sender, System.EventArgs e)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;
            string sItem = string.Empty, sItemCount = string.Empty, sType = string.Empty, sResult = string.Empty, sPage = string.Empty, sPwd = string.Empty;
            int nItemCount = 0;

            try
            {
                //new for pwd support
                //<a href="inv_eat.php?pwd=ed13027c1ffc36ce5be26a436d4b48ff&which=1&whichitem=814">
                sResult = GetPage("http://www.kingdomofloathing.com/inventory.php?which=1");

                int nTokenStart = sResult.IndexOf("?pwd=") + 5;
                int nTokenEnd = sResult.IndexOf("&", nTokenStart);
                sPwd = sResult.Substring(nTokenStart, nTokenEnd - nTokenStart);
                //end new

                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                //oNode = root.SelectSingleNode("descendant::user[name='kimbo']");
                oNodes = oNode.SelectNodes("daily/consume");
                //int i = 0;
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem = oTempNode.Attributes.GetNamedItem("item").Value;
                    sItemCount = oTempNode.Attributes.GetNamedItem("count").Value;
                    nItemCount = Convert.ToInt32(sItemCount);
                    sType = oTempNode.Attributes.GetNamedItem("type").Value;
                    if (sType == "food")
                        sPage = "http://www.kingdomofloathing.com/inv_eat.php";
                    else if (sType == "booze")
                        sPage = "http://www.kingdomofloathing.com/inv_booze.php";



                    //int junk = 1;
                    for (int i = 1; i <= nItemCount; i++)
                    {
                        sResult = GetPage(sPage + "?pwd=" + sPwd + "&which=1&whichitem=" + sItem);
                        if (sResult.IndexOf("not something you can eat") != -1)
                        {
                            txtResult.Text += sItem + " isn't edible.\r\n";
                            if (this.bLog)
                                this.WriteLogLine(sItem + " isn't edible.");
                            break;
                        }
                        else if (sResult.IndexOf("not booze") != -1)
                        {
                            txtResult.Text += sItem + " isn't booze.\r\n";
                            if (this.bLog)
                                this.WriteLogLine(sItem + " isn't booze.");
                            break;
                        }
                        //You don't have the item you're trying to use.
                        else if (sResult.IndexOf("don't have") != -1)
                        {
                            txtResult.Text += "You don't have any " + sItem + "s.\r\n";
                            if (this.bLog)
                                this.WriteLogLine("You don't have any " + sItem + "s.");
                            break;
                        }
                        else if (sResult.IndexOf("too drunk") != -1)
                        {
                            txtResult.Text += "You're way too drunk already.\r\n";
                            if (this.bLog)
                                this.WriteLogLine("You're way too drunk already.");
                            break;
                        }
                        else if (sResult.IndexOf("too full") != -1)
                        {
                            txtResult.Text += "You're too full to eat that.\r\n";
                            if (this.bLog)
                                this.WriteLogLine("You're too full to eat that.");
                            break;
                        }
                        else if (sResult == string.Empty)
                        {
                            txtResult.Text += "No response.\r\n";
                            if (this.bLog)
                                this.WriteLogLine("No response.");
                            break;
                        }
                        else
                        {
                            txtResult.Text += "Item " + sItem + " consumed.\r\n";
                            if (this.bLog)
                                this.WriteLogLine("Item " + sItem + " consumed.");
                        }
                    }


                    //inv_booze.php?which=1&whichitem=328
                    //inv_eat.php?which=1&whichitem=808
                }
            }
            catch
            {
                txtResult.Text = "Exception in btnEat_Click()";
            }


        }



        private void cmbRecipient_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            SetUserState("who");
        }

        private void chkAutoSend_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("auto");
        }

        private void btnPurchases_Click(object sender, System.EventArgs e)
        {
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode;
            XmlNodeList oNodes;
            string sItem = string.Empty, sItemCount = string.Empty, sStore = string.Empty, sPrice = string.Empty;
            string sPost = string.Empty, sResult = string.Empty, sItemName = string.Empty, sTemp = string.Empty;
            bool bTrack = true;

            try
            {
                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                //direct buy
                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.SelectedItem.ToString() + "']");
                oNodes = oNode.SelectNodes("daily/purchase/buy");
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem = oTempNode.Attributes.GetNamedItem("item").Value;
                    sItemCount = oTempNode.Attributes.GetNamedItem("count").Value;
                    sStore = oTempNode.Attributes.GetNamedItem("store").Value;
                    sPrice = oTempNode.Attributes.GetNamedItem("price").Value;
                    int nPrice = Convert.ToInt32(sPrice);
                    try
                    {
                        sTemp = oTempNode.Attributes.GetNamedItem("track").Value;
                    }
                    catch { }
                    if (sTemp == "no")
                        bTrack = false;
                    else
                        bTrack = true;
                    //Get correct pwd
                    //http://www3.kingdomofloathing.com/mallstore.php?whichstore=176888&searchitem=248&searchprice=10

                    sResult = GetPage("http://www.kingdomofloathing.com/mallstore.php?whichstore=" + sStore + "&searchitem=" + sItem + "&searchprice=" + sPrice);
                    if (sResult.IndexOf("<form name=\"mallbuy\" action=\"mallstore.php\"") != -1)//Cancel to cancel the purchase
                    {//<form name="mallbuy" action="mallstore.php"

                        int nTokenStart = sResult.IndexOf("pwd\" value=") + 12;
                        int nTokenEnd = sResult.IndexOf("\">", nTokenStart);
                        string sPwd = sResult.Substring(nTokenStart, nTokenEnd - nTokenStart);



                        //add purchase code here
                        sPost = "whichitem=" + sItem + nPrice.ToString("000000000") + "&quantity=" + sItemCount;
                        sPost += "&pwd=" + sPwd;
                        sPost += "&whichstore=" + sStore;
                        sPost += "&buying=Yep.";

                        txtResult.Text += "Buying " + sItemCount + " " + sItem + "(s) for " + sPrice + ".\r\n";
                        if (this.bLog)
                            this.WriteLogLine("Buying " + sItemCount + " " + sItem + "(s) for " + sPrice + ".");
                        Application.DoEvents();

                        PostPage("http://www.kingdomofloathing.com/mallstore.php", sPost, out sResult);
                        if (bTrack)
                        {
                            adventureResults(sResult);
                            DisplayResults();
                        }
                        else
                        {
                            txtResult.Text += "un-tracked...\r\n";
                        }
                    }
                    else
                    {
                        txtResult.Text += "item unavailable...\r\n";
                        if (this.bLog)
                            this.WriteLogLine("item unavailable...");
                    }

                }

                //search and try to buy
                oNodes = oNode.SelectNodes("daily/purchase/try");
                foreach (XmlNode oTempNode in oNodes)
                {
                    sItem = oTempNode.Attributes.GetNamedItem("item").Value;
                    sItemCount = oTempNode.Attributes.GetNamedItem("count").Value;
                    sItemName = oTempNode.Attributes.GetNamedItem("name").Value;
                    sPrice = oTempNode.Attributes.GetNamedItem("price").Value;
                    int nPrice = Convert.ToInt32(sPrice) + 1;

                    //BuyItemsInMall(sItemName, sItem, sItemCount, nPrice.ToString());

                }
            }
            catch
            {
                txtResult.Text = "Exception in btnPurchases_Click()";
            }

        }

        private void cmbRecipient_SelectedIndexChanged_1(object sender, System.EventArgs e)
        {
            btnSendResults.Enabled = true;
            chkAutoSend.Enabled = true;
        }

        private void label5_Click(object sender, System.EventArgs e)
        {

        }

        private void btnAutomate_Click(object sender, System.EventArgs e)
        {
            PerformAutomation(null, sender, e);
        }

        private void chkPurchase_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void checkBox1_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void chkAdventure_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void chkCook_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void chkSend_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void chkConsume_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void chkTransferAll_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void btnViewInventory_Click(object sender, System.EventArgs e)
        {
            //Dim LoginFrm As New _5280Solutions.STAR.Online.Forms.frmLogon

            frmInventory InventoryFrm = new frmInventory(this);
            InventoryFrm.ShowInTaskbar = true;
            InventoryFrm.ShowDialog();



        }

        private void btnClanGet_Click(object sender, System.EventArgs e)
        {
            //read xml
            XmlDocument oKolXml = new XmlDocument();
            XmlNode oNode, oTempNode;
            XmlNodeList oNodes;
            string sTemp = string.Empty;
            //int nItemCount = 0;

            try
            {
                oKolXml.Load("users.xml");
                XmlElement root = oKolXml.DocumentElement;

                oNode = root.SelectSingleNode("descendant::user[name='" + cmbUser.Text + "']");
                oTempNode = oNode.SelectSingleNode("daily/clan/get");
                oNodes = oTempNode.SelectNodes("item");
                string sClanPage = GetPage("http://www.kingdomofloathing.com/clan_stash.php");

                foreach (XmlNode oLoopNode in oNodes)
                {
                    string sItem = oLoopNode.Attributes.GetNamedItem("item").Value;
                    string sNum = oLoopNode.Attributes.GetNamedItem("count").Value;
                    //call "get" with item(s)
                    TakeFromClanStash(sItem, sNum, sClanPage);
                }
            }
            catch
            {
                sTemp = "crap";
            }



        }

        private void chkGetClanItems_CheckedChanged(object sender, System.EventArgs e)
        {
            SetUserState("AutomationSettings");
        }

        private void chkAutoSend_CheckedChanged_1(object sender, System.EventArgs e)
        {
            SetUserState("auto");
        }

        private void btnTutorial_Click(object sender, System.EventArgs e)
        {
            string sTootResult = "init", sLastResult = string.Empty;

            lblStatus.Text = "Visiting Council.";
            if (this.bLog)
                this.WriteLogLine("Visiting Council.");

            //visit council
            string sPage = GetPage("http://www.kingdomofloathing.com/council.php");

            if (sPage.IndexOf("Your first order of business should be to visit the Toot Oriole.") == -1)
                return;
            //meat.gif" width=30 height=30 border=0></a><br><b><font size=2>
            //			int nStart = sPage.IndexOf("meat.gif");
            //			nStart = sPage.IndexOf("<b><font size=2>", nStart) + 16;
            //			int nEnd = sPage.IndexOf("</font>", nStart);
            //
            //			string sMeat = sPage.Substring(nStart, nEnd - nStart);
            //			sMeat = sMeat.Replace(",", string.Empty);
            //			long nMeat = Convert.ToInt64(sMeat);

            while (sTootResult != string.Empty)
            {
                sTootResult = VisitTootOriole(sLastResult);
                sLastResult = sTootResult;

                //equipment Come back up here when you're done putting your gear on.
                //Go to your skills page now
                //Bring me back one of their livers
                //bring me back one of their livers

                if (sTootResult == "meat")
                {
                    lblStatus.Text = "Toot Oriole - checking meat.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - checking meat");

                    //continue, we probably have it, but it will stop if we don't
                }
                else if (sTootResult == "pebbles")
                {
                    lblStatus.Text = "Toot Oriole - need to get the pebbles.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - need to get the pebbles.");
                    //continue, we probably have it, but it will stop if we don't
                    GetTootOriolePebbles();
                }
                else if (sTootResult == "power")
                {
                    lblStatus.Text = "Toot Oriole - checking level.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - checking level");
                    //continue, we probably have it, but it will stop if we don't
                }
                else if (sTootResult == "gum")
                {
                    lblStatus.Text = "Toot Oriole - wants gum.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - wants gum");
                    //get chewing gum
                    //store.php?whichstore=m
                    //whichitem value=23
                    //<input type=hidden name=phash value="6151d488ee6ab29312bde524cbad44f3"><input type=hidden name=whichstore value="m"><input type=hidden name=buying value="Yep.">
                    sPage = GetPage("http://www.kingdomofloathing.com/store.php?whichstore=m");

                    int nStart = sPage.IndexOf("phash value=\"") + 13;
                    int nEnd = sPage.IndexOf("\">", nStart);

                    string sHash = sPage.Substring(nStart, nEnd - nStart);
                    string sPost = string.Empty;

                    sPost += "&phash=" + sHash;
                    sPost += "&whichstore=m";
                    sPost += "&buying=Yep.&howmany=1";

                    PostPage("http://www.kingdomofloathing.com/store.php", "whichitem=23" + sPost, out sPage);
                    //check success

                    //get permit here too, to avoid new hash 
                    PostPage("http://www.kingdomofloathing.com/store.php", "whichitem=42" + sPost, out sPage);
                    //check success
                }
                else if (sTootResult == "fix")
                {
                    lblStatus.Text = "Toot Oriole - wants action figure fixed.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - wants action figure fixed");
                    sPage = GetPage("http://www.kingdomofloathing.com/combine.php");

                    if (sPage.IndexOf("You don't have any meat paste.") != -1)
                    {
                        PostPage("http://www.kingdomofloathing.com/combine.php", "action=makepaste&quantity=1", out sPage);
                    }

                    //parse out pwd

                    int nStart = sPage.IndexOf("pwd value=\"") + 11;
                    int nEnd = sPage.IndexOf("\">", nStart);

                    string sPwd = sPage.Substring(nStart, nEnd - nStart);
                    string sPost = string.Empty;

                    sPost += "action=combine";
                    sPost += "&pwd=" + sPwd;
                    sPost += "&quantity=1";
                    sPost += "&item1=63";//body
                    sPost += "&item2=64";//head

                    //combine items
                    PostPage("http://www.kingdomofloathing.com/combine.php", sPost, out sPage);

                }
                else if (sTootResult == "hermit")
                {
                    lblStatus.Text = "Toot Oriole - wants golden twig.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - wants golden twig");
                    //visit hermit
                    //get twig
                    //hermit.php
                    PostPage("http://www.kingdomofloathing.com/hermit.php", "action=trade&whichitem=66&quantity=1", out sPage);
                    //check that it received twig

                }
                else if (sTootResult == "council")
                {
                    lblStatus.Text = "Toot Oriole - completed.";
                    if (this.bLog)
                        this.WriteLogLine("Toot Oriole - completed.");

                    sPage = GetPage("http://www.kingdomofloathing.com/inventory.php?which=3");

                    //parse out pwd
                    int nStart = sPage.IndexOf("pwd value=\"") + 11;
                    int nEnd = sPage.IndexOf("\">", nStart);

                    string sPwd = sPage.Substring(nStart, nEnd - nStart);

                    //post page to use cert
                    sPage = GetPage("http://www.kingdomofloathing.com/inv_use.php?pwd=" + sPwd + "&which=3&whichitem=133");

                    //return to council and tutorial is done
                    sPage = GetPage("http://www.kingdomofloathing.com/council.php");
                    //stop loop
                    sTootResult = string.Empty;
                }

            }


        }

        private void GetTootOriolePebbles()
        {

            cmbWhere.SelectedText = "Noob Cave";
            txtWhere.Text = "91";
            Adventure(null, new EventArgs(), "pebbles");
        }

        private string VisitTootOriole(string sLastResult)
        {
            string sResult = string.Empty;
            //visit mt. noob
            string sPage = GetPage("http://www.kingdomofloathing.com/mtnoob.php?action=toot");//http://www7.kingdomofloathing.com/mtnoob.php?action=toot

            //check results
            if (sPage.IndexOf("Return to me once you have amassed 30 Meat.") != -1)//come back once you've accumulated 40 Meat //until you've gathered some Meat.
                sResult = "meat";
            else if (sPage.IndexOf("purchase some chewing gum on a string") != -1)//Buy some chewing gum on a string //bring me some chewing gum on a string
                sResult = "gum";
            else if (sPage.IndexOf("Chewing gum on a string can be purchased at the market.") != -1)
                sResult = "gum";
            else if (sPage.IndexOf("Come back to me when you are more powerful.") != -1)
                sResult = "power";
            else if (sPage.IndexOf("Make some meat paste (in your inventory) and fix it for me") != -1)//paste my action figure back together
                sResult = "fix";
            else if (sPage.IndexOf("My action figure is still broken") != -1)//Stick the parts of the action figure together
                sResult = "fix";
            else if (sPage.IndexOf("me a nice-looking twig for my nest") != -1)//Get me one of his golden twigs -- I need to spruce up my nest a little bit.
                sResult = "hermit";
            else if (sPage.IndexOf("Take this certificate, and visit the Council of Loathing") != -1)
                sResult = "council";
            else if (sPage.IndexOf("There is no more I can do for you") != -1)
                sResult = "council";
            else if (sPage.IndexOf("pile of shiny pebbles") != -1)
                sResult = "pebbles";
            else if (sPage.IndexOf("pebbles I hid there") != -1)
                sResult = "pebbles";

            //the Sewer

            if (sResult == sLastResult)
                return string.Empty;
            else
                return sResult;
        }


        public class LocationData
        {
            public string sName;
            public string sID;
        }

        public class UserData
        {
            public string sName;
            public string sPassword;
            public string sLastAdventure;
        }
        public class StatGain
        {
            public int Myst;
            public int Str;
            public int Mox;
            public StatGain()
            {
                this.Myst = 0;
                this.Str = 0;
                this.Mox = 0;
            }
            public void Add(string sWhat, int nNumber)
            {
                if ((sWhat == "Mysteriousness") || (sWhat == "Magicalness") || (sWhat == "Wizardliness") || (sWhat == "Enchantedness"))
                {
                    this.Myst += nNumber;
                }
                else if ((sWhat == "Cheek") || (sWhat == "Smarm") || (sWhat == "Roguishness") || (sWhat == "Sarcasm") || (sWhat == "Chutzpah"))
                {
                    this.Mox += nNumber;
                }
                else if ((sWhat == "Strengthliness") || (sWhat == "Beefiness") || (sWhat == "Muscleboundness") || (sWhat == "Strongness") || (sWhat == "Fortitude"))
                {
                    this.Str += nNumber;
                }
                else
                {
                    this.Str += 0;
                }
            }
        }

        public class ItemGain
        {
            public int Length;
            public string[] Key;
            public int[] Count;
            public string[] ItemID;
            public int Meat;

            public ItemGain()
            {
                this.Length = -1;
                this.Meat = 0;
            }

            public string ItemLookup(string sItemName)
            {
                for (int i = 0; i < ItemList.Length; i++)
                {
                    if (ItemList.Key[i].ToLower() == sItemName.ToLower())
                        return ItemList.ItemID[i];
                }
                return string.Empty;
            }

            public void Add(string sItem, int nNumber, string sItemID)
            {
                int nLoc = 0;
                bool bFound = false;
                if (sItem == "meat")
                {
                    this.Meat += nNumber;
                }
                if (this.Length == -1) //no data
                {
                    this.Length = 1;
                    this.Key = new string[this.Length];
                    this.Count = new int[this.Length];
                    this.ItemID = new string[this.Length];
                    this.Key[nLoc] = sItem;
                    this.Count[nLoc] = nNumber;
                    if (sItemID == string.Empty)
                        this.ItemID[nLoc] = this.ItemLookup(sItem);
                    else
                        this.ItemID[nLoc] = sItemID;
                }
                else
                {
                    //check for existing
                    for (int h = 0; h < this.Length; h++)
                    {
                        if (this.Key[h] == sItem)
                        {
                            this.Count[h] += nNumber;
                            bFound = true;
                            break;
                        }

                    }

                    //add if not found
                    if (!bFound)
                    {
                        string[] tempKey = new string[this.Length + 1];
                        int[] tempCount = new int[this.Length + 1];
                        string[] tempItemID = new string[this.Length + 1];
                        for (int i = 0; i < this.Length; i++)
                        {
                            tempKey[i] = this.Key[i];
                            tempCount[i] = this.Count[i];
                            tempItemID[i] = this.ItemID[i];
                        }
                        nLoc = this.Length++;
                        tempKey[nLoc] = sItem;
                        tempCount[nLoc] = nNumber;

                        if (sItemID == string.Empty)
                            tempItemID[nLoc] = this.ItemLookup(sItem);
                        else
                            tempItemID[nLoc] = sItemID;

                        this.Key = tempKey;
                        this.Count = tempCount;
                        this.ItemID = tempItemID;
                    }
                }
            }
        }

        private void frmKolbot_FormClosing(object sender, FormClosingEventArgs e)
        {
            //logout
            string sPage = GetPage("http://www.kingdomofloathing.com/logout.php");
        }
    }
}
