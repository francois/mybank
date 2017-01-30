Sequel.migration do
  up do
    self.run <<-EOSQL.gsub(/^ {6}/, "").chomp
      CREATE TABLE public.children(
          id uuid not null primary key default uuid_generate_v4()
        , name text not null unique
        , task_rate numeric not null
        , constraint name_is_longer_than_zero check(length(name) > 0)
        , constraint name_is_trimmed check(trim(name) = name)
        , constraint task_rate_greater_than_zero check(task_rate > 0)
      )
    EOSQL
  end

  down do
    drop_table :public__children
  end
end
