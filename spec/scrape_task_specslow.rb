require_relative "spec_helper"

describe Gitscraper::ScrapeTask do
	it "its results should contain 100 repositories and 100 users" do
		task = Gitscraper::ScrapeTask.new(60)

		search_url = Gitscraper::SearchURL.new(:repositories, :username => "itZhy", :language => "java")
		50.times { task.add(search_url) }

		search_url = Gitscraper::SearchURL.new(:users, :fullname => "ZhongYu", :location => "chengdu")
		50.times { task.add(search_url) }

		task.results["repositories"].size.should == 50
		task.results["repositories"].uniq.size.should == 1
		task.results["users"].size.should == 50
		task.results["users"].uniq.size.should == 1
	end
end