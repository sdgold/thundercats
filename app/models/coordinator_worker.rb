class CoordinatorWorker < ApplicationRecord
  belongs_to :coordinator
  # belongs_to :worker
  belongs_to :subordinate, foreign_key: :worker_id, class_name: "Worker"
end