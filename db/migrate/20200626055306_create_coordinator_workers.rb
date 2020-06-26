class CreateCoordinatorWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinator_workers do |t|
      t.integer :coordinator_id
      t.integer :worker_id
    end
  end
end