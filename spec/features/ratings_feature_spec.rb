require 'rails_helper'

feature 'Rate a restaurant:' do
  let!(:user) { User.create(id: 1) }
  let!(:chinese){ user.restaurants.build(name: 'Chinese Restaurant', description: 'Chinese food for the masses')}
  before do
    sign_up
    chinese.save
  end

  context 'user can rate a restaurant' do
    scenario 'Users can leave a review' do
      visit '/'
      click_link('Chinese Restaurant')
      click_link('Write a Review')
      fill_in 'review_thoughts', with: 'I am not the masses but Chinese food is always nice'
      click_button('Create Review')
      click_link('Chinese Restaurant')
      expect(current_path).to eq("/restaurants/#{chinese.id}")
      expect(page).to have_content('I am not the masses but Chinese food is always nice')
    end
  end

  context 'User cannot rate' do
    scenario 'a restaurant twice' do
      visit '/'
      click_link('Chinese Restaurant')
      click_link('Write a Review')
      fill_in 'review_thoughts', with: 'I am not the masses but Chinese food is always nice'
      click_button('Create Review')
      expect(page).not_to have_link('Write a Review')
    end
  end
end
