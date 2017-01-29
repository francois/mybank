Sequel.migration do
  up do
    run <<-EOSQL.gsub(/^ {6}/, "").chomp
      CREATE TABLE public.transactions(
          id serial not null primary key
        , child_id int not null
        , posted_at timestamp with time zone not null default now()
        , amount numeric not null
        , description text
        , foreign key(child_id) references public.children(id) on update cascade on delete restrict
      )
    EOSQL
  end

  down do
    drop_table :public__transactions
  end
end
