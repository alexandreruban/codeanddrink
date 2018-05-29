class RenameExercicesToExercises < ActiveRecord::Migration[5.2]
  def change
    rename_table :exercices, :exercises
  end
end
