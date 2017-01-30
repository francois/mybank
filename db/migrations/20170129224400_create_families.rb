Sequel.migration do
  up do
    run <<-EOSQL.gsub(/^ {6}/, "").chomp
      CREATE TABLE public.families(
          id uuid primary key default uuid_generate_v4()
        , name text not null unique
        , constraint name_is_trimmed check(trim(name) = name)
        , constraint name_is_longer_than_0_chars check(length(name) > 0)
      )
    EOSQL

    run "ALTER TABLE public.children ADD COLUMN family_id uuid, ADD FOREIGN KEY(family_id) REFERENCES public.families"
    run "ALTER TABLE public.transactions ADD COLUMN family_id uuid, ADD FOREIGN KEY(family_id) REFERENCES public.families"
  end
end
