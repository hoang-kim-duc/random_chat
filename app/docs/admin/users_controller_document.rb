module Admin
  module UsersControllerDocument
    extend Apipie::DSL::Concern

    api :GET, '/admin/users', 'get list of users'
    param :page, Integer, require: false
    param :per_page, Integer, require: false
    example <<-EXAMPLE
    [
      {
        "id": 54,
        "name": "test 19",
        "avatar_path": "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--005f872734dbe54bf351f256aca7cb74d43a1cab/Screen%20Shot%202022-06-27%20at%2015.52.56.png",
        "last_online": null,
        "no_of_reports": 7,
        "no_of_unresolved_reports": 6,
        "is_online": false
      },
      {
        "id": 53,
        "name": "test 20",
        "avatar_path": "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--005f872734dbe54bf351f256aca7cb74d43a1cab/Screen%20Shot%202022-06-27%20at%2015.52.56.png",
        "last_online": null,
        "no_of_reports": 7,
        "no_of_unresolved_reports": 6,
        "is_online": false
      }
    ]
    EXAMPLE
    def index; end
  end
end
