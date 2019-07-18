using System;
using System.Collections.Generic;
using System.IO;

namespace Deploy
{
	public class Deploy
	{
		public static void Process(List<string> configs)
		{
			string websiteTargetPath = ListParser.Get("WEBSITE-TARGET-PATH=", configs);
			string serviceTargetPath = ListParser.Get("SERVICE-TARGET-PATH=", configs);
			string crmServiceTargetPath = ListParser.Get("CRM-SERVICE-TARGET-PATH=", configs);
			string deploymentSourcePath = ListParser.Get("SOURCE-PATH=", configs);
			string release = ListParser.Get("RELEASE=", configs);
			string build = ListParser.Get("BUILD=", configs);
			string branch = ListParser.Get("BRANCH=", configs);
			string configBackupPath = ListParser.Get("CONFIG-BACKUP-PATH=", configs);
			string sevenZip = ListParser.Get("ZIP=", configs);
			string where = ListParser.Get("WHERE=", configs);

			if (ValidateSource(deploymentSourcePath, release, build, branch))
			{
				ClearTargetDirectories(websiteTargetPath, serviceTargetPath, crmServiceTargetPath);
				ExtractFiles(websiteTargetPath, serviceTargetPath, crmServiceTargetPath, sevenZip, deploymentSourcePath, branch,
							 release, build);
				UpdateXapFiles(websiteTargetPath, sevenZip, configBackupPath);
				FixXapPermissions(websiteTargetPath);
				RestoreConfigs(websiteTargetPath, serviceTargetPath, crmServiceTargetPath, configBackupPath);
				DeployWhere(where, websiteTargetPath);
			}
			else
			{
				Display.Error("ERROR: Are the parameters correct?  The specified build could not be found.", true);
			}
		}

		private static bool ValidateSource(string deploymentSourcePath, string release, string build, string branch)
		{
			string directory = deploymentSourcePath + "\\" + branch + "\\" + release + "." + build + "\\";

			return Directory.Exists(directory);
		}

		private static void DeployWhere(string where, string websiteTargetPath)
		{
			bool deploy = Convert.ToBoolean(where);

			if (deploy)
			{
				Directory.CreateDirectory(websiteTargetPath + "\\where");

				FileManagement.CopyFile(".\\Where - Edit This One\\index.html", websiteTargetPath + "\\where\\index.html", true);
			}
		}

		private static void RestoreConfigs(string websiteTargetPath, string serviceTargetPath, string crmServiceTargetPath, string configBackupPath)
		{
			Display.Header("Restoring configs");
			Display.Output("Copy Client\\web.config");
			FileManagement.CopyFile(configBackupPath + "\\Client\\web.config", websiteTargetPath + "\\web.config", true);
			Display.Output("Copy Service\\web.config");
			FileManagement.CopyFile(configBackupPath + "\\Service\\web.config", serviceTargetPath + "\\web.config", true);
			Display.Output("Copy SMART_CRM_Webservice\\web.config");
			FileManagement.CopyFile(configBackupPath + "\\SMART_CRM_Webservice\\web.config", crmServiceTargetPath + "\\web.config", true);
			Display.Output("Copy authorizationManager.xml");
			FileManagement.CopyFile(configBackupPath + "\\authorizationManager.xml", websiteTargetPath + "\\App_Data\\authorizationManager.xml", true);
		}

		private static void FixXapPermissions(string websiteTargetPath)
		{
			Display.Header("Fixing Xap permissions");
			Execute.Command("cacls.exe", websiteTargetPath + "\\ClientBin\\* /T /E /G Everyone:F");
			Display.Output("Permissions fixed.");
		}

		private static void UpdateXapFiles(string websiteTargetPath, string sevenZip, string configBackupPath)
		{
			Display.Header("Updating Xap files");
			FileManagement.RenameFile(websiteTargetPath + "\\ClientBin\\*.xap", websiteTargetPath + "\\ClientBin\\*.zip");
			Display.Output("Xaps renamed to zip");

			string[] xapFiles = Directory.GetFiles(websiteTargetPath + "\\ClientBin", "*.zip", SearchOption.TopDirectoryOnly);

			foreach (string xapFile in xapFiles)
			{
				Execute.Command(sevenZip, "a -y " + xapFile + " " + configBackupPath + "\\Client\\ServiceReferences.ClientConfig");
			}

			Display.Output("Configs inserted");

			FileManagement.RenameFile(websiteTargetPath + "\\ClientBin\\*.zip", websiteTargetPath + "\\ClientBin\\*.xap");
			Display.Output("Zips renamed to xap");
		}

		private static void ExtractFiles(string websiteTargetPath, string serviceTargetPath, string crmServiceTargetPath, string sevenZip, string deploymentSourcePath, string branch, string release, string build)
		{
			Display.Header("Deploying Files");
			Execute.Command(sevenZip, "x -y " + deploymentSourcePath + "\\" + branch + "\\" + release + "." + build + "\\Client_" + release + "." + build + ".zip -o\"" + websiteTargetPath + "\\\"");
			Display.Output("Deployed website");
			Execute.Command(sevenZip, "x -y " + deploymentSourcePath + "\\" + branch + "\\" + release + "." + build + "\\Boundaries_" + release + "." + build + ".zip -o\"" + serviceTargetPath + "\\\"");
			Display.Output("Deployed services");
			Execute.Command(sevenZip, "x -y " + deploymentSourcePath + "\\" + branch + "\\" + release + "." + build + "\\CRM_Service_" + release + "." + build + ".zip -o\"" + crmServiceTargetPath + "\\\"");
			Display.Output("Deployed CRM service");
		}

		private static void ClearTargetDirectories(string websiteTargetPath, string serviceTargetPath, string crmServiceTargetPath)
		{
			Display.Header("Clearing target directories");
			FileManagement.DeleteDirectory(websiteTargetPath, true);
			Display.Output("Cleared website");
			FileManagement.DeleteDirectory(serviceTargetPath, true);
			Display.Output("Cleared services");
			FileManagement.DeleteDirectory(crmServiceTargetPath, true);
			Display.Output("Cleared CRM service");
			Directory.CreateDirectory(websiteTargetPath);
			Directory.CreateDirectory(serviceTargetPath);
			Directory.CreateDirectory(crmServiceTargetPath);
		}

		public static void Backup(List<string> configs)
		{
			string websiteTargetPath = ListParser.Get("WEBSITE-TARGET-PATH=", configs);
			string serviceTargetPath = ListParser.Get("SERVICE-TARGET-PATH=", configs);
			string crmServiceTargetPath = ListParser.Get("CRM-SERVICE-TARGET-PATH=", configs);
			string configBackupPath = ListParser.Get("CONFIG-BACKUP-PATH=", configs);
			string sevenZip = ListParser.Get("ZIP=", configs);

			Display.Header("Backing up configs");
			CreateConfigBackupFolders(configBackupPath);

			if (File.Exists(websiteTargetPath + "\\ClientBin\\OrderDetails.xap"))
			{
				Display.Output("Extract ServiceReferences.ClientConfig");
				FileManagement.RenameFile(websiteTargetPath + "\\ClientBin\\OrderDetails.xap", websiteTargetPath + "\\ClientBin\\OrderDetails.zip");
				File.Delete(websiteTargetPath + "\\ClientBin\\ServiceReferences.ClientConfig");
				Execute.Command(sevenZip, "e -y " + websiteTargetPath + "\\ClientBin\\OrderDetails.zip ServiceReferences.ClientConfig");
				Display.Output("Copy ServiceReferences.ClientConfig");
				Directory.CreateDirectory(configBackupPath);
				FileManagement.CopyFile("ServiceReferences.ClientConfig", configBackupPath + "\\Client\\ServiceReferences.ClientConfig", true);
				File.Delete("ServiceReferences.ClientConfig");
			}
			else
			{
				Display.Error("ERROR ServiceReferences.ClientConfig was NOT backed up.", false);
				Display.Error("You will have to check that the xap files have the correct configs.", false);
				Display.Error("If you are installing to empty folders (no previous install) this is normal", false);
				Display.Error("and you will probably need to create the correct configs manually.");
			}

			if (File.Exists(websiteTargetPath + "\\web.config"))
			{
				Display.Output("Copy Client\\web.config");
				FileManagement.CopyFile(websiteTargetPath + "\\web.config", configBackupPath + "\\Client\\web.config", true);
			}
			else
			{
				Display.Error(websiteTargetPath + "\\web.config may need to be manually installed.", false);
			}

			if (File.Exists(serviceTargetPath + "\\web.config"))
			{
				Display.Output("Copy Service\\web.config");
				FileManagement.CopyFile(serviceTargetPath + "\\web.config", configBackupPath + "\\Service\\web.config", true);
			}
			else
			{
				Display.Error(serviceTargetPath + "\\web.config may need to be manually installed.", false);
			}

			if (File.Exists(crmServiceTargetPath + "\\web.config"))
			{
				Display.Output("Copy SMART_CRM_Webservice\\web.config");
				FileManagement.CopyFile(crmServiceTargetPath + "\\web.config",
										configBackupPath + "\\SMART_CRM_Webservice\\web.config", true);
			}
			else
			{
				Display.Error(crmServiceTargetPath + "\\web.config may need to be manually installed.", false);
			}

			if (File.Exists(websiteTargetPath + "\\App_Data\\authorizationManager.xml"))
			{
				Display.Output("Copy authorizationManager.xml");
				FileManagement.CopyFile(websiteTargetPath + "\\App_Data\\authorizationManager.xml",
										configBackupPath + "\\authorizationManager.xml", true);
			}
			else
			{
				Display.Error(websiteTargetPath + "\\App_Data\\authorizationManager.xml may need to be manually installed.", false);
			}
		}

		private static void CreateConfigBackupFolders(string configBackupPath)
		{
			Directory.CreateDirectory(configBackupPath);
			Directory.CreateDirectory(configBackupPath + "\\Client");
			Directory.CreateDirectory(configBackupPath + "\\Service");
			Directory.CreateDirectory(configBackupPath + "\\SMART_CRM_Webservice");
		}
	}
}
