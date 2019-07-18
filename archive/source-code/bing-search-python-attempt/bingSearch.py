import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys



class BingSearch:
	browser = webdriver.Chrome()

	def navigateToUrl(self, url):
		BingSearch.browser.get(url)

                #assert 'Yahoo' in browser.title

                #elem = browser.find_element_by_name('p')  # Find the search box
                #elem.send_keys('seleniumhq' + Keys.RETURN)


        def doSearches(self):
                self.navigateToUrl("http://www.bing.com/")
                elem = BingSearch.browser.find_element_by_name('q')  # Find the search box
                elem.send_keys('google' + Keys.RETURN)
                time.sleep(10)
                BingSearch.browser.quit()


searcher = BingSearch()

searcher.doSearches()
