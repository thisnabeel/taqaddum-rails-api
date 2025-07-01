#!/usr/bin/env ruby

# Test script to verify database safety check
require_relative 'config/environment'

# Simulate production environment and rake task
ENV['RAILS_ENV'] = 'production'
$PROGRAM_NAME = 'rake'
ARGV = ['db:schema:load']

puts "Testing database safety check..."
puts "RAILS_ENV: #{ENV['RAILS_ENV']}"
puts "PROGRAM_NAME: #{$PROGRAM_NAME}"
puts "ARGV: #{ARGV}"
puts "Lock file exists: #{File.exist?(Rails.root.join('tmp', 'prevent_db_load.lock'))}"

# Check if conditions are met
if ENV['RAILS_ENV'] == 'production' && $PROGRAM_NAME.include?("rake") &&
   ARGV.any? { |task| task =~ /db:(schema:load|reset|setup)/ }
  
  puts "✅ Conditions met for safety check"
  
  lock_path = Rails.root.join("tmp", "prevent_db_load.lock")
  
  if File.exist?(lock_path)
    puts "❌ This would abort with: DB task blocked by lock file: #{lock_path}"
  else
    puts "✅ No lock file found, would proceed"
  end
else
  puts "❌ Conditions not met for safety check"
end 