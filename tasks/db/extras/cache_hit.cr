class Db::Extras::CacheHit < LuckyDbExtras::BaseTask
  summary "Index and table hit rate"
  RESULT_STRUCTURE =  {String, PG::Numeric}
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

  def header_names
    ["name", "ratio"]
  end

  def run_query(database)
    database.run do |db|
      db.query_all SQL, as: RESULT_STRUCTURE
    end
  end
end
