Sequel.migration do
  up do
    self.run <<-EOSQL.gsub(/^ {6}/, "").chomp
      CREATE TABLE public.children(
          id serial not null primary key
        , name text not null unique
        , constraint name_is_longer_than_zero check(length(name) > 0)
        , constraint name_is_trimmed check(trim(name) = name)
      )
    EOSQL
  end

  down do
    drop_table :public__children
  end
end
