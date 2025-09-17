class LocalPrice < ApplicationRecord
  belongs_to :local_package

  validates :amount_cents, presence: true

  def self.from_year(year)
    where("cast(strftime('%Y', created_at) as int) = ?", year)
  end
end
