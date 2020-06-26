class Coordinator < ApplicationRecord
  has_many :coordinator_workers
  has_many :workers, through: :coordinator_workers

  has_many :subordinates, through: :coordinator_workers, class_name: "Worker"
end

# has_many :workers, through: :coordinator_workers
# will change to
