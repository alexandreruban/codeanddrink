class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :wifi_network
      t.string :wifi_password
      t.references :game_master, foreign_key: true
      t.datetime :starts_at
      t.string :password

      t.timestamps
    end
  end
end
