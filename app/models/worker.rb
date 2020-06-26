class Worker < ApplicationRecord
  has_many :coordinator_workers
  # has_many :coordinators, through: :coordinator_workers

  # second direction
  has_many :leaders, through: :coordinator_workers, class_name: "Coordinator"
end