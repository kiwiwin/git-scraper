require 'open-uri'
require 'nokogiri'

module Gitscraper

	class Scraper
        PAGE_MAX = 99
        PAGE_SIZE = 10

		def initialize(url)
			@url = url
			define_singleton_method("single_page_#{@url.type}") { |index| single_page_elements(index) }
			define_singleton_method("#{@url.type}_count") { elements_count }
			define_singleton_method("all_#{@url.type}") { all_elements }
		end

		def page_count
			[(1.0 * elements_count / PAGE_SIZE).ceil, PAGE_MAX].min
		end

		def page_size
			PAGE_SIZE
		end

		private
		def single_page_elements(page_index)
			page = Nokogiri::HTML(open(@url.single_page_url(page_index)))
			page.css("h2[class=title]").css("a").collect { |element| element["href"][1..-1] }
		end

		def elements_count
			page = Nokogiri::HTML(open(@url.search_url))
			page.css("div[class=title]").text.scan(/\((\d+)\)/).flatten[0].to_i
		end

		def all_elements
			(1..page_count).inject([]) do |elements, page_index|
				elements + single_page_elements(page_index)
			end
		end

	end
end
