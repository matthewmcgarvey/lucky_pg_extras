abstract class LuckyDbExtras::BaseTask < LuckyCli::Task
  macro db_extra(name)
    {% klass = name.stringify.camelcase.id %}
    summary LuckyDbExtras::{{ klass }}::SUMMARY
    def call
      result = LuckyDbExtras.{{ name }}
      
      puts create_table(result)
    end
  end

  private def create_table(_result : Nil)
    Tallboy.table do
      header summary.colorize(:yellow), align: :center
      header ["No results"]
    end
  end

  private def create_table(result)
    return if result.nil?

    Tallboy.table do
      header summary.colorize(:yellow), align: :center
      header result[:column_names]
      rows result[:rows]
    end
  end
end
