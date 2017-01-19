require 'rails_helper'

feature 'endorsing reviews' do
  let!(:user) { User.create(id: 1) }
  let!(:trattoria){ user.restaurants.build(name: 'Trattoria', description: 'Italian food for the masses')}
  before do
    trattoria.save
    rev= trattoria.reviews.build(rating: 3, thoughts: 'Spaghetti and Cappuccino, the best')
    rev.save
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/'
    click_link('Trattoria')
    click_link('Endorse Review')
    expect(page).to have_content('1 endorsement')
  end

end
