class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :text
      t.references :user, foreign_key: true
      t.references :venue, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
