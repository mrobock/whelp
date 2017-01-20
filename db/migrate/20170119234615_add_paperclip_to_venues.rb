class AddPaperclipToVenues < ActiveRecord::Migration[5.0]
  def change
    add_attachment :venues, :image
  end
end
