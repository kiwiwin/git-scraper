require 'uri'

module Gitscraper
	class SearchURL

		def initialize(type, param)
			@type = type.to_s
			@param = param
		end

		def type
			@type
		end

		def search_url
			url = "https://github.com/search?&q=#{search_criteria}&type=#{@type.capitalize}"
			URI::encode(url)
		end

		def single_page_url(page_index)
			search_url + URI::encode("&p=#{page_index}")
		end

		def search_criteria
            raw = raw_criteria 
            specific = specific_criteria
            if raw != "" and specific != ""
               raw + "+" + specific 
            else
               raw + specific
            end
		end
        
        def raw_criteria
            @param[:raw] ? @param[:raw].join("+") : ""
        end
        
        def specific_criteria
            params = @param.select { |key, val| key.to_s != 'raw' }
            params.inject([]) { |res, pair| res << pair.join(":") }.join('+')
        end
	end
end
