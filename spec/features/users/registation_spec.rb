require "spec_helper"

describe "Signing up" do
	it "allows a user to sign up for the site and creates the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First name", with: "Alexander"
		fill_in "Last name",	with: "The Great"
		fill_in "Email",	with: "asd@asd.asd"
		fill_in "Password",	with: "1234567890"
		fill_in "Password confirmation",	with: "1234567890"
		click_button "Sign Up"

		expect(User.count).to eq(1)
	end
end