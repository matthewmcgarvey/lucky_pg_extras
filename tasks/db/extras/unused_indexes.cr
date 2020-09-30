class Db::Extras::UnusedIndexes < LuckyDbExtras::BaseTask
  summary "Unused and almost unused indexes"
  RESULT_STRUCTURE = {String, String, String, Int32}
  SQL = <<-SQL
    SELECT
      schemaname || '.' || relname AS table,
      indexrelname AS index,
      pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size,
      idx_scan as index_scans
    FROM pg_stat_user_indexes ui
    JOIN pg_index i ON ui.indexrelid = i.indexrelid
    WHERE NOT indisunique AND idx_scan < 50 AND pg_relation_size(relid) > 5 * 8192
    ORDER BY pg_relation_size(i.indexrelid) / nullif(idx_scan, 0) DESC NULLS FIRST,
    pg_relation_size(i.indexrelid) DESC;
  SQL

  def header_names
    ["table", "index", "index_size", "index_scans"]
  end

  def run_query(database)
    database.run do |db|
      db.query_all SQL, as: RESULT_STRUCTURE
    end
  end
end
