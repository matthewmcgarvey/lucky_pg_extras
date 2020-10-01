{% for query in LuckyDbExtras::QUERIES %}
  class DbExtras::{{ query.camelcase.id }} < LuckyCli::Task
    summary LuckyDbExtras.description_for({{ query }})
    def call
      LuckyDbExtras.{{ query.id }}
    end
  end
{% end %}
