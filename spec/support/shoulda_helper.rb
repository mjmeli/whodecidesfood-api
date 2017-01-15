require 'shoulda/matchers'
require "bundler/setup"
::Bundler.require(:default, :test)
require "shoulda/matchers"
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
