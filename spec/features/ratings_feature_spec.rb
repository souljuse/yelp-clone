require 'rails_helper'

feature 'Rate a restaurant:' do
  let!(:user) { User.create(id: 1) }
  let!(:chinese){ user.restaurants.build(name: 'Chinese Restaurant', description: 'Chinese food for the masses')}
  before do
    sign_up('ciao@example.com')
    chinese.save
  end

  def leave_review(thoughts, rating)
    visit '/'
    click_link('Chinese Restaurant')
    click_link('Write a Review')
    fill_in 'review_thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button('Create Review')
  end

  context 'user can rate a restaurant' do
    scenario 'Users can leave a review' do
      leave_review('I am not the masses but Chinese food is always nice', 3)
      click_link('Chinese Restaurant')
      expect(current_path).to eq("/restaurants/#{chinese.id}")
      expect(page).to have_content('I am not the masses but Chinese food is always nice')
      expect(page).to have_content('★★★☆☆')
    end
  end

  context 'User cannot rate' do
    scenario 'a restaurant twice' do
      leave_review('I am not the masses but Chinese food is always nice', 3)
      expect(page).not_to have_link('Write a Review')
    end
  end

  context 'More users leave reviews' do
    scenario 'displays an average rating for all reviews' do
      leave_review('So so', 3)
      click_link('Sign out')
      sign_up('test@example.com')
      leave_review('Great', 5)
      click_link('Chinese Restaurant')
      expect(page).to have_content(('Average rating: ★★★★☆'))
    end
  end
end
