class DailyWhatever::WhateverLib
	attr_accessor :whatevers
	
	TWITTER = "https://twitter.com"
	
	def initialize
		createWhatevers
	end
	
	def createWhatevers
		#puts "add twitter, quote of the day, etc"
		@whatevers = {
			"Fun Tweets" => self.class.create_funtweets,
			"Cool Funny Quotes" => self.class.create_cool_funny_quote
		}
		whatevers
	end
	
	def self.scrape_debug
		url = gets.strip
		scrape(url)
		binding.pry
	end
	
	def self.scrape(url)
		Nokogiri::HTML(open(url))
	end
	
	def self.create_funtweets
		tweets = scrape("http://funtweets.com").search(".tweet-text")
		tweets.collect do |tweet|
			arr = tweet.text.delete("\r\t").split("\n")			
			h = {
				:author => arr[1],
				:text => arr[2].strip,
				:link => TWITTER + "/#{arr[1].delete("@")}"
			}
			DailyWhatever::Whatever.new(h)
		end
	end
	
	def self.create_cool_funny_quote
		quotes = scrape("http://www.coolfunnyquotes.com/").search(".item")
		quotes.collect do |quote|
			link = quote.search(".author a").attribute("href").value
			link.insert(0, "http://www.coolfunnyquotes.com") unless link.include?('http://')
			h = {
				:author => quote.search(".author").text.strip,
				:text => quote.search(".quote").text.strip
				:link => link
			}
			DailyWhatever::Whatever.new(h)
		end
	end
	
end