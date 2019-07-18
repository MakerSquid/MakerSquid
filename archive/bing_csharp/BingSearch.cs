using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Threading;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

namespace BingRewards
{
    public class BingSearch
    {
        private int _currentSearchTermIndex;
        private List<string> _searchTerms;
        private List<User> _users;
        private User _currentUser;
        private int _currentUserIndex;
        IWebDriver _browserDriverCurrentSearchUser;
        IWebDriver _browserDriverSearchText;
        NameValueCollection _appSettings;

        private int _minWait = 3000;
        private int _maxWait = 8000;
        private int _userWait = 75000;
        private int _limitCount = 0;

        public static void Process(bool slow, bool verboseLogging, int startWithUser)
        {
            Logger.Instance.IsVerbose = verboseLogging;

            BingSearch search = null;
            try
            {
                search = new BingSearch();
                search.DoProcessing(slow, startWithUser);
            }
            catch (Exception exception)
            {
                Logger.Instance.Log(exception);
                if (search != null)
                {
                    CloseBrowser(search._browserDriverCurrentSearchUser);
                    CloseBrowser(search._browserDriverSearchText);
                }
            }
        }

        private void DoProcessing(bool slow, int startWithUser)
        {
            if (slow)
            {
                _minWait = 5000;
                _maxWait = 45000;
                _userWait = 900000;
            }

            Logger.Instance.Log(string.Format("Search wait set between {0} and {1} seconds.", _minWait / 1000, _maxWait / 1000));
            Logger.Instance.Log(string.Format("User wait set to {0} minute(s).", _userWait / 1000 / 60));

            LoadOptions();
            LoadUsers();

            GetSearchText();

            do
            {
                if (startWithUser <= _currentUserIndex)
                {
                    try
                    {
                        _browserDriverCurrentSearchUser = OpenSearchBrowser();

                        LogIn();

                        var startDashboardData = GetDashBoardData();

                        Logger.Instance.Log(string.Format(Environment.NewLine + "{0} credits possible today.  ({1} searches per point.)", startDashboardData.MaxPointsAvailableToCollectToday, startDashboardData.Multiplier));
                        Logger.Instance.Log(string.Format("Start points (avail/lifetime): {0}/{1} Current Progress: {2}" + Environment.NewLine, startDashboardData.AvailablePoints, startDashboardData.LifetimePoints, startDashboardData.Progress));

                        _currentUser.AvailablePoints = startDashboardData.AvailablePoints;
                        _currentUser.LifetimePoints = startDashboardData.LifetimePoints;

                        if (startDashboardData.PointsTargetForToday > 0)
                        {
                            _dashboardData = startDashboardData;

                            //sometimes we get failures during search, but they're really no big deal since search is intelligently going to process the right number of items if we retry...
                            Retry.Do(DoSearch, TimeSpan.FromSeconds(5));//will retry 3 times before finally failing...
                        }
                        else
                        {
                            Logger.Instance.Log(string.Format("No more points available for searches. Not performing search!"));
                        }

                        _limitCount = 10;
                        GetDailyOffer();

                        var endDashboardData = GetDashBoardData();

                        Logger.Instance.Log(string.Format("End points (avail/lifetime): {0}/{1} Current Progress: {2}" + Environment.NewLine, endDashboardData.AvailablePoints, endDashboardData.LifetimePoints, endDashboardData.Progress));
                        Logger.Instance.Log(string.Format(Environment.NewLine + "New points accumulated: {0}  Redeemable points: {1}" + Environment.NewLine, (endDashboardData.LifetimePoints - startDashboardData.LifetimePoints), endDashboardData.AvailablePoints), ConsoleColor.Cyan);

                        _currentUser.AvailablePoints = endDashboardData.AvailablePoints;
                        _currentUser.LifetimePoints = endDashboardData.LifetimePoints;

                        LogUserResults(endDashboardData.LifetimePoints - startDashboardData.LifetimePoints);

                        if (_currentUserIndex < _users.Count - 1)//there is probably a better way, or at least put this in a method
                        {
                            WriteToConsoleAndClear("Waiting for {0}s before moving on....             ", _userWait);
                        }

                        LogOut();

                        CloseBrowser(_browserDriverCurrentSearchUser);
                    }
                    catch (Exception exception)
                    {
                        Logger.Instance.Log(exception);
                        //comment this next line out to look at the failing browser...
                        CloseBrowser(_browserDriverCurrentSearchUser);
                    }
                }
            } while (GetNextUser());

            CloseBrowser(_browserDriverSearchText);
        }

        private void LogUserResults(int todaysPoints)
        {
            LogFile.Open();

            LogFile.Log(DateTime.Now + Environment.NewLine);

            LogFile.Log("User: " + _currentUser.AccountName);
            LogFile.Log("Today's Points: " + todaysPoints);
            LogFile.Log("Redeemable points: " + _currentUser.AvailablePoints + " Lifetime points: " + _currentUser.LifetimePoints);
            LogFile.Log(Environment.NewLine);

            LogFile.Close();
        }

        private void LoadOptions()
        {
            Logger.Instance.LogMethodStart();
            _appSettings = ConfigurationManager.AppSettings;
        }

        private void GetDailyOffer()
        {
            Logger.Instance.LogMethodStart();
            _limitCount--;

            //always go at least once
            NavigateToUrl(_browserDriverCurrentSearchUser, "http://www.bing.com/rewards/dashboard", _minWait);

            try
            {
                IReadOnlyCollection<IWebElement> divs = _browserDriverCurrentSearchUser.FindElements(By.ClassName("tile-height"));
                List<IWebElement> divsToClick = divs.Where(div => div.Text.Contains("0 of 1 credit")).ToList();

                if (divsToClick.Count > 0 && _limitCount > 0)
                {
                    divsToClick[0].Click();
                    Thread.Sleep(_minWait);

                    if (divsToClick.Count > 1)
                    {
                        GetDailyOffer();//we can only click one per page load or we'll get a stale element exception
                    }
                }
            }
            // ReSharper disable EmptyGeneralCatchClause
            catch
            // ReSharper restore EmptyGeneralCatchClause
            {
                //daily offer wasn't found
            }
        }

        private static void CloseBrowser(IWebDriver browserDriver)
        {
            Logger.Instance.LogMethodStart();
            if (browserDriver != null)
            {
                browserDriver.Quit();
            }
        }

        private void LoadUsers()
        {
            Logger.Instance.LogMethodStart();

            _users = new List<User>();
            int user = 1;

            string name = _appSettings.Get("User" + user + "Name");

            while (!string.IsNullOrEmpty(name))
            {
                string password = _appSettings.Get("User" + user + "Password");
                string limit = _appSettings.Get("User" + user + "Limit");
                _users.Add(new User { AccountName = name, Password = password, SearchLimit = Convert.ToInt32(limit) });

                user++;
                name = _appSettings.Get("User" + user + "Name");
            }

            Logger.Instance.Log(string.Format("Loaded {0} number of users", _users.Count));

            _currentUser = _users.First();
            _currentUserIndex = 0;
        }

        private string GetDefaultSearchText()
        {
            return _appSettings.Get("DefaultSearchText");
        }

        private IWebDriver OpenSearchBrowser()
        {
            Logger.Instance.LogMethodStart();

            ChromeOptions chromeOptions = new ChromeOptions();
            chromeOptions.AddArgument("test-type"); //gets rid of --ignore-certificate-errors message
            chromeOptions.AddArguments("start-maximized");

            return new ChromeDriver(chromeOptions);
        }

        private void LogOut()
        {
            Logger.Instance.LogMethodStart();
            //CloseAllIEWindows();
        }

        private void DoSearch()
        {
            DashboardData dashboardData = _dashboardData;

            Logger.Instance.LogMethodStart();
            Random rand = new Random((int)DateTime.Now.Ticks);
            int counter = 1;
            int searchLimit = dashboardData.NumberOfSearchesRequiredForToday + 1;

            Logger.Instance.Log(string.Format("Performing {0} searches", searchLimit));

            NavigateToUrl(_browserDriverCurrentSearchUser, "http://www.bing.com/", _minWait);

            while (counter <= searchLimit)
            {
                string term = _searchTerms[_currentSearchTermIndex];
                IWebElement query = _browserDriverCurrentSearchUser.FindElement(By.Name("q")); //config

                query.Clear();
                query.SendKeys(string.Format("{0}", term));
                query.SendKeys(Keys.Enter);

                int waitTime = rand.Next(_minWait, _maxWait);

                int currentPoints = GetCurrentPoints(_appSettings["BindPointsDivId"]);

                WriteToConsoleAndClear(string.Format("[{0}] pausing {{0}} seconds. Points: {1}                             ", counter, currentPoints), waitTime);

                counter++;
                _currentSearchTermIndex++;
                if (_currentSearchTermIndex >= _searchTerms.Count)
                {
                    _currentSearchTermIndex = 0;
                }
            }

            Logger.Instance.Log("Search complete.");
        }

        static string _previousOutputString;
        private DashboardData _dashboardData;

        private void WriteToConsoleAndClear(string output, int waitTime)
        {
            int remainingTime = waitTime;

            if (!string.IsNullOrWhiteSpace(_previousOutputString))
            {
                //clear previous string
                Console.Write("\r".PadRight(_previousOutputString.Length), remainingTime / 1000);
            }

            while (remainingTime > 1000)
            {
                string toWrite = string.Format("\r{0}", output);

                Console.Write(toWrite, remainingTime / 1000);

                Thread.Sleep(1000);

                remainingTime -= 1000;
            }
            _previousOutputString = output;
        }

        private static void NavigateToUrl(IWebDriver browserDriver, string url, int minWait, bool loadTwice = false)
        {
            browserDriver.Navigate().GoToUrl(url);
            Thread.Sleep(minWait);

            if (loadTwice)
            {
                browserDriver.Navigate().GoToUrl(url);
                Thread.Sleep(minWait);
            }

            //this is rarely used, but occasionally the Navigate doesn't make it to the page.
            int loopBuster = 0;
            while (string.Compare(browserDriver.Url, url, StringComparison.CurrentCultureIgnoreCase) != 0 && loopBuster < 10)
            {
                browserDriver.Navigate().GoToUrl(url);
                Thread.Sleep(minWait);
                loopBuster++;
            }
        }

        /// <summary>
        /// attempts to get current points from the dashboard page
        /// </summary>
        /// <returns></returns>
        private DashboardData GetDashBoardData()
        {
            Logger.Instance.LogMethodStart();

            Thread.Sleep(1500);
            NavigateToUrl(_browserDriverCurrentSearchUser, "https://www.bing.com/rewards/dashboard", _minWait, true);

            DashboardData dashboardData = new DashboardData(_browserDriverCurrentSearchUser);

            return dashboardData;
        }

        /// <summary>
        /// attempts to get current points from the page that has been currently navigated to 
        /// by looking for the div passed in
        /// </summary>
        /// <param name="idToFind"></param>
        /// <returns></returns>
        private int GetCurrentPoints(string idToFind)
        {
            int points = 0;
            IWebElement element = _browserDriverCurrentSearchUser.FindElement(By.Id(idToFind));

            if (element != null)
            {
                const int maxTries = 4;
                int tries = 0;
                while (!int.TryParse(element.Text, out points) && tries < maxTries)
                {
                    Thread.Sleep(500);
                    tries++;
                }
            }

            return points;
        }

        private void LogIn()
        {
            Logger.Instance.LogMethodStart();

            NavigateToUrl(_browserDriverCurrentSearchUser, "https://login.live.com/", _minWait);

            IWebElement login = _browserDriverCurrentSearchUser.FindElement(By.Name("login"));//config
            IWebElement passwd = _browserDriverCurrentSearchUser.FindElement(By.Name("passwd"));
            IWebElement signIn = _browserDriverCurrentSearchUser.FindElement(By.Name("SI"));

            Logger.Instance.Log(string.Format("Current User: {0}", _currentUser.AccountName), ConsoleColor.Cyan);
            login.SendKeys(_currentUser.AccountName);
            passwd.SendKeys(_currentUser.Password);
            signIn.Click();

            IWebElement userControlMenu;

            try
            {
                userControlMenu = _browserDriverCurrentSearchUser.FindElement(By.Id("meControlHeader"));

            }
            catch
            {
                try
                {
                    IWebElement element = _browserDriverCurrentSearchUser.FindElement(By.Id("idYesOption"));

                    element.Click();

                    element = _browserDriverCurrentSearchUser.FindElement(By.Id("iLandingViewAction"));

                    element.Click();

                    Thread.Sleep(1000);

                    element = _browserDriverCurrentSearchUser.FindElement(By.Id("iOptionViewAction"));

                    element.Click();

                    userControlMenu = _browserDriverCurrentSearchUser.FindElement(By.Id("meControlHeader"));
                }
                catch
                {
                    userControlMenu = null;
                    WriteToConsoleAndClear(string.Format("Login issue? Pausing {{0}} seconds.                           "), 300000);
                }
            }

            //if (string.Compare(_browserDriverCurrentSearchUser.Url, "https://account.live.com/summarypage.aspx",
            //        StringComparison.CurrentCultureIgnoreCase) != 0)
            if (userControlMenu == null)
            {
                Logger.Instance.Log("Possible error logging in!");
                //throw new Exception("Error logging in to account " + _currentUser.AccountName);
            }
        }

        private bool GetNextUser()
        {
            Logger.Instance.LogMethodStart();
            bool result = false;

            if (++_currentUserIndex < _users.Count)
            {
                _currentUser = _users.ElementAt(_currentUserIndex);
                result = true;
            }

            return result;
        }

        private void GetSearchText()
        {
            try
            {
                Logger.Instance.LogMethodStart();
                _browserDriverSearchText = OpenSearchBrowser();

                NavigateToUrl(_browserDriverSearchText, "http://en.wikipedia.org/wiki/Main_Page", _minWait);

                IWebElement link = _browserDriverSearchText.FindElement(By.LinkText("Full article..."));

                link.Click();

                IWebElement div = _browserDriverSearchText.FindElement(By.Id("bodyContent"));

                string words = div.Text;

                _searchTerms = ParseWords(words);
            }
            catch (Exception)
            {
                _searchTerms = ParseWords(GetDefaultSearchText());
            }
        }

        private List<string> ParseWords(string words)
        {
            //todo: move these words and phrases to the config.
            List<string> result = new List<string>();
            string limitedWords = words.Replace("From Wikipedia, the free encyclopedia", "");
            limitedWords = limitedWords.Replace("\r\n", " ");
            limitedWords = limitedWords.Replace(" a ", " ");
            limitedWords = limitedWords.Replace(" an ", " ");
            limitedWords = limitedWords.Replace(" also ", " ");
            limitedWords = limitedWords.Replace(" and ", " ");
            limitedWords = limitedWords.Replace(" as ", " ");
            limitedWords = limitedWords.Replace(" by ", " ");
            limitedWords = limitedWords.Replace(" for ", " ");
            limitedWords = limitedWords.Replace(" had ", " ");
            limitedWords = limitedWords.Replace(" he ", " ");
            limitedWords = limitedWords.Replace(" if ", " ");
            limitedWords = limitedWords.Replace(" in ", " ");
            limitedWords = limitedWords.Replace(" is ", " ");
            limitedWords = limitedWords.Replace(" its ", " ");
            limitedWords = limitedWords.Replace(" on ", " ");
            limitedWords = limitedWords.Replace(" of ", " ");
            limitedWords = limitedWords.Replace(" than ", " ");
            limitedWords = limitedWords.Replace(" the ", " ");
            limitedWords = limitedWords.Replace(" to ", " ");
            limitedWords = limitedWords.Replace(" up ", " ");
            limitedWords = limitedWords.Replace(" we ", " ");
            limitedWords = limitedWords.Replace(" was ", " ");

            string cleanedWords = string.Empty;

            foreach (char c in limitedWords)
            {
                if (char.IsLetter(c) || c == ' ')
                {
                    cleanedWords += c;
                }
            }

            string[] splitWords = cleanedWords.Split(' ');
            int i = 0;

            while (i < splitWords.Length)
            {
                string token = splitWords[i++];

                while (i < splitWords.Length && token.Length < 20)//config for length
                {
                    token += " " + splitWords[i++];
                }

                result.Add(token);
            }

            return result;
        }
    }
}
