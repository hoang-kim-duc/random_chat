class ReportSerializer < ApplicationSerializer
  attributes :id, :text, :status, :problem_type, :attachment_paths, :owner_id
end
