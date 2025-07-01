# config/initializers/db_safety_check.rb

if (Rails.env.production? || Rails.env.development?) && $PROGRAM_NAME.include?("rake") &&
   ARGV.any? { |task| task =~ /db:(schema:load|reset|setup)/ }

  lock_path = Rails.root.join("tmp", "prevent_db_load.lock")

  if File.exist?(lock_path)
    abort("❌ DB task blocked by lock file: #{lock_path}")
  end
end 