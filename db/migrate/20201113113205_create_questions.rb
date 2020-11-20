class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :statement
      t.string :options, array:true
      t.string :correct
      t.integer :weightage, default:1
      t.string :tag, array:true
      t.boolean :status, default:true
      t.timestamps
    end
  end
end