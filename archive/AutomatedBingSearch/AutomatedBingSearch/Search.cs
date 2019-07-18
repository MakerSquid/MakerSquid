using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

using NCM.Fathom.Tools;

namespace AutomatedBingSearch
{
    public class Search
    {

        public static void Bing()
        {
            WebTools tools = new WebTools();
            const string BING_URL = "http://www.bing.com/search?q=";
            string page = string.Empty;

            List<string> searchTerms = new List<string> { "stuff", "dude", "powershell", "cmdlet"
                , "things", "rewards", "points", "batman", "joker", "fries", "catwoman", "huntress"
                , "poison ivy", "robin", "gotham city", "bruce wayne", "Trader Joes", "Arkham City", "Round Table Pizza", "xbox"};

            foreach (string term in searchTerms)
            {
                page = tools.GetWebPage(BING_URL + HttpUtility.UrlEncode(term));
            }

            if (page.Contains("Earn 3 Credit"))
            {

            }

	// Here we call Regex.Match.
	Match match = Regex.Match(page, @"content/([A-Za-z0-9\-]+)\.aspx$",
	    RegexOptions.IgnoreCase);

	// Here we check the Match instance.
	if (match.Success)
	{
	    
	}
       }
    }
}
