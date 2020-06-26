class Worker < ApplicationRecord
  has_many :coordinator_workers
  has_many :coordinators, through: :coordinator_workers
end