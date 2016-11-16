require 'rails_helper'

feature 'ratings' do
  context 'user can rate a restaurant' do
    let!(:chinese){ Restaurant.create(name: 'Chinese Restaurant', description: 'Chinese food for the masses')}

    scenario 'Users can leave a review' do
      visit '/restaurants'
      click_link('Chinese Restaurant')
      click_link('Write a Review')
      fill_in 'review_thoughts', with: 'I am not the masses but Chinese food is always nice'
      click_button('Create Review')
      expect(current_path).to eq("/restaurants/#{chinese.id}")
      expect(page).to have_content('I am not the masses but Chinese food is always nice')
    end
  end
end
