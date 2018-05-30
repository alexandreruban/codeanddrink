class AddDefaultStatusToPlayers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :players, :status, from: nil, to: "alive"
  end
end
