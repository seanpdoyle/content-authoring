class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.text :hero_text, null: false
      t.text :headline_text, null: false
      t.text :body_text, null: false

      t.index :slug, unique: true
    end
  end
end
