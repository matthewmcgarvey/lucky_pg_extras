{% for query in LuckyPgExtras::QUERIES %}
  class PgExtras::{{ query.camelcase.id }} < LuckyTask::Task
    summary LuckyPgExtras.description_for({{ query }})
    def call
      LuckyPgExtras.{{ query.id }}
    end
  end
{% end %}
