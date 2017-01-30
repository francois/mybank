Sequel.migration do
  change do
    alter_table :public__children do
      add_column :task_rate, :numeric, default: 0, null: false
    end
  end
end
