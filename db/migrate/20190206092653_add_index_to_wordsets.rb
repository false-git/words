class AddIndexToWordsets < ActiveRecord::Migration[5.2]
  def change
    add_column :wordsets, :index, :integer
  end
end
