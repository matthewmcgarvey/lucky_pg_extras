class Db::Extras::Extensions < LuckyCli::Task
  summary "View enabled extensions for your database"

  def call
    pp fetch_extensions(LuckyDbExtras.settings.database)
  end

  private def fetch_extensions(database)
    database.run do |db|
      db.query_all "SELECT * FROM pg_available_extensions ORDER BY installed_version;", as: String
    end
  end
end
