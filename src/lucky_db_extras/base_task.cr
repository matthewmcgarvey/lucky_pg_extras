abstract class LuckyDbExtras::BaseTask < LuckyCli::Task
  macro db_extra(name)
    {% klass = name.stringify.camelcase.id %}
    summary LuckyDbExtras::{{ klass }}::SUMMARY
    def call
      result = LuckyDbExtras.{{ name }}
      table = Tallboy.table do
        header summary.colorize(:yellow), align: :center
        header LuckyDbExtras::{{ klass }}::RESULT_STRUCTURE.keys.to_a.map &.to_s
        rows result.map &.values.to_a.map &.to_s
      end
      puts table
    end
  end
end
