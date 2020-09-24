class CreateWebsite < ActiveRecord::Migration[6.0]
  def change
    create_table :websites do |t|
      t.string :original_url, null: false
      t.string :short_url
      t.references :user, null: false, foreign_key: true
      t.text :header_values, null: false, array: true, default: [], using: 'gin'

      t.timestamps
    end
  end
end
