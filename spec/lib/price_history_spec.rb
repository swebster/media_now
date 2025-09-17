# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceHistory do
  let(:premium) { Package.create!(name: 'Premium', amount_cents: 100_00) }
  let(:bas) { Package.create!(name: 'Bas', amount_cents: 100_00) }

  let(:stockholm) { Municipality.create!(name: 'Stockholm') }
  let(:gothenburg) { Municipality.create!(name: 'Göteborg') }

  def add_historical_price(package, municipality, price_cents, date_string)
    local_package = LocalPackage.find_or_create_by!(package:, municipality:) do |it|
      it.amount_cents = 0
    end

    created_at = Time.zone.parse(date_string)
    LocalPrice.create!(local_package:, amount_cents: price_cents, created_at:)
  end

  before do
    add_historical_price(premium, stockholm,  100_00, '2023-04-01')
    add_historical_price(premium, stockholm,  125_00, '2023-08-02')
    add_historical_price(premium, stockholm,  175_00, '2023-12-24')
    add_historical_price(premium, gothenburg,  25_00, '2022-09-01')
    add_historical_price(premium, gothenburg,  50_00, '2023-02-03')
    add_historical_price(premium, gothenburg,  75_00, '2023-05-20')
    add_historical_price(bas,     gothenburg, 100_00, '2023-06-01')
  end

  it 'reports the correct history for all municipalities' do
    price_history = described_class.call(year: '2023', package: premium)
    expected_history = { 'Stockholm' => [100_00, 125_00, 175_00], 'Göteborg' => [50_00, 75_00] }
    expect(price_history).to eq(expected_history)
  end

  it 'reports the correct history for the given municipality' do
    price_history = described_class.call(year: '2023', package: premium, municipality: gothenburg)
    expected_history = { 'Göteborg' => [50_00, 75_00] }
    expect(price_history).to eq(expected_history)
  end
end
