class CreateTestPapers < ActiveRecord::Migration[5.2]
  def change
    create_table :test_papers do |t|
      t.integer :time_allowed
      t.string :test_details
      t.references :questions, foreign_key: false , array: true
      t.boolean :status, default:true
      t.timestamps
    end
  end
end
