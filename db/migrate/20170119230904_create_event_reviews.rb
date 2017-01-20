class CreateEventReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :event_reviews do |t|
      t.text :review
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
