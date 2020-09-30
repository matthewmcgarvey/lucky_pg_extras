class Db::Extras::Extensions < LuckyCli::Task
  RESULT_STRUCTURE = {String, String?, String?, String?}
  SQL = <<-SQL
    SELECT name, default_version, installed_version, comment
    FROM pg_available_extensions
    ORDER BY installed_version
  SQL
  summary "View enabled extensions for your database"

  def call
    extensions =  fetch_extensions(LuckyDbExtras.settings.database)
    table = Tallboy.table do
      header "Available and installed extensions".colorize(:yellow), align: :center
      header ["name", "default_version", "installed_version", "comment"]
      rows extensions.map &.to_a
    end
    puts table
  end

  private def fetch_extensions(database)
    database.run do |db|
      db.query_all SQL, as: RESULT_STRUCTURE
    end
  end
end
