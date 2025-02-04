require 'spec_helper'

feature 'statements' do
  attr_reader :statement

  before do
    seed_data
  end

  context "non logged user" do
    scenario "should list opinions" do
      visit statements_path
      expect(page).to have_content("#{@statement.content}")
      expect(page).to have_content("2")
    end

    scenario "can sign up only with email" do
      15.times{ create(:agreement, statement: @statement, individual: create(:individual), reason: "blabla", extent: 100)}
      visit statement_path(@statement)
      fill_in :individual_email, with: "hec@hec.com"
      expect{ click_button "Sign up" }.to change{ Individual.count }.by(1)
      expect(Individual.last.email).to eq "hec@hec.com"
    end
  end

  context "logged in as hector" do
    before do
      visit "/auth/twitter"
      Individual.last.update_attributes(admin: true)
      visit statements_path
    end

    scenario "should list opinions" do
      expect(page).to have_content("#{@statement.content}")
      expect(page).to have_content("2")
    end

    scenario "should allow to destroy statement" do
      @statement.agreements.map{|a| a.destroy}
      visit edit_statement_path(@statement)
      click_link "Delete"
      expect(page).not_to have_content("#{@statement.content} (2 opinions)")
    end

    scenario "should add a tag" do
      visit edit_statement_path(@statement)
      fill_in :statement_tag_list, with: "Space"
      click_button "Update"
      expect(@statement.reload.tag_list.include?("Space")).to eq true
    end
  end

  def seed_data
    @statement = create(:statement)
    @profession = create(:profession, name: "Economist")
    create(:agreement, statement: @statement, individual: create(:individual), reason: "blabla", extent: 100)
    create(:agreement, statement: @statement, individual: create(:individual, profession: @profession), reason: "blabla", extent: 100)
  end
end
