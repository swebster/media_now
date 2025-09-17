class CreateLocalPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :local_prices do |t|
      t.references :local_package, null: false, foreign_key: { on_delete: :cascade }
      t.integer :amount_cents, null: false

      t.timestamps
    end
  end
end
