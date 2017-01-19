class AddUseridAndDescriptionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :description, :text
    add_reference :events, :user, foreign_key: true
  end
end
