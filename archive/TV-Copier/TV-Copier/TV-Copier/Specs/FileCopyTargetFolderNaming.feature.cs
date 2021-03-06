// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.6.0.0
//      SpecFlow Generator Version:1.6.0.0
//      Runtime Version:4.0.30319.1
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
namespace TV_Copier.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.6.0.0")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("File Copy Target Folder Naming")]
    public partial class FileCopyTargetFolderNamingFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "FileCopyTargetFolderNaming.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "File Copy Target Folder Naming", "As a watcher of downloaded TV content\r\nI want downloaded files to use a destinati" +
                    "on folder name based on the incoming file\'s series name\r\nso that I don\'t end up " +
                    "with a bunch of crappy folder names", GenerationTargetLanguage.CSharp, ((string[])(null)));
            testRunner.OnFeatureStart(featureInfo);
        }
        
        [NUnit.Framework.TestFixtureTearDownAttribute()]
        public virtual void FeatureTearDown()
        {
            testRunner.OnFeatureEnd();
            testRunner = null;
        }
        
        public virtual void ScenarioSetup(TechTalk.SpecFlow.ScenarioInfo scenarioInfo)
        {
            testRunner.OnScenarioStart(scenarioInfo);
        }
        
        [NUnit.Framework.TearDownAttribute()]
        public virtual void ScenarioTearDown()
        {
            testRunner.OnScenarioEnd();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Folder Name is Found")]
        public virtual void FolderNameIsFound()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Folder Name is Found", ((string[])(null)));
#line 6
this.ScenarioSetup(scenarioInfo);
#line 7
 testRunner.Given("a defined list of series folders");
#line 8
 testRunner.When("I request the target folder for a file named \"The.Office.S01E03.filename.avi\"");
#line 9
 testRunner.Then("the result should be \"The Office (US)\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Folder Name is not Found")]
        public virtual void FolderNameIsNotFound()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Folder Name is not Found", ((string[])(null)));
#line 11
this.ScenarioSetup(scenarioInfo);
#line 12
 testRunner.Given("a defined list of series folders");
#line 13
 testRunner.When("I request the target folder for a file named \"The Friendly Ghost - S01E02 - filen" +
                    "ame.avi\"");
#line 14
 testRunner.Then("the result should be \"The Friendly Ghost\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show is Date Stamped")]
        public virtual void ShowIsDateStamped()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show is Date Stamped", ((string[])(null)));
#line 16
this.ScenarioSetup(scenarioInfo);
#line 17
 testRunner.Given("a defined list of series folders");
#line 18
 testRunner.When("I request the target folder for a file named \"Craig Ferguson - 2010/12/30 - Katy " +
                    "Perry - filename.avi\"");
#line 19
 testRunner.Then("the result should be \"The Late Late Show with Craig Ferguson\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show is Date Stamped (Variation 1)")]
        public virtual void ShowIsDateStampedVariation1()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show is Date Stamped (Variation 1)", ((string[])(null)));
#line 21
this.ScenarioSetup(scenarioInfo);
#line 22
 testRunner.Given("a defined list of series folders");
#line 23
 testRunner.When("I request the target folder for a file named \"Craig Ferguson - 12/30/2010 - Katy " +
                    "Perry - filename.avi\"");
#line 24
 testRunner.Then("the result should be \"The Late Late Show with Craig Ferguson\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show is Date Stamped (Variation 2)")]
        public virtual void ShowIsDateStampedVariation2()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show is Date Stamped (Variation 2)", ((string[])(null)));
#line 26
this.ScenarioSetup(scenarioInfo);
#line 27
 testRunner.Given("a defined list of series folders");
#line 28
 testRunner.When("I request the target folder for a file named \"Craig Ferguson - 12/2010 - Katy Per" +
                    "ry - filename.avi\"");
#line 29
 testRunner.Then("the result should be \"The Late Late Show with Craig Ferguson\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show is Date Stamped (Variation 3)")]
        public virtual void ShowIsDateStampedVariation3()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show is Date Stamped (Variation 3)", ((string[])(null)));
#line 31
this.ScenarioSetup(scenarioInfo);
#line 32
 testRunner.Given("a defined list of series folders");
#line 33
 testRunner.When("I request the target folder for a file named \"Craig.Ferguson.12/30/2010.Katy.Perr" +
                    "y.filename.avi\"");
#line 34
 testRunner.Then("the result should be \"The Late Late Show with Craig Ferguson\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show is Date Stamped (Variation 4)")]
        public virtual void ShowIsDateStampedVariation4()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show is Date Stamped (Variation 4)", ((string[])(null)));
#line 36
this.ScenarioSetup(scenarioInfo);
#line 37
 testRunner.Given("a defined list of series folders");
#line 38
 testRunner.When("I request the target folder for a file named \"Craig.Ferguson.2010/12/30.Katy.Perr" +
                    "y.filename.avi\"");
#line 39
 testRunner.Then("the result should be \"The Late Late Show with Craig Ferguson\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show has Old School Numbering")]
        public virtual void ShowHasOldSchoolNumbering()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show has Old School Numbering", ((string[])(null)));
#line 41
this.ScenarioSetup(scenarioInfo);
#line 42
 testRunner.Given("a defined list of series folders");
#line 43
 testRunner.When("I request the target folder for a file named \"The.Office.4x02.filename.avi\"");
#line 44
 testRunner.Then("the result should be \"The Office (US)\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show has Old School Numbering (Variation 1)")]
        public virtual void ShowHasOldSchoolNumberingVariation1()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show has Old School Numbering (Variation 1)", ((string[])(null)));
#line 46
this.ScenarioSetup(scenarioInfo);
#line 47
 testRunner.Given("a defined list of series folders");
#line 48
 testRunner.When("I request the target folder for a file named \"The.Office.04x02.filename.avi\"");
#line 49
 testRunner.Then("the result should be \"The Office (US)\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show has Old School Numbering (Variation 2)")]
        public virtual void ShowHasOldSchoolNumberingVariation2()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show has Old School Numbering (Variation 2)", ((string[])(null)));
#line 51
this.ScenarioSetup(scenarioInfo);
#line 52
 testRunner.Given("a defined list of series folders");
#line 53
 testRunner.When("I request the target folder for a file named \"The.Office.10x02.filename.avi\"");
#line 54
 testRunner.Then("the result should be \"The Office (US)\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show has Old School Numbering (Variation 3)")]
        public virtual void ShowHasOldSchoolNumberingVariation3()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show has Old School Numbering (Variation 3)", ((string[])(null)));
#line 56
this.ScenarioSetup(scenarioInfo);
#line 57
 testRunner.Given("a defined list of series folders");
#line 58
 testRunner.When("I request the target folder for a file named \"The.Office.10x2.filename.avi\"");
#line 59
 testRunner.Then("the result should be \"The Office (US)\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Show has Old School Numbering (Variation 4)")]
        public virtual void ShowHasOldSchoolNumberingVariation4()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Show has Old School Numbering (Variation 4)", ((string[])(null)));
#line 61
this.ScenarioSetup(scenarioInfo);
#line 62
 testRunner.Given("a defined list of series folders");
#line 63
 testRunner.When("I request the target folder for a file named \"The.Office.1x2.filename.avi\"");
#line 64
 testRunner.Then("the result should be \"The Office (US)\"");
#line hidden
            testRunner.CollectScenarioErrors();
        }
    }
}
#endregion
