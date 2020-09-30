abstract class LuckyDbExtras::BaseTask < LuckyCli::Task
  abstract def header_names : Array(String)
  abstract def run_query(database : Avram::Database.class)

  def call
    result = run_query(LuckyDbExtras.settings.database)
    table = Tallboy.table do
      header "Available and installed extensions".colorize(:yellow), align: :center
      header header_names
      rows result.map &.to_a.map &.to_s
    end
    puts table
  end
end
