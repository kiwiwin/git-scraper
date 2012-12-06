require_relative "spec_helper"

describe Gitscraper::SearchURL do
	
	it "verify search users url whose location is china" do
			search_url = Gitscraper::SearchURL.new(:users, :location => "china").search_url
			search_url.should == "https://github.com/search?&q=location:china&type=Users"
	end

	it "verify search repositories url whose language is csharp and size is 10" do
			search_url = Gitscraper::SearchURL.new(:repositories, :language => "Csharp", :size => 10).search_url
			search_url.should == "https://github.com/search?&q=language:Csharp+size:10&type=Repositories"
	end

	it "verify search user url whose page index is 10" do
			url = Gitscraper::SearchURL.new(:users, :location => "china")
			url.single_page_url(10).should == "https://github.com/search?&q=location:china&type=Users&p=10"
	end

	it "verify type" do
			url = Gitscraper::SearchURL.new(:users, :location => "china")
			url.type.should == "user"
	end

end
