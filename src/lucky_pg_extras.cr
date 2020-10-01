require "avram"
require "habitat"
require "lucky_cli"
require "tallboy"

module LuckyPgExtras
  VERSION = "0.1.0"
  QUERIES = [
    "bloat", "blocking", "cache_hit",
    "calls", "extensions", "table_cache_hit", "index_cache_hit",
    "index_size", "index_usage", "locks", "all_locks",
    "long_running_queries", "mandelbrot", "outliers",
    "records_rank", "seq_scans", "table_indexes_size",
    "table_size", "total_index_size", "total_table_size",
    "unused_indexes", "vacuum_stats", "kill_all"
  ]

  Habitat.create do
    setting database : Avram::Database.class
  end

  macro finished
    {% for query in QUERIES %}
      def self.{{ query.id }}
        result = execute_query({{ query }})
        description = description_for({{ query }})
        table = result.nil? ? empty_table(description) : create_table(description, result)
        puts table
      end
    {% end %}
  end

  def self.empty_table(description)
    Tallboy.table do
      header description.colorize(:yellow), align: :center
      header ["No results"]
    end
  end

  def self.create_table(description, result)
    Tallboy.table do
      header description.colorize(:yellow), align: :center
      header result[:column_names]
      rows result[:rows]
    end
  end

  def self.execute_query(query)
    LuckyPgExtras.settings.database.run do |db|
      column_names = [] of String
      rows = [] of Array(String)
      db.query sql_for(query) do |rs|
        return if rs.column_count.zero?
        # The first row: column names
        rs.column_count.times.each { |i| column_names << rs.column_name(i).as(String) }

        # The result rows
        rs.each do
          rows << rs.column_count.times.map { rs.read.to_s }.to_a
        end
      end
      
      {
        column_names: column_names,
        rows: rows
      }
    end
  end

  def self.description_for(query_name)
    first_line = File.open(sql_path_for(query_name: query_name), &.read_line)

    first_line[/\/\*(.*?)\*\//m, 1].strip
  end

  def self.sql_for(query_name)
    File.read(
      sql_path_for(query_name)
    )
  end

  def self.sql_path_for(query_name)
    File.join(File.dirname(__FILE__), "/lucky_pg_extras/queries/#{query_name}.sql")
  end
end

require "../tasks/generate_tasks"
