module ReportsControllerDocument
  extend Apipie::DSL::Concern

  api :POST, '/reports', 'create a report'
  param :report, Hash, require: true do
    param :text, String, require: true
    param :attachments, ActiveStorage::Attached::Many, require: true
    param :problem_type, %i[spam nude photo violence hate speech terrorism others], require: true
    param :target_type, String, desc: 'Class of the report target, for example for user is "User"'
    param :target_id, Integer, desc: 'Id to lookup the report target'
  end
  example <<-EX
  {
    "success": true
  }
  EX
  def create; end
end
