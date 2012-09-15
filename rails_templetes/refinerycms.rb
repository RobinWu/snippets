require 'rbconfig'
VERSION_BAND = '2.0.0'

gsub_file 'Gemfile', "gem 'jquery-rails'", "gem 'jquery-rails', '~> 2.0.0'"

append_file 'Gemfile', <<-GEMFILE
gem 'refinerycms', '~> #{VERSION_BAND}'
gem 'refinerycms-i18n', '~> #{VERSION_BAND}'
#  gem 'refinerycms-blog', '~> #{VERSION_BAND}'
#  gem 'refinerycms-inquiries', '~> #{VERSION_BAND}'
#  gem 'refinerycms-search', '~> #{VERSION_BAND}'
#  gem 'refinerycms-page-images', '~> #{VERSION_BAND}'

gem 'execjs'
gem 'therubyracer'

group :production do
  gem 'activerecord-postgresql-adapter'
  gem 'pg'
end
GEMFILE


run 'bundle install'
rake 'db:create'
generate "refinery:cms --fresh-installation #{ARGV.join(' ')}"

say <<-SAY
  ============================================================================
    Your new Refinery CMS application is now installed and mounts at '/'

    heroku create
    heroku run bundle install
    heroku run rake db:migrate RAILS_ENV=production
    heroku run rake db:seed RAILS_ENV=production
    heroku run touch ./tmp/restart.txt
  ============================================================================
SAY

