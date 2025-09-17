# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdatePackagePrice do
  let(:honey) { Package.create!(name: 'Dunderhonung', amount_cents: 100_00) }
  let(:meatballs) { Package.create!(name: 'Farmors köttbullar', amount_cents: 100_00) }

  let(:stockholm) { Municipality.create!(name: 'Stockholm') }
  let(:gothenburg) { Municipality.create!(name: 'Göteborg') }

  let(:honey_stockholm) do
    LocalPackage.find_or_create_by!(package: honey, municipality: stockholm) do |it|
      it.amount_cents = honey.amount_cents
    end
  end

  let(:honey_gothenburg) do
    LocalPackage.find_or_create_by!(package: honey, municipality: gothenburg) do |it|
      it.amount_cents = honey.amount_cents
    end
  end

  it 'updates the current price of the provided package' do
    described_class.call(honey, 200_00)
    expect(honey.reload.amount_cents).to eq(200_00)
  end

  it 'only updates the passed package price' do
    expect {
      described_class.call(honey, 200_00)
    }.not_to change {
      meatballs.reload.amount_cents
    }
  end

  it 'stores the old price of the provided package in its price history', :aggregate_failures do
    described_class.call(honey, 200_00)
    expect(honey.prices).to be_one
    price = honey.prices.first
    expect(price.amount_cents).to eq(100_00)
  end

  it 'updates the current price of the provided local package' do
    described_class.call(honey, 200_00, municipality: stockholm)
    expect(honey_stockholm.reload.amount_cents).to eq(200_00)
  end

  it 'only updates the passed package price for the given municipality' do
    expect {
      described_class.call(honey, 200_00, municipality: stockholm)
    }.not_to change {
      honey_gothenburg.reload.amount_cents
    }
  end

  it 'stores the old price of the provided package for the given municipality', :aggregate_failures do
    described_class.call(honey, 200_00, municipality: stockholm)
    expect(honey_stockholm.local_prices).to be_one
    local_price = honey_stockholm.local_prices.first
    expect(local_price.amount_cents).to eq(100_00)
  end

  it 'does not store the old price of the provided package for any other municipality' do
    described_class.call(honey, 200_00, municipality: stockholm)
    expect(honey_gothenburg.local_prices).to be_empty
  end
end
