require 'rails_helper'

describe Restaurant, type: :model do
  let(:user){ User.create email: 'ali@test.com', password: 'password', password_confirmation: 'password'}
  let(:tavern){ Restaurant.create(name: "Moe's Tavern")}
  let(:review_params) { {rating: 5, thoughts: 'yum'} }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user.restaurants.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
    describe 'build_with_user' do

      subject(:review) { tavern.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end
end
