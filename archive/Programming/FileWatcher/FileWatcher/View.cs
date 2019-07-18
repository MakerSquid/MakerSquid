using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace FileWatcher
{
    public partial class uxVideoConverterForm : Form
    {
        Controller _controller;
        Model _model;

        public uxVideoConverterForm()
        {
            InitializeComponent();

            _model = new Model();
            _controller = new Controller(_model);
        }

        private void uxIntervalTimer_Tick(object sender, EventArgs e)
        {

        }

        private void uxProcessFileButton_Click(object sender, EventArgs e)
        {
            //cheat for now, hook up text change handlers later
            _model.SourceFile = uxSourceTextbox.Text;
            _model.TargetFile = uxOutputFilename.Text;

            _controller.ProcessFile();
        }

        private void uxSourceFileBrowser_Click(object sender, EventArgs e)
        {
            uxSelectSourceFileDialog.InitialDirectory = (!string.IsNullOrEmpty(uxSourceTextbox.Text)) ? uxSourceTextbox.Text : "c:\\";
            uxSelectSourceFileDialog.Filter = "All files (*.*)|*.*";
            uxSelectSourceFileDialog.FilterIndex = 1;
            uxSelectSourceFileDialog.RestoreDirectory = true;

            if (uxSelectSourceFileDialog.ShowDialog() == DialogResult.OK)
            {
                uxSourceTextbox.Text = uxSelectSourceFileDialog.FileName;
                _model.SourceFile = uxSourceTextbox.Text;//wire event

                uxOutputFilename.Text = _controller.BuildTargetFileName(uxTargetTextbox.Text);//wire event and use model
            }
        }

        private void uxTargetDirectoryBrowser_Click(object sender, EventArgs e)
        {
            uxFolderBrowserDialog.RootFolder = Environment.SpecialFolder.MyComputer; // (!string.IsNullOrEmpty(uxTargetTextbox.Text)) ? uxTargetTextbox.Text : "e:\\";

            if (uxFolderBrowserDialog.ShowDialog() == DialogResult.OK)
            {
                uxTargetTextbox.Text = uxFolderBrowserDialog.SelectedPath;
                uxOutputFilename.Text = _controller.BuildTargetFileName(uxTargetTextbox.Text);//wire event and use model
            }
        }
    }
}
