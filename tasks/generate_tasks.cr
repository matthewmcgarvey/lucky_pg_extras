{% for extra in LuckyDbExtras::EXTRAS %}
  class DbExtras::{{ extra.camelcase.id }} < LuckyCli::Task
    summary LuckyDbExtras.description_for({{ extra }})
    def call
      LuckyDbExtras.{{ extra.id }}
    end
  end
{% end %}
