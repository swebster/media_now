# frozen_string_literal: true

class Municipality < ApplicationRecord
  has_many :local_packages
  has_many :packages, through: :local_packages

  validates :name, presence: true, length: 3..15, uniqueness: true
end
