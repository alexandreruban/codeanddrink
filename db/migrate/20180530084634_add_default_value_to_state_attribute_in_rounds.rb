class AddDefaultValueToStateAttributeInRounds < ActiveRecord::Migration[5.2]
  def change
    change_column_default :rounds, :state, from: nil, to: "not started"
  end
end
