using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace AutomatedBingSearch
{
    /// <summary>
    /// Interaction logic for BingSearch.xaml
    /// </summary>
    public partial class BingSearch : Window
    {
        public BingSearch()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (App.CommandLineArgs != null)
            {
                ProcessCommandLineArgs();
            }
        }

        private void ProcessCommandLineArgs()
        {
            if (App.CommandLineArgs != null && App.CommandLineArgs[0].ToLower() == "search")
            {
                Search.Bing();
            }
        }

        private void uxSearchBing_Click(object sender, RoutedEventArgs e)
        {
            Search.Bing();
        }
    }
}
