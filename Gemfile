# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '2.7.2'
# ruby '3.0.3'
# ruby '3.1.0'
# ruby '3.1.2'
ruby '3.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0' # '~> 6.1' #, '>= 6.0.3.3'
# Use postgresql as the database for Active Record
gem 'pg' # , '~> 1.1'
# Use Puma as the app server
# gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# fix after mimemagic 0.3.x was yanked
# gem 'mimemagic', '~> 0.4.3'

# Reduces boot times through caching; required in config/boot.rb
# sgem 'bootsnap' #, '>= 1.4.4', require: false

group :production do
  gem 'puma', '~> 5.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'webrick'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.3'
  gem 'web-console', '>= 4.1.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

#################

# BACK END
##########
gem 'devise'

# DEV / TESTS
#############
group :development, :test do
  # if error: implicit declaration of function 'thin_http_parser_init' is invalid in C99
  # bundle config build.thin --with-cflags="-Wno-error=implicit-function-declaration"
  # gem 'thin'                 # single threading in testing is easier
  gem 'awesome_print'        # formats pry (& irb outputs into readable formats)

  gem 'pry-byebug'           # Adds byebug's step debugging and stack navigation
  gem 'pry-rails'
  # gem 'pry-debugger'       # adds step, continue, etc (alternative to pry-byebug)
  gem 'pry-stack_explorer' # easy stack traces when debugging
  # more pry gems if needed at: https://spin.atomicobject.com/2012/08/06/live-and-let-pry/

  gem 'factory_bot_rails'
  gem 'faker'

  gem 'capybara'
  gem 'rspec-rails' # , '~> 4.0.0'

  # lets spring work with rspec - uncomment if using spring
  # gem 'spring-commands-rspec'
end

group :test do
  # easier tests (inside rspec)
  gem 'shoulda-matchers'

  # cucumber can test emails (rspec too?)
  # gem 'email_spec'

  # code coverage
  gem 'simplecov'
  gem 'simplecov-console'
end
