class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :user, foreign_key: true
      t.references :word, foreign_key: true
      t.integer :q_a_ok
      t.integer :q_a_ng
      t.integer :a_q_ok
      t.integer :a_q_ng

      t.timestamps
    end
  end
end
