# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'sqlite3'
gem 'pry'
gem 'bcrypt'
gem 'rerun'
gem 'rack-flash3',:require=>'rack-flash'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
end