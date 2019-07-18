using System;
using System.Collections.Generic;
using System.Windows;
using Deploy;
using PortSetter;

namespace DeployGUI
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		private List<string> _configs;
		private bool _loading = false;

		public MainWindow()
		{
			InitializeComponent();
		}

		private void Window_Loaded(object sender, RoutedEventArgs e)
		{
			_configs = ConfigFileHandler.LoadConfiguration();
			LoadSettings();
		}

		private void LoadSettings()
		{
			string websiteTargetPath = ListParser.Get("WEBSITE-TARGET-PATH=", _configs);
			string serviceTargetPath = ListParser.Get("SERVICE-TARGET-PATH=", _configs);
			string crmServiceTargetPath = ListParser.Get("CRM-SERVICE-TARGET-PATH=", _configs);
			string branch = ListParser.Get("BRANCH=", _configs);
			string release = ListParser.Get("RELEASE=", _configs);
			string build = ListParser.Get("BUILD=", _configs);
			string deploymentSourcePath = ListParser.Get("SOURCE-PATH=", _configs);

			_loading = true;
			Branch.Text = branch;
			Release.Text = release;
			Build.Text = build;
			ServiceWebsite.Text = serviceTargetPath;
			ClientWebsite.Text = websiteTargetPath;
			CrmWebsite.Text = crmServiceTargetPath;
			Source.Text = deploymentSourcePath + "\\" + branch + "\\" + release + "." + build;
			_loading = false;
		}

		private void SaveSettings()
		{
			string branch = Branch.Text;
			string release = Release.Text;
			string build = Build.Text;
			string serviceTargetPath = ServiceWebsite.Text;
			string websiteTargetPath = ClientWebsite.Text;
			string crmServiceTargetPath = CrmWebsite.Text;

			_configs = ListParser.Set("BRANCH", branch, _configs);
			_configs = ListParser.Set("RELEASE", release, _configs);
			_configs = ListParser.Set("BUILD", build, _configs);
			_configs = ListParser.Set("SERVICE-TARGET-PATH", serviceTargetPath, _configs);
			_configs = ListParser.Set("WEBSITE-TARGET-PATH", websiteTargetPath, _configs);
			_configs = ListParser.Set("CRM-SERVICE-TARGET-PATH", crmServiceTargetPath, _configs);

			ConfigFileHandler.SaveConfiguration(_configs);
		}

		private void Deploy_Click(object sender, RoutedEventArgs e)
		{
			SaveSettings();

			Execute.Command("deploy.exe", "-nowait");
		}

		private void UpdateSource()
		{
			string branch = ListParser.Get("BRANCH=", _configs);
			string release = ListParser.Get("RELEASE=", _configs);
			string build = ListParser.Get("BUILD=", _configs);
			string deploymentSourcePath = ListParser.Get("SOURCE-PATH=", _configs);

			Source.Text = deploymentSourcePath + "\\" + branch + "\\" + release + "." + build;
		}

		private void Branch_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (!_loading)
			{
				_configs = ListParser.Set("BRANCH", Branch.Text, _configs);
				UpdateSource();
			}
		}

		private void Release_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (!_loading)
			{
				_configs = ListParser.Set("RELEASE", Release.Text, _configs);
				UpdateSource();
			}
		}

		private void Build_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (!_loading)
			{
				_configs = ListParser.Set("BUILD", Build.Text, _configs);
				UpdateSource();
			}
		}
	}
}
