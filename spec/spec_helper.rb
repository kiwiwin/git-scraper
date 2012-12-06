Dir[File.dirname(__FILE__) + "/../lib/*.rb"].each do |source_file|
	require source_file
end


class ScraperSpecHelper
	class << self

		def create_scraper(type, fixture)
			stub_url = StubSearchURL.new(type, html_fixture(type, fixture))
			scraper = Gitscraper::Scraper.new(stub_url) 
		end

		def load_result_list(type, fixture)
			File.open(result_fixture(type, fixture)).readlines.collect { |line| line.chomp }
		end

		def html_fixture(type, fixture)
			fixture_file("#{fixture}_#{type}_page.html")
		end

		def result_fixture(type, fixture)
			fixture_file("#{fixture}_#{type}_list")
		end

		def fixture_file(name)
			"#{File.dirname(__FILE__)}/fixture/#{name}"
		end
	end
end

class StubSearchURL < Gitscraper::SearchURL
	def initialize(type, filename)
		@type = type.to_s
		@filename = filename
	end

	def search_url
		@filename
	end

	def single_page_url(page_index)
		@filename
	end
end

