class CreateComponents < ActiveRecord::Migration[6.1]
  def change
    create_table :components do |t|
      t.string :name
      t.belongs_to :component_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
