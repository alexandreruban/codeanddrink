class CreateExercices < ActiveRecord::Migration[5.2]
  def change
    create_table :exercices do |t|
      t.string :title
      t.text :rules
      t.text :specs
      t.text :solution

      t.timestamps
    end
  end
end
