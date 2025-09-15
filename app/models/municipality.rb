# frozen_string_literal: true

class Municipality < ApplicationRecord
  validates :name, presence: true, length: 3..15, uniqueness: true
end
