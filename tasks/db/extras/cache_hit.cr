class Db::Extras::CacheHit < LuckyCli::Task
  RESULT_STRUCTURE = {String, PG::Numeric}
  SQL = <<-SQL
  SELECT
    'index hit rate' AS name,
    (sum(idx_blks_hit)) / nullif(sum(idx_blks_hit + idx_blks_read),0) AS ratio
  FROM pg_statio_user_indexes
  UNION ALL
  SELECT
  'table hit rate' AS name,
    sum(heap_blks_hit) / nullif(sum(heap_blks_hit) + sum(heap_blks_read),0) AS ratio
  FROM pg_statio_user_tables;
  SQL
  summary "Index and table hit rate"

  def call
    extensions =  run_query(LuckyDbExtras.settings.database)
    table = Tallboy.table do
      header "Index and table hit rate".colorize(:yellow), align: :center
      header ["name", "ratio"]
      rows extensions.map &.to_a
    end
    puts table
  end

  private def run_query(database)
    database.run do |db|
      db.query_all SQL, as: RESULT_STRUCTURE
    end
  end
end
