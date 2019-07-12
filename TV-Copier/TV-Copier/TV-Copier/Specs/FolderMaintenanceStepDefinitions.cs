using System.IO;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace TV_Copier.Specs
{
	[Binding]
	public class FolderMaintenanceStepDefinitions
	{
		private string _directory;

		[Given(@"A directory (.*) with a folder (.*) that has (.*) media files")]
		public void GivenADirectoryWithAFolderThatHasMediaFiles(string directory, string foldername, int fileCount)
		{
			_directory = StringUtility.RemoveExtraQuotes(directory);
		}

		[When(@"the maintenance process runs")]
		public void WhenTheMaintenanceProcessRuns()
		{
			//FileProcessor.UpdateDirectoryCounts(_directory);
		}

		[Then(@"the folder name should be (.*)")]
		public void ThenTheFolderNameShouldBe(string folderName)
		{
			Assert.IsTrue(Directory.Exists(_directory + "\\" + StringUtility.RemoveExtraQuotes(folderName)));
		}

		[Then(@"the folder (.*) should be removed")]
		public void ThenTheFolderShouldBeRemoved(string folderName)
		{
			Assert.IsFalse(Directory.Exists(_directory + "\\" + StringUtility.RemoveExtraQuotes(folderName)));
		}
	}
}
