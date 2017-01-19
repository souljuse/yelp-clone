require 'rails_helper'

feature 'endorsing reviews' do
  let!(:user) { User.create(id: 1) }
  let!(:trattoria){ user.restaurants.build(name: 'Chinese Restaurant', description: 'Italian food for the masses')}
  before do
    trattoria.save
    rev= trattoria.reviews.build(rating: 3, thoughts: 'Spaghetti and Cappuccino, the best')
    rev.save
  end

  # it 'a user can endorse a review, which updates the review endorsement count', js: true do
  #   sign_up('test@example.com')
  #   leave_review('Spaghetti and Cappuccino, the best', 3)
  #   click_link("Chinese Restaurant")
  #   click_link('Endorse')
  #   expect(page).to have_content("1 endorsement")
  # end

end
