class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.string :state
      t.integer :number_of_winners
      t.references :game, foreign_key: true
      t.references :exercice, foreign_key: true

      t.timestamps
    end
  end
end
