class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.references :test_papers, foreign_key: true
      t.timestamps
    end
  end
end
