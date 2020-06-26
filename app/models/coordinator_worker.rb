class CoordinatorWorker < ApplicationRecord
  belongs_to :coordinator
  # belongs_to :worker

  # first direction
  belongs_to :subordinate, foreign_key: :worker_id, class_name: "Worker", optional: true

  # second direction
  belongs_to :leader, foreign_key: :coordinator_id, class_name: "Coordinator", optional: true
end