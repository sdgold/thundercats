class CoordinatorWorker < ApplicationRecord
  belongs_to :coordinator
  belongs_to :worker

  # belongs_to :subordinate, foreign_key: :worker_id, class_name: "Coordinator"
end



# firm 
#   has_many clients

#   client
#     belongs_to :firm


