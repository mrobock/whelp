class AddRatingsToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :rating, :integer
  end
end
