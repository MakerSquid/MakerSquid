namespace FileWatcher
{
    partial class uxVideoConverterForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
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
            this.uxSourceLabel = new System.Windows.Forms.Label();
            this.uxTargetLabel = new System.Windows.Forms.Label();
            this.uxSourceTextbox = new System.Windows.Forms.TextBox();
            this.uxTargetTextbox = new System.Windows.Forms.TextBox();
            this.uxDeleteOriginalCheckbox = new System.Windows.Forms.CheckBox();
            this.uxProcessFileButton = new System.Windows.Forms.Button();
            this.uxIntervalTimer = new System.Windows.Forms.Timer(this.components);
            this.uxFileSystemWatcher = new System.IO.FileSystemWatcher();
            this.uxSelectSourceFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.uxSourceFileBrowser = new System.Windows.Forms.Button();
            this.uxTargetDirectoryBrowser = new System.Windows.Forms.Button();
            this.uxOutputName = new System.Windows.Forms.Label();
            this.uxOutputFilename = new System.Windows.Forms.TextBox();
            this.uxFolderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
            ((System.ComponentModel.ISupportInitialize)(this.uxFileSystemWatcher)).BeginInit();
            this.SuspendLayout();
            // 
            // uxSourceLabel
            // 
            this.uxSourceLabel.AutoSize = true;
            this.uxSourceLabel.Location = new System.Drawing.Point(0, 6);
            this.uxSourceLabel.Name = "uxSourceLabel";
            this.uxSourceLabel.Size = new System.Drawing.Size(63, 13);
            this.uxSourceLabel.TabIndex = 0;
            this.uxSourceLabel.Text = "Source File:";
            // 
            // uxTargetLabel
            // 
            this.uxTargetLabel.AutoSize = true;
            this.uxTargetLabel.Location = new System.Drawing.Point(0, 37);
            this.uxTargetLabel.Name = "uxTargetLabel";
            this.uxTargetLabel.Size = new System.Drawing.Size(86, 13);
            this.uxTargetLabel.TabIndex = 1;
            this.uxTargetLabel.Text = "Target Directory:";
            // 
            // uxSourceTextbox
            // 
            this.uxSourceTextbox.Location = new System.Drawing.Point(92, 3);
            this.uxSourceTextbox.Name = "uxSourceTextbox";
            this.uxSourceTextbox.Size = new System.Drawing.Size(383, 20);
            this.uxSourceTextbox.TabIndex = 2;
            this.uxSourceTextbox.Text = "V:\\TV - Unsorted";
            // 
            // uxTargetTextbox
            // 
            this.uxTargetTextbox.Location = new System.Drawing.Point(92, 34);
            this.uxTargetTextbox.Name = "uxTargetTextbox";
            this.uxTargetTextbox.Size = new System.Drawing.Size(383, 20);
            this.uxTargetTextbox.TabIndex = 3;
            this.uxTargetTextbox.Text = "V:\\TV";
            // 
            // uxDeleteOriginalCheckbox
            // 
            this.uxDeleteOriginalCheckbox.AutoSize = true;
            this.uxDeleteOriginalCheckbox.Location = new System.Drawing.Point(92, 104);
            this.uxDeleteOriginalCheckbox.Name = "uxDeleteOriginalCheckbox";
            this.uxDeleteOriginalCheckbox.Size = new System.Drawing.Size(120, 17);
            this.uxDeleteOriginalCheckbox.TabIndex = 4;
            this.uxDeleteOriginalCheckbox.Text = "Delete Original File?";
            this.uxDeleteOriginalCheckbox.UseVisualStyleBackColor = true;
            // 
            // uxProcessFileButton
            // 
            this.uxProcessFileButton.Location = new System.Drawing.Point(228, 155);
            this.uxProcessFileButton.Name = "uxProcessFileButton";
            this.uxProcessFileButton.Size = new System.Drawing.Size(75, 23);
            this.uxProcessFileButton.TabIndex = 5;
            this.uxProcessFileButton.Text = "Process";
            this.uxProcessFileButton.UseVisualStyleBackColor = true;
            this.uxProcessFileButton.Click += new System.EventHandler(this.uxProcessFileButton_Click);
            // 
            // uxIntervalTimer
            // 
            this.uxIntervalTimer.Tick += new System.EventHandler(this.uxIntervalTimer_Tick);
            // 
            // uxFileSystemWatcher
            // 
            this.uxFileSystemWatcher.EnableRaisingEvents = true;
            this.uxFileSystemWatcher.SynchronizingObject = this;
            // 
            // uxSelectSourceFileDialog
            // 
            this.uxSelectSourceFileDialog.FileName = "openFileDialog1";
            // 
            // uxSourceFileBrowser
            // 
            this.uxSourceFileBrowser.Location = new System.Drawing.Point(481, 3);
            this.uxSourceFileBrowser.Name = "uxSourceFileBrowser";
            this.uxSourceFileBrowser.Size = new System.Drawing.Size(33, 20);
            this.uxSourceFileBrowser.TabIndex = 6;
            this.uxSourceFileBrowser.Text = "...";
            this.uxSourceFileBrowser.UseVisualStyleBackColor = true;
            this.uxSourceFileBrowser.Click += new System.EventHandler(this.uxSourceFileBrowser_Click);
            // 
            // uxTargetDirectoryBrowser
            // 
            this.uxTargetDirectoryBrowser.Location = new System.Drawing.Point(481, 34);
            this.uxTargetDirectoryBrowser.Name = "uxTargetDirectoryBrowser";
            this.uxTargetDirectoryBrowser.Size = new System.Drawing.Size(33, 20);
            this.uxTargetDirectoryBrowser.TabIndex = 7;
            this.uxTargetDirectoryBrowser.Text = "...";
            this.uxTargetDirectoryBrowser.UseVisualStyleBackColor = true;
            this.uxTargetDirectoryBrowser.Click += new System.EventHandler(this.uxTargetDirectoryBrowser_Click);
            // 
            // uxOutputName
            // 
            this.uxOutputName.AutoSize = true;
            this.uxOutputName.Location = new System.Drawing.Point(0, 67);
            this.uxOutputName.Name = "uxOutputName";
            this.uxOutputName.Size = new System.Drawing.Size(61, 13);
            this.uxOutputName.TabIndex = 8;
            this.uxOutputName.Text = "Output File:";
            // 
            // uxOutputFilename
            // 
            this.uxOutputFilename.Location = new System.Drawing.Point(92, 64);
            this.uxOutputFilename.Name = "uxOutputFilename";
            this.uxOutputFilename.Size = new System.Drawing.Size(383, 20);
            this.uxOutputFilename.TabIndex = 9;
            // 
            // uxVideoConverterForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(526, 190);
            this.Controls.Add(this.uxOutputFilename);
            this.Controls.Add(this.uxOutputName);
            this.Controls.Add(this.uxTargetDirectoryBrowser);
            this.Controls.Add(this.uxSourceFileBrowser);
            this.Controls.Add(this.uxProcessFileButton);
            this.Controls.Add(this.uxDeleteOriginalCheckbox);
            this.Controls.Add(this.uxTargetTextbox);
            this.Controls.Add(this.uxSourceTextbox);
            this.Controls.Add(this.uxTargetLabel);
            this.Controls.Add(this.uxSourceLabel);
            this.Name = "uxVideoConverterForm";
            this.Text = "File Mover";
            ((System.ComponentModel.ISupportInitialize)(this.uxFileSystemWatcher)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label uxSourceLabel;
        private System.Windows.Forms.Label uxTargetLabel;
        private System.Windows.Forms.TextBox uxSourceTextbox;
        private System.Windows.Forms.TextBox uxTargetTextbox;
        private System.Windows.Forms.CheckBox uxDeleteOriginalCheckbox;
        private System.Windows.Forms.Button uxProcessFileButton;
        private System.Windows.Forms.Timer uxIntervalTimer;
        private System.IO.FileSystemWatcher uxFileSystemWatcher;
        private System.Windows.Forms.OpenFileDialog uxSelectSourceFileDialog;
        private System.Windows.Forms.Button uxSourceFileBrowser;
        private System.Windows.Forms.Button uxTargetDirectoryBrowser;
        private System.Windows.Forms.TextBox uxOutputFilename;
        private System.Windows.Forms.Label uxOutputName;
        private System.Windows.Forms.FolderBrowserDialog uxFolderBrowserDialog;
    }
}

