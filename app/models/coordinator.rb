class Coordinator < ApplicationRecord
  has_many :coordinator_workers
  # has_many :workers, through: :coordinator_workers

  # first direction
  has_many :subordinates, through: :coordinator_workers, class_name: "Worker"
end