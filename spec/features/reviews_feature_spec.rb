require 'rails_helper'
require 'web_helpers'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }
  before { User.create email: 'ali@test.com', password: 'password', password_confirmation: 'password' }

  scenario 'allows users to leave a review using a form' do
     sign_in
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

end
