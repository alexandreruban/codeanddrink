class RenameExerciceColumnInRounds < ActiveRecord::Migration[5.2]
  def change
    rename_column :rounds, :exercice_id, :exercise_id
  end
end
