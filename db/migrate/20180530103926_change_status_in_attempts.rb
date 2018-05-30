class ChangeStatusInAttempts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :attempts, :status, from: nil, to: "undefined"
  end
end
