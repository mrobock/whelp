class AddLongitudeAndLatitude < ActiveRecord::Migration[5.0]
  def change
    # Creates a column called longitude to the table venues of type float
    add_column :venues, :longitude, :float
    # Creates a column called latitude to the table venue of type float
    add_column :venues, :latitude, :float
  end
end
