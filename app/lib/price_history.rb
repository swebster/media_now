# frozen_string_literal: true

# reports the history of the relevant local (not global) prices
class PriceHistory
  def self.call(year:, package:, municipality: nil)
    if municipality.present?
      history_local(package, municipality, year.to_i)
    else
      history(package, year.to_i)
    end
  end

  private_class_method def self.history_local(package, municipality, year)
    local_package = LocalPackage.find_by(package:, municipality:)

    local_prices = local_package ? extract_prices(local_package, year) : []

    { municipality.name => local_prices }
  end

  private_class_method def self.history(package, year)
    local_packages = package.local_packages

    return {} if local_packages.nil?

    local_packages.map { |it| [it.municipality.name, extract_prices(it, year)] }.to_h
  end

  # extract the prices for the given year and sort them chronologically
  private_class_method def self.extract_prices(local_package, year)
    local_prices = local_package.local_prices.from_year(year).order(:created_at)

    local_prices.map(&:amount_cents)
  end
end
