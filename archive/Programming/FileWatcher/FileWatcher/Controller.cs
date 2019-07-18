using System;
using System.Diagnostics;
using System.IO;

namespace FileWatcher
{
    public class Controller
    {
        private Model _model;

        public Controller()
        {
            _model = new Model();
        }

        public Controller(Model model)
        {
            _model = model;
        }

        public void ProcessFile()
        {
            ValidateParameter(_model.SourceFile, "Source file was not specified.");
            ValidateParameter(_model.TargetFile, "Target file was not specified.");
            ValidateFileExists(_model.SourceFile);
            ValidatePathExists(_model.TargetFile);
            ValidateFilename(_model.TargetFile, string.Format("The path: {0} does not contain a valid file name.", _model.TargetFile));

            RunFFMPEG();

            //verify output file is there

            //delete original if specified.
        }

        private void RunFFMPEG()
        {
            ProcessStartInfo startInfo = new ProcessStartInfo();
            startInfo.CreateNoWindow = false;
            startInfo.UseShellExecute = false;
            startInfo.FileName = "C:\\Program Files\\DVRMSToolbox\\Applications\\Ffmpeg\\ffmpeg_MPGMUX.exe";
            startInfo.WindowStyle = ProcessWindowStyle.Hidden;
            startInfo.Arguments = string.Format("-y -i \"{0}\" -vcodec copy -acodec copy -f dvd \"{1}\"", _model.SourceFile, _model.TargetFile);

            try
            {
                // Start the process with the info we specified.
                // Call WaitForExit and then the using statement will close.
                using (Process exeProcess = Process.Start(startInfo))
                {
                    exeProcess.WaitForExit();
                }
            }
            catch (Exception)
            {
                // Log error.
            }

        }

        private void ValidateFilename(string filePath, string error)
        {
            string extension = Path.GetExtension(filePath);

            if (string.IsNullOrEmpty(extension))
            {
                throw new ArgumentException(error);
            }
        }

        private void ValidateParameter(string param, string error)
        {
            if (string.IsNullOrEmpty(param))
            {
                throw new ArgumentNullException(error);
            }
        }

        private void ValidateFileExists(string filename)
        {
            if (!File.Exists(filename))
            {
                throw new FileNotFoundException(filename);
            }
        }

        private void ValidatePathExists(string path)
        {
            string pathOnly = Path.GetDirectoryName(path);

            if (pathOnly != null)//root path, need some validation for that...
            {
                if (!Directory.Exists(pathOnly))
                {
                    throw new DirectoryNotFoundException(pathOnly);
                }
            }
        }

        public string BuildTargetFileName(string targetPath)
        {
            string pathSeparator = Path.PathSeparator.ToString();

            ValidateFileExists(_model.SourceFile);
            ValidatePathExists(targetPath);

            string filename = Path.GetFileName(_model.SourceFile);
            string extension = Path.GetExtension(_model.SourceFile);
            string targetDirectory = Path.GetFullPath(targetPath);

            if (filename != null && extension != null)
            {
                filename = filename.Replace(extension, ".mpeg");
            }

            if (targetDirectory.EndsWith(Path.PathSeparator.ToString()))
            {
                pathSeparator = string.Empty;
            }

            return string.Format("{0}{1}{2}", targetDirectory, pathSeparator, filename);
        }
    }
}
