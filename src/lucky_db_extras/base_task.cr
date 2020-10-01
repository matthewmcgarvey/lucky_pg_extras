abstract class LuckyDbExtras::BaseTask < LuckyCli::Task
  macro db_extra(name)
    summary "Runs the pg_extras query called '#{name}'"
    def call
      LuckyDbExtras.{{ name }}
    end
  end
end
