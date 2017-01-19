class CreateVenueReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :venue_reviews do |t|
      t.text :review
      t.references :user, foreign_key: true
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
