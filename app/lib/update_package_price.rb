# frozen_string_literal: true

class UpdatePackagePrice
  def self.call(package, new_price_cents, **options)
    if options.compact.include?(:municipality)
      update_local(package, options[:municipality], new_price_cents)
    else
      update(package, new_price_cents)
    end
  end

  private_class_method def self.update_local(package, municipality, new_price_cents)
    LocalPackage.transaction do
      # Find or create the relevant local package
      local_package = LocalPackage.find_or_create_by!(package:, municipality:) do |it|
        it.amount_cents = package.amount_cents
      end

      # Add a local pricing history record
      LocalPrice.create!(local_package:, amount_cents: local_package.amount_cents)

      # Update the current local price
      local_package.update!(amount_cents: new_price_cents)
    end
  end

  private_class_method def self.update(package, new_price_cents)
    Package.transaction do
      # Add a pricing history record
      Price.create!(package: package, amount_cents: package.amount_cents)

      # Update the current price
      package.update!(amount_cents: new_price_cents)
    end
  end
end
