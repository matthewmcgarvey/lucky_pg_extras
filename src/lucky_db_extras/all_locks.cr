class LuckyDbExtras::AllLocks
  SUMMARY = "Queries with active locks"
  RESULT_STRUCTURE = {pid: Int32, relname: String, transactionid: String, granted: Bool, mode: String, query_snippet: String, age: Time}
  SQL = <<-SQL
    SELECT
      pg_stat_activity.pid,
      pg_class.relname,
      pg_locks.transactionid,
      pg_locks.granted,
      pg_locks.mode,
      pg_stat_activity.query AS query_snippet,
      age(now(),pg_stat_activity.query_start) AS "age"
    FROM pg_stat_activity,pg_locks left
    OUTER JOIN pg_class
      ON (pg_locks.relation = pg_class.oid)
    WHERE pg_stat_activity.query <> '<insufficient privilege>'
      AND pg_locks.pid = pg_stat_activity.pid
      AND pg_stat_activity.pid <> pg_backend_pid() order by query_start;
  SQL
end
  