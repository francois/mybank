Sequel.migration do
  up do
    run "UPDATE public.children     SET family_id = (SELECT id FROM families)"
    run "ALTER TABLE public.children ALTER COLUMN family_id SET NOT NULL"

    run "UPDATE public.transactions SET family_id = (SELECT id FROM families)"
    run "ALTER TABLE public.transactions ALTER COLUMN family_id SET NOT NULL"
  end
end
