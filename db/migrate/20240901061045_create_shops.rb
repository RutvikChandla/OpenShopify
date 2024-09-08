class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :domain
      t.integer :current_theme

      t.timestamps
    end
  end
end
