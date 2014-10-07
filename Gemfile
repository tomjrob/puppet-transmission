source "http://rubygems.org"

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.0']
end

gem 'bundler'
gem 'rake'
gem 'rspec-puppet', :git => "https://github.com/rodjek/rspec-puppet.git"
gem 'puppetlabs_spec_helper', :git => "https://github.com/puppetlabs/puppetlabs_spec_helper.git"
gem 'puppet', puppetversion
