class ChangeTranslationsValueToAllowNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :translations, :value, null: true
  end
end
