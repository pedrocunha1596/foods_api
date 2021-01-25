class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :edible_portion
      t.string :code
      t.integer :energy_value
      t.belongs_to :food_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
