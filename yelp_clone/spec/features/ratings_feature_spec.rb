require 'rails_helper'

feature 'ratings' do
  context 'user can rate a restaurant' do
    let!(:chinese){ Restaurant.create(name: 'Chinese Restaurant', description: 'Chinese food for the masses')}

    scenario 'Users can leave a review' do
      visit '/restaurants'
      click_link('Chinese Restaurant')
      click_button('Write a Review')
      fill_in 'Review', with: 'I am not the masses but Chinese food is always nice'
      click_button('Post')
      expect(current_path).to eq('/restaurants/#{chinese.id}')
      expect(page).to have_content('I am not the masses but Chinese food is always nice')
    end
  end
end
