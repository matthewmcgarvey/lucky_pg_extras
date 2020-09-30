class Db::Extras::Extensions < LuckyDbExtras::BaseTask
  summary "View enabled extensions for your database"
  RESULT_STRUCTURE = {String, String?, String?, String?}
  SQL = <<-SQL
    SELECT name, default_version, installed_version, comment
    FROM pg_available_extensions
    ORDER BY installed_version
  SQL

  def header_names
    ["name", "default_version", "installed_version", "comment"]
  end

  def run_query(database)
    database.run do |db|
      db.query_all SQL, as: RESULT_STRUCTURE
    end
  end
end
