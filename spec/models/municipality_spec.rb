# frozen_string_literal: true

require "rails_helper"

RSpec.describe Municipality, type: :model do
  it "validates the presence of name" do
    municipality = Municipality.new(name: nil)
    expect(municipality.validate).to eq(false)
    expect(municipality.errors[:name]).to be_present
  end

  it "validates the minimum length of name" do
    municipality = Municipality.new(name: "Ab")
    expect(municipality.validate).to eq(false)
    expect(municipality.errors[:name]).to be_present
  end

  it "validates the maximum length of name" do
    municipality = Municipality.new(name: "Abcdabcdabcdabcd")
    expect(municipality.validate).to eq(false)
    expect(municipality.errors[:name]).to be_present
  end

  it "validates the uniqueness of name" do
    stockholm = Municipality.create(name: "Stockholm")
    municipality = Municipality.create(name: stockholm.name)
    expect(municipality.validate).to eq(false)
    expect(municipality.errors.of_kind?(:name, :taken)).to be_present
  end
end
