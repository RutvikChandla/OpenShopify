class AddThemeToSqlTemplate < ActiveRecord::Migration[7.1]
  def change
    add_reference :sql_templates, :theme, null: false, foreign_key: true
  end
end
