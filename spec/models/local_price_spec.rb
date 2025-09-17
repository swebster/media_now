# frozen_string_literal: true

require "rails_helper"

RSpec.describe LocalPrice, type: :model do
  it "validates the presence of price_cents" do
    local_price = LocalPrice.new
    expect(local_price.validate).to eq(false)
    expect(local_price.errors[:amount_cents]).to be_present
  end

  it "validates the presence of local_package" do
    local_price = LocalPrice.new
    expect(local_price.validate).to eq(false)
    expect(local_price.errors[:local_package]).to be_present
  end
end
