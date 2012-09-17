require 'rbconfig'
VERSION_BAND = '2.0.0'

gsub_file 'Gemfile', "gem 'jquery-rails'", "gem 'jquery-rails', '~> 2.0.0'"

append_file 'Gemfile', <<-GEMFILE
gem 'refinerycms', :git => 'git://github.com/refinery/refinerycms.git', :branch => '2-0-stable'
gem 'refinerycms-i18n', :git => 'git://github.com/refinery/refinerycms-i18n.git', :branch => '2-0-stable'
# gem 'refinerycms-i18n', '~> 2.0.0'
# gem 'refinerycms-blog', '~> #{VERSION_BAND}'
# gem 'refinerycms-inquiries', '~> #{VERSION_BAND}'
# gem 'refinerycms-search', '~> #{VERSION_BAND}'
# gem 'refinerycms-page-images', '~> #{VERSION_BAND}'

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

gsub_file 'config/initializers/refinery/i18n.rb', "# config.enabled = true", "config.enabled = true"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.default_locale = :en", "config.default_locale = 'zh-CN'"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.current_locale = :en", "config.current_locale = 'zh-CN'"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.default_frontend_locale = :en", "config.default_frontend_locale = 'zh-CN'"
gsub_file 'config/initializers/refinery/i18n.rb', "# config.frontend_locales = [:en]", "config.frontend_locales = [:en, 'zh-CN']"
# gsub_file 'config/initializers/refinery/i18n.rb', '# config.locales = {:en=>"English", :fr=>"Français", :nl=>"Nederlands", :"pt-BR"=>"Português", :da=>"Dansk", :nb=>"Norsk Bokmål", :sl=>"Slovenian", :es=>"Español", :it=>"Italiano", :de=>"Deutsch", :lv=>"Latviski", :ru=>"Русский", :sv=>"Svenska", :pl=>"Polski", :"zh-CN"=>"Simplified Chinese", :"zh-TW"=>"Traditional Chinese", :el=>"Ελληνικά", :rs=>"Srpski", :cs=>"Česky", :sk=>"Slovenský", :ja=>"日本語", :bg=>"Български"}', "config.locales = {:en=>'English', :'zh-CN'=>'Simplified Chinese'}"

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

