# This migration comes from i18n_postgres_json_engine (originally 20200409133306)
class CreateI18nPostgresJsonBackendTranslations < ActiveRecord::Migration[4.2]
  def change
    create_table :i18n_postgres_json_backend_translations do |t|
      t.string :locale, null: false
      t.json :translations, null: false, default: {}
      t.timestamps null: false

      t.index :locale, unique: true
    end
  end
end
