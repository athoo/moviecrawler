require "mechanize"

mechanize = Mechanize.new

page = mechanize.get('http://www.atmovies.com.tw/movie/movie_new.html')

def get_names(page)
	names = page.parser.xpath("//div[@class = 'title']/a")
	#.to_s.gsub(/[\t]/,"").gsub(/s/,"")
	out = []
	names.each do |name|
		name = name.text.strip
		name = name.gsub(/\s/,"")
		out = out.push(name)
		# puts name
	end

	return out
end

def get_dates(page)
	dates = page.parser.xpath("//div[@class = 'date']/b/text()").to_s.gsub(' (','：').gsub(' ','').split(')')
	dates=dates.map {|date|date.gsub(/\s+/,"")}
	return dates
end

def get_stories(page)
	stories = page.parser.xpath("//div[@class = 'story']/text()")
	return stories
end

class Movie
	def initialize(name,date,story)
		@name = name
		@date = date
		@story = story
	end
	def visualize
		puts @name,@date
	end
end

names=get_names(page)
dates=get_dates(page)
stories=get_stories(page)
# puts names[0]
newdataset = names.zip(dates,stories)
# newdataset.each{|item|
# puts item
# }
puts newdataset[1]
# newdataset.map{|itm|
# 	puts itm
# }
# dataset.map{}
# example = Movie.new('jack is you',6,333,444,252)
# example.visualize