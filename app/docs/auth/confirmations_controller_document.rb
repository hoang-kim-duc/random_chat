module Auth::ConfirmationsControllerDocument
  extend Apipie::DSL::Concern

  api :POST, '/users/confirmation', 'email confirmation'
  param :confirmation_token, String, require: true, desc: 'confirmation included in the URL received in the instruction mail'
  example <<-EG
  {
    "action": "email_confirm",
    "success": true,
    "user": {
        "email": "hoangkimduclqd@gmail.com",
        "id": 30,
        "first_name": "Hoang Kim",
        "last_name": "Duc",
        "birthday": "2000-06-22",
        "role": null,
        "reported_times": null,
        "created_at": "2022-05-10T17:35:29.749Z",
        "updated_at": "2022-05-10T17:36:04.899Z",
        "gender": null
    }
  }
  EG
  def show; end
end
