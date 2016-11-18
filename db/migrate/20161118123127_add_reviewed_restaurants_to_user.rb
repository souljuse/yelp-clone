class AddReviewedRestaurantsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reviewed_restaurants, :integer
  end
end
