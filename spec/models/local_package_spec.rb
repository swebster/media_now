# frozen_string_literal: true

require "rails_helper"

RSpec.describe LocalPackage, type: :model do
  let(:honey) { Package.create!(name: "Dunderhonung", amount_cents: 100_00) }

  let(:stockholm) { Municipality.create!(name: "Stockholm") }

  it "validates the presence of package" do
    local_package = LocalPackage.create(package: nil, municipality: stockholm, amount_cents: 200_00)
    expect(local_package.validate).to eq(false)
    expect(local_package.errors[:package]).to be_present
  end

  it "validates the presence of municipality" do
    local_package = LocalPackage.create(package: honey, municipality: nil, amount_cents: 200_00)
    expect(local_package.validate).to eq(false)
    expect(local_package.errors[:municipality]).to be_present
  end

  it "validates the presence of price_cents" do
    local_package = LocalPackage.create(package: honey, municipality: stockholm, amount_cents: nil)
    expect(local_package.validate).to eq(false)
    expect(local_package.errors[:amount_cents]).to be_present
  end

  it "validates the presence of [package, municipality]" do
    local_package = LocalPackage.create(package: honey, municipality: stockholm, amount_cents: 200_00)
    other_package = LocalPackage.create(package: honey, municipality: stockholm, amount_cents: 100_00)
    expect(other_package.validate).to eq(false)
    expect(other_package.errors.of_kind?(:package_id, :taken)).to be_present
  end
end
