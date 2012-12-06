require 'uri'
require 'active_support/inflector'

module Gitscraper
	class SearchURL

		def initialize(type, param)
			@type = type.to_s
			@param = param
		end

		def type
			@type.singularize
		end

		def search_url
			url = "https://github.com/search?&q=#{search_criteria}&type=#{@type.pluralize.capitalize}"
			URI::encode(url)
		end

		def single_page_url(page_index)
			search_url + URI::encode("&p=#{page_index}")
		end

		def search_criteria
			@param.to_a.inject([]) { |res, pair| res << pair.join(":") }.join('+')
		end
	end
end
