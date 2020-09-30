class LuckyDbExtras::Extensions
  SUMMARY = "View enabled extensions for your database"
  RESULT_STRUCTURE = {name: String, default_version: String?, installed_version: String?, comment: String?}
  SQL = <<-SQL
    SELECT name, default_version, installed_version, comment
    FROM pg_available_extensions
    ORDER BY installed_version
  SQL
end
