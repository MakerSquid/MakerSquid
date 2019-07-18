using System;
using System.IO;

using NUnit.Framework;


namespace FileWatcher.Test
{
    [TestFixture]
    public class ControllerFixture
    {
        [Test]
        [ExpectedException(typeof(ArgumentNullException))]
        public void ProcessFiles_HandlesEmptySource()
        {
            Model model = new Model();
            Controller controller = new Controller(model);

            model.SourceFile = string.Empty;
            model.TargetFile = "Not empty";
            controller.ProcessFile();

            //use new exception assertion behavior (have to look it up)
        }

        [Test]
        [ExpectedException(typeof(ArgumentNullException))]
        public void ProcessFiles_HandlesEmptyTarget()
        {
            Model model = new Model();
            Controller controller = new Controller(model);

            model.SourceFile = "Not empty";
            model.TargetFile = string.Empty;
            controller.ProcessFile();

            //use new exception assertion behavior (have to look it up)
        }

        [Test]
        [ExpectedException(typeof(FileNotFoundException))]
        public void ProcessFiles_HandlesInvalidSource()
        {
            Model model = new Model();
            Controller controller = new Controller(model);

            model.SourceFile = "c:\\Not a valid filename";
            model.TargetFile = "c:\\";
            controller.ProcessFile();

            //use new exception assertion behavior (have to look it up)
        }

        [Test]
        [ExpectedException(typeof(DirectoryNotFoundException))]
        public void ProcessFiles_HandlesInvalidTarget()
        {
            Model model = new Model();
            Controller controller = new Controller(model);

            model.SourceFile = "c:\\file.txt";
            model.TargetFile = "c:\\Not a valid path\\file.txt";
            controller.ProcessFile();

            //use new exception assertion behavior (have to look it up)
        }

        [Test]
        [ExpectedException(typeof(ArgumentException))]
        public void ProcessFiles_HandlesTargetWithoutFilename()
        {
            Model model = new Model();
            Controller controller = new Controller(model);

            model.SourceFile = "c:\\file.txt";
            model.TargetFile = "c:\\windows";
            controller.ProcessFile();

            //use new exception assertion behavior (have to look it up)
        }

        [Test]
        public void ProcessFiles_RunsAndCreatesTargetFile()
        {
            Model model = new Model();
            Controller controller = new Controller(model);

            model.SourceFile = "c:\\video\\squeak.wmv";
            model.TargetFile = "e:\\squeak.mpg";
            controller.ProcessFile();

            Assert.IsTrue(File.Exists(model.TargetFile));
        }
    }
}
