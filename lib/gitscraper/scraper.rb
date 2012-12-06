require 'open-uri'
require 'nokogiri'

module Gitscraper

	class Scraper

		def initialize(url, page_size = 10)
			@url = url
			@page_size = page_size
			define_singleton_method("single_page_#{@url.type.pluralize}") { |index| single_page_elements(index) }
			define_singleton_method("#{@url.type.pluralize}_count") { elements_count }
			define_singleton_method("#{@url.type.pluralize}") { all_elements }
		end

		def page_number
			github_max_pages = 99
			[(1.0 * element_number / page_size).ceil, github_max_pages].min
		end

		def page_size
			@page_size
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
			(1..page_number).inject([]) do |elements, page_index|
				elements + single_page_elements(page_index)
			end
		end

	end
end
