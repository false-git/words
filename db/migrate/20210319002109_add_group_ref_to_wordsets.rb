class AddGroupRefToWordsets < ActiveRecord::Migration[5.2]
  def change
    add_reference :wordsets, :group, foreign_key: true
  end
end
