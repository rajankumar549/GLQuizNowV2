class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.references :test_papers, foreign_key: true
      t.references :users, foreign_key: true
      t.integer :time_taken
      t.string :status
      t.integer :total
      t.integer :result
      t.timestamps
    end
  end
end
