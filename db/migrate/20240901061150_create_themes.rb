class CreateThemes < ActiveRecord::Migration[7.1]
  def change
    create_table :themes do |t|
      t.string :name
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
