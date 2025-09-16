# frozen_string_literal: true

class LocalPackage < ApplicationRecord
  belongs_to :package
  belongs_to :municipality

  validates :amount_cents, presence: true

  validates :package_id, uniqueness: {
    scope: :municipality_id,
    message: "already exists for this municipality"
  }
end
