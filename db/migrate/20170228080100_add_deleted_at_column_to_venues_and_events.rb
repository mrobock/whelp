class AddDeletedAtColumnToVenuesAndEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :deleted_at, :datetime
    add_column :events, :deleted_at, :datetime
  end
end
