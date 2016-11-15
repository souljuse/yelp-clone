require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added'do
    scenario 'should display a prompt to add a restaurant'do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    let!(:osteria){ Restaurant.create(name: 'Osteria da Mario', description: 'The best Lasagna in town')}

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Osteria da Mario')

      expect(page).not_to have_content('No restaurants yet')
    end

    scenario 'see the restaurant by clicking on its name' do
      visit '/restaurants'
      click_link('Osteria da Mario')
      expect(page).to have_content('Osteria da Mario')
      expect(page).to have_content('The best Lasagna in town')
      expect(current_path).to eq("/restaurants/#{osteria.id}")
    end

    scenario 'let a user edit a restaurant' do
       visit '/restaurants'
       click_link 'Edit Osteria da Mario'
       fill_in 'Name', with: 'Osteria di Mario'
       fill_in 'Description', with: 'Deep fried spaghetti'
       click_button 'Update Restaurant'
       expect(current_path).to eq '/restaurants'
       click_link('Osteria di Mario')
       expect(page).to have_content 'Osteria di Mario'
       expect(page).to have_content 'Deep fried spaghetti'
    end

    scenario 'user can delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete Osteria da Mario'
      expect(page).not_to have_content('Osteria da Mario')
      expect(current_path).to eq('/restaurants')
      expect(page).to have_content('Restaurant deleted successfully')
    end

    scenario 'user cannot create a restaurant with a name which is already in use' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name' , with: 'Osteria da Mario'
      fill_in 'Description' , with: 'That\'s chicken!!'
      click_button('Create Restaurant')
      expect(current_path).to eq('/restaurants')
      expect(page).to have_content('error')
    end
  end

  context 'create new restaurant' do
    scenario 'user can create a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name' , with: 'Nandos'
      fill_in 'Description' , with: 'That\'s chicken!!'
      click_button('Create Restaurant')
      expect(current_path).to eq('/restaurants')
    end
  end

  context 'creating restaurants' do
    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'gn'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'gn'
        expect(page).to have_content('Name is too short (minimum is 3 characters)')
      end
    end
  end

end
