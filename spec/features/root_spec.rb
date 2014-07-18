require "spec_helper"

feature "Welcome page" do
  scenario "homepage should contain greeting" do
    visit '/'
    expect(page).to have_content("Welcome to my app!")



  end
end