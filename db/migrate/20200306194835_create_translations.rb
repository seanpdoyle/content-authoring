class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.string :locale, null: false
      t.string :key, null: false
      t.text   :value, null: false
      t.text   :interpolations
      t.boolean :is_proc, default: false

      t.index [:locale, :key], unique: true
    end
  end
end
