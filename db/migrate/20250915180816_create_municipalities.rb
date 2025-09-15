class CreateMunicipalities < ActiveRecord::Migration[7.1]
  def change
    create_table :municipalities do |t|
      t.string :name, limit: 15, null: false

      t.timestamps
    end
    add_index :municipalities, :name, unique: true
  end
end
