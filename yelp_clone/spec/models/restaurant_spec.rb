require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "gn")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid if name is not unique' do
    restaurant1 = Restaurant.create(name: "Ciao")
    restaurant2 = Restaurant.new(name: "Ciao")
    expect(restaurant2).to have(1).error_on(:name)
  end
end
