using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

using OpenQA.Selenium;

namespace BingRewards
{
	public class DashboardData
	{
		private int _pointsCollectedToday;
		private int _maxPointsAvailableToCollectToday;
		
		private string _progress  = string.Empty; ////x of y credits
		private string _searchDescription = string.Empty;
		private int _multiplier;

		public DashboardData(IWebDriver browserDriver)
		{
			//finds the "available credits section"
			LoadAvailableAndLifeTimePoints(browserDriver);

			//where text = x of y credits
			LoadPointsCollectedData(browserDriver);
			
			if (PointsTargetForToday > 0)
			{
				LoadSearchDescriptionAndMultiplier(browserDriver);
			}
			else
			{
				Multiplier = 0;
			}
		}

		private void LoadAvailableAndLifeTimePoints(IWebDriver browserDriver)
		{
			IWebElement element = browserDriver.FindElement(By.CssSelector(".credits-left"));
		    element = element.FindElement(By.CssSelector(".credits"));

			int points;
			if (element != null)
			{
				int maxTries = 4;
				int tries = 0;
				while (!int.TryParse(element.Text, out points)
				       && tries < maxTries)
				{
					Thread.Sleep(500);
					tries++;
				}
				AvailablePoints = points;
			}

			//finds the "lifetime credits secition"
            element = browserDriver.FindElement(By.CssSelector(".credits-right"));
            element = element.FindElement(By.CssSelector(".credits"));

            if (element != null)
			{
				int maxTries = 4;
				int tries = 0;
				while (!int.TryParse(element.Text, out points)
				       && tries < maxTries)
				{
					Thread.Sleep(500);
					tries++;
				}
				LifetimePoints = points;
			}
		}

		private void LoadPointsCollectedData(IWebDriver browserDriver)
		{
			var element = browserDriver.FindElement(By.CssSelector("a[id^='srch'] .progress"));
			if (element != null)
			{
				//where text = x of y credits
				_progress = element.Text; //x of y credits
				var words = _progress.Split(' ');
				if (words.Length == 4)
				{
					int.TryParse(words[0], out _pointsCollectedToday);
					int.TryParse(words[2], out _maxPointsAvailableToCollectToday);
				}
				else //all points collected!
				{
					int.TryParse(words[0], out _maxPointsAvailableToCollectToday);
					_pointsCollectedToday = _maxPointsAvailableToCollectToday;
				}
			}
			
		}

		private void LoadSearchDescriptionAndMultiplier(IWebDriver browserDriver)
		{
			var element = browserDriver.FindElement(By.CssSelector("a[id^='srch'] .desc"));
			//load search description and multiplier
			_searchDescription = element.Text;
			if (_searchDescription != null && _searchDescription.Length >= 19)
			{
				string substring = _searchDescription.Substring(18, 1);
				int.TryParse(substring, out _multiplier);
			}
		}

		/// <summary>
		/// Total available points at the point the dashboard was checked
		/// </summary>
		public int AvailablePoints
		{
			get;
			private set;
		}

		/// <summary>
		/// Total lifetime points at the point the dashboard was checked
		/// </summary>
		public int LifetimePoints
		{
			get;
			set;
		}

		public int Multiplier
		{
			get
			{
				return _multiplier;
			}
			private set
			{
				_multiplier = value;
			}
		}

		public string Progress
		{
			get
			{
				return _progress;
			}
			private set
			{
				_progress = value;
			}
		}

		/// <summary>
		/// The number of points that have been collected today
		/// </summary>
		public int PointsCollectedToday
		{
			get
			{
				return _pointsCollectedToday;
			}
		}

		/// <summary>
		/// The max number of points available for today
		/// </summary>
		public int MaxPointsAvailableToCollectToday
		{
			get
			{
				return _maxPointsAvailableToCollectToday;
			}
		}

		/// <summary>
		/// number of uncollected points for today
		/// </summary>
		public int PointsTargetForToday
		{
			get
			{
				return MaxPointsAvailableToCollectToday - PointsCollectedToday;
			}
		}
		
		/// <summary>
		/// number of searches required for today to get all points available for today
		/// </summary>
		public int NumberOfSearchesRequiredForToday
		{
			get
			{
				return PointsTargetForToday * Multiplier;
			}
		}

		public string SearchDescription
		{
			get
			{
				return _searchDescription;
			}
			private set
			{
				_searchDescription = value;
			}
		}
	}
}
