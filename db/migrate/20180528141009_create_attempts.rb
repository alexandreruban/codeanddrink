class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.text :player_input
      t.text :spec_output
      t.string :status
      t.references :round, foreign_key: true
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
