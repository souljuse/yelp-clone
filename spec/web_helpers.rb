def sign_in
  visit '/users/sign_in'
  fill_in "Email", with: "ali@test.com"
  fill_in "Password", with: "password"
  click_button "Log in"
end
