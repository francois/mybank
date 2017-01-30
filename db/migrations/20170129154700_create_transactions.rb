Sequel.migration do
  up do
    run <<-EOSQL.gsub(/^ {6}/, "").chomp
      CREATE TABLE public.transactions(
          id uuid not null primary key default uuid_generate_v4()
        , child_id uuid not null
        , posted_on date not null
        , amount numeric not null
        , description text
        , created_at timestamp with time zone not null default now()
        , foreign key(child_id) references public.children(id) on update cascade on delete restrict
      )
    EOSQL
  end

  down do
    drop_table :public__transactions
  end
end
