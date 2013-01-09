require_relative "spec_helper"

describe Gitscraper::Scraper do

	let(:dummy_page_index) {1}

	cases = {
		:blank => 0,
		:half => 8,
		:full => 9106
	}

	cases.each do |fixture, expected_user_count|

		context "when #{fixture} user page" do

			before (:each) do
				@scraper = ScraperSpecHelper.create_scraper(:users, fixture)
				@user_list = ScraperSpecHelper.load_result_list(:users, fixture)
			end		

			it "repository number should be #{expected_user_count}" do
				@scraper.users_count.should == expected_user_count
			end

			it "single page repositories should be #{fixture}_repository_list" do
				@scraper.single_page_users(1).should == @user_list
			end

		end

	end

end
