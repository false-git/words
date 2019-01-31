class AddIndexToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :index, :integer
  end
end
