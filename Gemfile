source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "rspec-rails"
  gem 'pry'
  gem "pry-byebug"
  gem "rubocop-rails",       require: false
  gem "rubocop-rspec",       require: false
  gem "rubocop-rspec_rails", require: false
end

group :development do
  gem "ruby-lsp",       require: false
  gem "ruby-lsp-rails", require: false
  gem "ruby-lsp-rspec", require: false
end
