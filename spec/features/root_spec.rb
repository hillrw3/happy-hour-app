require "spec_helper"

feature "Welcome page" do
  scenario "homepage should contain greeting and have button to map" do
    visit '/'
    expect(page).to have_content("Happy Hour Finder")
    click_button "Get me there"
    expect(page).to have_content("Nearest Happy Hours")
  end

  scenario "click link and register" do
    visit '/'
    click_link "Not a member? Register here!"
    fill_in 'Username:', with: 'rob'
    fill_in 'Email:', with: 'rob@example.com'
    fill_in 'Password:', with: '123'
    fill_in 'Please re-enter your password:', with: '123'
    click_button "Let's get wild!"
    expect(page).to have_content("Thanks for registering!")
  end

  scenario "sign in to website" do
    visit '/'
    click_link "Log In"
    expect(page).to have_content("Sign on in!")
    fill_in 'Username:', with: 'rob'
    fill_in 'Password:', with: '123'
    click_button "Let's get wild!"
    expect(page).to have_content("Hello again, rob!")
  end

end