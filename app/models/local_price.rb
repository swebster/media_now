class LocalPrice < ApplicationRecord
  belongs_to :local_package

  validates :amount_cents, presence: true
end
