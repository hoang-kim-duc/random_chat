module Auth::SessionsControllerDocument
  extend Apipie::DSL::Concern

  api :POST, '/users/sign_in', 'user log in'
  param :user, Hash, require: true do
    param :email, String, required: true
    param :password, String, required: true
  end
  example <<-EG
  {
    "action": "log_in",
    "success": false,
    "errors": [
        "user have already loged in"
    ]
  }
  EG
  example <<-EG
  {
    "action": "log_in",
    "success": false,
    "errors": [
        "wrong email or password"
    ]
  }
  EG
  example <<-EG
  {
    "action": "log_in",
    "success": true,
    "user": {
        "id": 7,
        "first_name": null,
        "last_name": null,
        "birthday": null,
        "role": null,
        "reported_times": null,
        "created_at": "2022-05-07T18:04:09.422Z",
        "updated_at": "2022-05-08T15:14:35.276Z",
        "email": "abcc@gmail.com",
        "gender": null
    }
  }
  EG
  def create; end

  api :DELETE, '/users/sign_out', 'user log out'
  example <<-EG
  {
    "action": "log_out",
    "success": true,
    "errors": []
  }
  EG
  example <<-EG
  {
    "action": "log_out",
    "success": false,
    "errors": [
        "user have already logged out"
    ]
  }
  EG
  def destroy; end
end
