class AddTemplateToExercise < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :template, :text
  end
end
