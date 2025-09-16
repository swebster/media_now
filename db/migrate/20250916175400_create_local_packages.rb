class CreateLocalPackages < ActiveRecord::Migration[7.1]
  def change
    create_table :local_packages do |t|
      t.references :package, null: false, foreign_key: { on_delete: :cascade }
      t.references :municipality, null: false, foreign_key: { on_delete: :cascade }
      t.integer :amount_cents, null: false

      t.timestamps
    end
    add_index :local_packages, %i[package_id municipality_id], unique: true
  end
end
