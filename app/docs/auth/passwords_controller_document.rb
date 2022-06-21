# frozen_string_literal: true

module Auth
  module PasswordsControllerDocument
    extend Apipie::DSL::Concern

    api :POST, '/users/password', 'send reset password instruction to user email'
    param :user, Hash, require: true do
      param :email, String, required: true
    end
    example <<-EG
  {
    "action": "send_reset_password_instruction",
    "success": true,
    "user": {
      "id": 33,
      "first_name": "Hoang Kim",
      "last_name": "Duc",
      "birthday": "2000-06-22",
      "role": null,
      "reported_times": null,
      "created_at": "2022-05-10T17:46:09.254Z",
      "updated_at": "2022-05-10T17:48:43.798Z",
      "email": "hoangkimduclqd@gmail.com",
      "gender": null
    }
  }
    EG
    def create; end

    api 'PUT/PATCH', '/users/password', 'set new password'
    param :user, Hash, require: true do
      param :reset_password_token, String, required: true, desc: 'received in instruction email'
      param :password, String, require: true, desc: 'new password'
      param :password_confirmation, String, require: true
    end
    example <<-EG
  {
    "action": "send_reset_password_instruction",
    "success": true,
    "user": {
      "id": 33,
      "first_name": "Hoang Kim",
      "last_name": "Duc",
      "birthday": "2000-06-22",
      "role": null,
      "reported_times": null,
      "created_at": "2022-05-10T17:46:09.254Z",
      "updated_at": "2022-05-10T17:48:43.798Z",
      "email": "hoangkimduclqd@gmail.com",
      "gender": null
    }
  }
    EG
    def update; end
  end
end
