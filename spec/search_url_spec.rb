require_relative "spec_helper"

describe Gitscraper::SearchURL do
	
	it "verify search_users_url whose location is china" do
			search_url = Gitscraper::SearchURL.new(:users, :location => "china").search_url
			search_url.should == "https://github.com/search?&q=location:china&type=Users"
	end

	it "verify search_repositories_url whose language is csharp and size is 10" do
			search_url = Gitscraper::SearchURL.new(:repositories, :language => "Csharp", :size => 10).search_url
			search_url.should == "https://github.com/search?&q=language:Csharp+size:10&type=Repositories"
	end

end
