class LuckyDbExtras::Extensions
  SUMMARY = "View enabled extensions for your database"
  SQL = <<-SQL
    SELECT name, default_version, installed_version, comment
    FROM pg_available_extensions
    ORDER BY installed_version
  SQL
end
