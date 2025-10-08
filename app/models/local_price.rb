class LocalPrice < ApplicationRecord
  belongs_to :local_package

  validates :amount_cents, presence: true

  def self.from_date(year:, month: nil, day: nil)
    params = { created_year: year, created_month: month, created_day: day }.compact
    template = params.keys.map { |it| "#{it} = ?" }.join(' and ')
    where([template, *params.values])
  end
end
