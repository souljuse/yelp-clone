require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added'do
    scenario 'should display a prompt to add a restaurant'do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
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
     expect(page).to have_content 'Osteria di Mario'
     expect(page).to have_content 'Deep fried spaghetti'
     expect(current_path).to eq '/restaurants'
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
