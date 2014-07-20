require "spec_helper"

feature "Welcome page" do
  scenario "homepage should contain greeting and have button to map" do
    visit '/'
    expect(page).to have_content("Welcome to my app!")
    click_button "Get me there"
    expect(page).to have_content("Nearest Happy Hours")
  end
end