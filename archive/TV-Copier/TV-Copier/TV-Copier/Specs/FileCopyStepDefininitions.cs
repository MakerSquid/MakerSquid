using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace TV_Copier.Specs
{
	[Binding]
	public class FileCopyStepDefininitions
	{
		private string _fileName;
		private string _seriesName;

		[Given(@"the file (.*) has just finished downloading")]
		public void GivenTheFileHasJustFinishedDownloading(string fileName)
		{
			_fileName = fileName;
		}

		[When(@"the file copier runs")]
		public void WhenTheFileCopierRuns()
		{
			string[] args = new string[3];
			args[0] = "Source";
			args[1] = _fileName;
			args[2] = _fileName;

			FileProcessor.Process(args);
		}

		[Then(@"the file (.*) will exist")]
		public void ThenTheFileWillExist_(string targetFile)
		{
			Assert.IsTrue(File.Exists(StringUtility.RemoveExtraQuotes(targetFile)));
		}

		[Given(@"a defined list of series folders")]
		public void GivenADefinedListOfSeriesFolders()
		{
			//nothing needs to be set up in the test, as the config file is used.
		}

		[When(@"I request the target folder for a file named (.*)")]
		public void WhenIRequestTheTargetFolderForAFileNamed(string series)
		{
			_seriesName = FileProcessor.GetTitle(StringUtility.RemoveExtraQuotes(series));
		}

		[Then(@"the result should be (.*)")]
		public void ThenTheResultShouldBe(string series)
		{
			Assert.AreEqual(StringUtility.RemoveExtraQuotes(series), _seriesName);
		}
	}
}
