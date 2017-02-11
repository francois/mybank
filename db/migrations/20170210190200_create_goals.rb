Sequel.migration do
  up do
    run <<-EOSQL.gsub(/^ {6}/, "").chomp
      CREATE TABLE public.goals(
          id uuid primary key default uuid_generate_v4()
        , child_id uuid not null references children(id)
        , name text not null check(length(name) > 1 and trim(name) = name)
        , amount numeric not null
      )
    EOSQL
  end

  down do
    drop_table :public__goals
  end
end
