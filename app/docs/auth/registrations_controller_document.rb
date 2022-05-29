module Auth::RegistrationsControllerDocument
  extend Apipie::DSL::Concern

  api :POST, '/users', 'user registration'
  param :user, Hash, require: true do
    param :email, String, required: true
    param :password, String, required: true
    param :password_confirmation, String, required: true
    param :first_name, String, required: true
    param :last_name, String, required: true
    param :birthday, Date, required: true, desc: 'dd/mm/yyyy'
    param :gender, [:male, :female, :other], required: true
  end
  example <<-EG
  {
    "action": "sign_up",
    "success": true,
    "user": {
        "id": 29,
        "first_name": "Hoang Kim",
        "last_name": "Duc",
        "birthday": "2000-06-22",
        "role": null,
        "reported_times": null,
        "created_at": "2022-05-09T17:55:01.085Z",
        "updated_at": "2022-05-09T17:55:01.085Z",
        "email": "hoangkimduclqd@gmail.com",
        "gender": null
    }
  }
  EG
  example <<-EG
  {
    "action": "sign_up",
    "success": false,
    "errors": [
        "Email has already been taken"
    ]
  }
  EG
  def create; end
end
