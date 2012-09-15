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

gsub_file 'config/initializers/refinery/i18n.rb', "", ""
gsub_file 'config/initializers/refinery/i18n.rb', "# config.enabled = true", "config.enabled = true"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.default_locale = :en", "config.default_locale = 'zh-CN'"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.current_locale = :en", "config.current_locale = 'zh-CN'"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.default_frontend_locale = :en", "config.default_frontend_locale = 'zh-CN'"

run 'git init'
run 'git add .'
run "git ci -m 'first commit'"

run 'heroku create'
run "git push heroku master"
run 'heroku run bundle install'
run 'heroku run rake db:migrate RAILS_ENV=production'
run 'heroku run rake db:seed RAILS_ENV=production'
run 'heroku run touch ./tmp/restart.txt'

say <<-SAY
  ============================================================================
    Your new Refinery CMS application is now installed and mounts at '/'
  ============================================================================
SAY

