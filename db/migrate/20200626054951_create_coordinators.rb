class CreateCoordinators < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinators do |t|
      t.string :name
    end
  end
end