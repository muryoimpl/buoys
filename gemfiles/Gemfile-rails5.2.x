source 'https://rubygems.org'

gem 'rails', '~> 5.2.0'
gem 'sqlite3'

gem 'buoys', path: '../'

group :test do
  gem 'rubocop', '~> 0.49', '>= 0.49.1'
end
