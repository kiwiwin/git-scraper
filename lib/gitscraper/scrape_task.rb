require 'threadpool'
require_relative 'search_url'
require_relative 'scraper'

module Gitscraper
	class ScrapeTask
		class ScrapeJob < Job
			def initialize(scraper, results, mutex)
				@scraper = scraper
				@results = results
				@mutex = mutex
			end

			def run
				results = @scraper.send("all_#{@url.type.pluralize}")
				@mutex.synchronize { @results[@url.type.pluralize] += results }
			end
		end

		def initialize(thread_num = 50)
			@threadpool = Threadpool.new(thread_num, thread_num, 600)
			@urls = Array.new
			@mutex = Mutex.new
			@results = Hash.new([])
		end

		def add(search_url)
			@urls << search_url
		end

		def results
			run
			@urls.clear
			@results
		end	

		private

		def run
			@urls.each { |url| @threadpool.load(ScrapeJob.new(Scraper.new(url), @results, @mutex)) }
			@threadpool.shutdown unless @urls.empty?
		end
	end
end

	