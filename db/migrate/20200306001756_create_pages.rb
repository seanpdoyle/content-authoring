class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :name, null: false

      t.text :headline, null: false
    end
  end
end
