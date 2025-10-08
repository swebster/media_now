class AddCreatedIndexToLocalPrice < ActiveRecord::Migration[7.2]
  def change
    change_table :local_prices do |t|
      t.column :created_year,  :integer, null: false, as: "cast(strftime('%Y', created_at) as int)"
      t.column :created_month, :integer, null: false, as: "cast(strftime('%m', created_at) as int)"
      t.column :created_day,   :integer, null: false, as: "cast(strftime('%d', created_at) as int)"
    end
    # SQLite3 only uses one index per subquery, so local_package_id must prefix
    # the date columns to create a covering index that will be used to select
    # historical prices for a given package
    add_index(
      :local_prices,
      %i[local_package_id created_year created_month created_day],
      name: 'index_local_prices_on_created_date'
    )
  end
end
