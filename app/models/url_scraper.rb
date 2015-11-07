class UrlScraper
	attr_accessor :title, :hotness, :image_url, :rating, :director,
	:genre, :release_date, :runtime, :synopsis, :failure

	def scrape_new_movie(url)
		begin
			doc = Nokogiri::HTML(open(url))
			doc.css('script').remove
			self.title = doc.at("//h1[@itemprop = 'name']").text
			self.hotness = doc.at("//span[@itemprop = 'ratingValue']").text.to_i
			self.image_url = doc.at_css('#movie-image-section img')['src']
			self.rating = doc.at("//td[@itemprop = 'contentRating']").text
			self.director = doc.at("//td[@itemprop = 'director']").css('a').first.text
			self.genre = doc.at("//span[@itemprop = 'genre']").text
			self.runtime = doc.at("//time[@itemprop = 'duration']").text
      s = doc.css('#movieSynopsis').text
			unless s.valid_encoding?
				s = s.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
			end
			self.synopsis = s
			return self
		rescue Exception => e
			self.failure = "Something went wrong with the scrape"
			return self
		end
	end
end
