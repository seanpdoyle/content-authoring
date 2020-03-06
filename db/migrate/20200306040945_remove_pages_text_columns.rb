class RemovePagesTextColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :pages, :hero_text, :text, null: false
    remove_column :pages, :headline_text, :text, null: false
    remove_column :pages, :body_text, :text, null: false
  end
end
