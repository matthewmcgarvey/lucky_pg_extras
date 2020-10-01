require "avram"
require "habitat"
require "lucky_cli"
require "tallboy"
require "./lucky_db_extras/**"

module LuckyDbExtras
  VERSION = "0.1.0"

  Habitat.create do
    setting database : Avram::Database.class
  end

  {% begin %}
    {% extras = ["unused_indexes", "extensions", "cache_hit", "all_locks"] %}
    {% for extra in extras %}
      def self.{{ extra.id }} : NamedTuple(column_names: Array(String), rows: Array(Array(String)))?
        LuckyDbExtras.settings.database.run do |db|
          column_names = [] of String
          rows = [] of Array(String)
          db.query sql_for({{ extra }}) do |rs|
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
    {% end %}
  {% end %}

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
    File.join(File.dirname(__FILE__), "/lucky_db_extras/queries/#{query_name}.sql")
  end
end

require "../tasks/**"
