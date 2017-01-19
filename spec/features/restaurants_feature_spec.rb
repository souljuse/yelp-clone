require 'rails_helper'

context 'no restaurants have been added'do
  scenario 'should display a prompt to add a restaurant'do
    visit '/restaurants'
    expect(page).to have_content 'No restaurants yet'
    expect(page).to have_link 'Add a restaurant'
  end
end

feature 'restaurants' do

  FactoryGirl.define do
    factory :user, class: User do
      email "mail@mail.com"
      password "123456"
      id 1
      # admin false
    end
  end

  FactoryGirl.define do
    factory :restaurant, class: Restaurant do
      name "Osteria da Mario"
      description "The best Lasagna in town"
      # admin false
    end
  end

  before do
    sign_up('test@example.com')
    user = create(:user)
    @restaurant = user.restaurants.build(attributes_for(:restaurant))
    @restaurant.save
  end

  context 'restaurants have been added' do
    # let!(:user) { User.create(id: 1) }
    # let!(:osteria){ user.restaurants.build(name: 'Osteria da Mario', description: 'The best Lasagna in town')}
    # before do
    #   osteria.save
    # end
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
      expect(current_path).to eq("/restaurants/#{@restaurant.id}")
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
