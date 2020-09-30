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
    {% extras = ["unused_indexes", "extensions", "cache_hit"] %}
    {% for extra in extras %}
      def self.{{ extra.id }}
        LuckyDbExtras.settings.database.run do |db|
          {% class_extra = extra.camelcase(lower: false).id %}
          db.query_all LuckyDbExtras::{{ class_extra }}::SQL, as: LuckyDbExtras::{{ class_extra }}::RESULT_STRUCTURE
        end
      end
    {% end %}
  {% end %}
end

require "../tasks/**"
