using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FileWatcher
{
    public class Model
    {
        public string SourceFile { get; set; }
        public string TargetFile { get; set; }
        public bool DeleteOriginal { get; set; }
    }
}
