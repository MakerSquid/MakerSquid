using System;
using System.Collections.Generic;
using System.Text;

namespace PackForGithub
{

	class FileIgnorer
	{
		internal void Ignore(List<FileSelection> files)
		{
			var assembly = System.Reflection.Assembly.GetExecutingAssembly();
			var basePath = assembly.Location.Remove(assembly.Location.Length - assembly.ManifestModule.Name.Length);

#if DEVMODE
			basePath = "C:\\solomon\\notes\\";
#endif

			//open and read .gitignore
			var fileContent = System.IO.File.ReadAllText($"{basePath}.gitignore");


			foreach (var item in files)
			{
				//if file isn't there, add it
				using (var writer = System.IO.File.AppendText($"{basePath}.gitignore"))
				{
					if (!fileContent.Contains(item.FileName))
					{
						writer.WriteLine($"**/{item.FileName}");
						Console.WriteLine($"Adding exception in .gitignore for {item.FileName}...");
					}
				}
			}
		}
	}
}
