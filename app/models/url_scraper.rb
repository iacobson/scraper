class UrlScraper
	attr_reader :url

	def initialize(url)
		@url = url
	end

	def scrape_new_movie
		scraped_data = {}
		begin
			doc = Nokogiri::HTML(open(url))
			doc.css('script').remove
			scraped_data[:title] = doc.at("//h1[@itemprop = 'name']").text
			scraped_data[:hotness] = doc.at("//span[@itemprop = 'ratingValue']").text.to_i
			scraped_data[:image_url] = doc.at_css('#movie-image-section img')['src']
			scraped_data[:rating] = doc.at("//td[@itemprop = 'contentRating']").text
			scraped_data[:director] = doc.at("//td[@itemprop = 'director']").css('a').first.text
			scraped_data[:genre] = doc.at("//span[@itemprop = 'genre']").text
			scraped_data[:runtime] = doc.at("//time[@itemprop = 'duration']").text
			scraped_data[:synopsis] = synopsis_text(doc)

			return scraped_data
		rescue Exception => e
			puts "ERROR" + e.to_s
			scraped_data[:failure] = "Something went wrong with the scrape"
			return scraped_data
		end
	end

	private

	def synopsis_text(doc)
		synopsis = doc.css('#movieSynopsis').text
		unless synopsis.valid_encoding?
			synopsis.encode!("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
		end
		return synopsis
	end


end
