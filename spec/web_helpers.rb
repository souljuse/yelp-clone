def sign_up
  User.create email: 'ali@test.com', password: 'password', password_confirmation: 'password'
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", with: "ali@test.com"
  fill_in "Password", with: "password"
  click_button "Log in"
end

def sign_in_and_create_restaurant
  sign_in
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end
