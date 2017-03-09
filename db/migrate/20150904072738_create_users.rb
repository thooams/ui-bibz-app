class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :active
      t.integer :country_id
      t.string :company

      t.timestamps null: false
    end
  end
end
