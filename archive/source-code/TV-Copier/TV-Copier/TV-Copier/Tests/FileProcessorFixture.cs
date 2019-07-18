using System.Collections.Generic;

using NUnit.Framework;

namespace TV_Copier.Tests
{
    [TestFixture]
    public class FileProcessorFixture
    {
        private static List<string> _configs;
        private const string TV_FOLDERS = "[TVFolders]";
        private const string MOVIE_FOLDERS = "[MovieFolders]";
        private const string SHOW_NAMES = "[ShowNames]";

        [Test]
        public void CopyAllFilesInADirectory_CopiesTheFiles()
        {
            _configs = ConfigFileHandler.LoadConfiguration();
            List<string> targetFolders = ListParser.GetSection(TV_FOLDERS, _configs);

            FileProcessor.CopyAllFilesInADirectory("N:\\Torrents\\complete", targetFolders);
        }
    }
}
