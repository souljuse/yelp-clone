require 'rails_helper'

feature "User: " do
  let!(:osteria){ Restaurant.create(name: 'Osteria da Mario', description: 'The best Lasagna in town')}

  context "user not signed in" do

    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end

    it "should not see 'add a restaurant' link" do
      visit('/restaurants/new')
      expect(page).not_to have_link('Create Restaurant')
    end

    it "should not see 'write a review' link" do
      visit("/restaurants/#{osteria.id}")
      expect(page).not_to have_link('Write a review')
    end
  end

  context "user signed up" do
    before do
      sign_up('test@example.com')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end


  context 'user signed in' do
    before do
      sign_up('test@example.com')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
