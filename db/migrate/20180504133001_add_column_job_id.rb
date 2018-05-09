class AddColumnJobId < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :job_id, :string
  end
end
