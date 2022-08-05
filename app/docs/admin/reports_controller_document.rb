module Admin
  module ReportsControllerDocument
    extend Apipie::DSL::Concern

    api :GET, '/admin/reports', 'load reports'
    param :page, Integer, require: false
    param :per_page, Integer, require: false
    param :q, Hash, require: true, desc: 'data for filter' do
      param :status_eq, ['unresolved', 'resolved'], require: false
      param :target_id_eq, Integer, require: false
      param :target_type_eq, String, require: false
    end
    example <<-EXAMPLE
    [{
        "id": 9,
        "text": "khong duoc van minh",
        "status": "unresolved",
        "problem_type": "violence",
        "attachment_paths": [
            "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--bb0121589473c9a47c36cba0d47ce71e470a721c/Screen%20Shot%202022-07-25%20at%2010.00.52.png"
        ],
        "owner_id": 35
      },
      {
        "id": 10,
        "text": "qua lao",
        "status": "unresolved",
        "problem_type": "violence",
        "attachment_paths": [
            "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--ef07f2bafb92cdb2480063beb465f67a24fa79da/Screen%20Shot%202022-07-25%20at%2010.00.52.png"
        ],
        "owner_id": 35
      }
    ]]
    EXAMPLE
    def index; end

    api :PUT, '/admin/reports/:id/resolve', 'resolve reports'
    param :user_id, Integer, desc: 'resolve reports if target is user',require: true
    example <<-EXAMPLE
    {
      "status": "success"
    }
    EXAMPLE
    def resolve; end
  end
end
