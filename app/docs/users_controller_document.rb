module UsersControllerDocument
  extend Apipie::DSL::Concern

  api :PATCH, '/users/:user_id', 'update user profile'
  param :user, Hash, require: true do
    param :first_name, String, require: true
    param :last_name, String, require: true
    param :gender, %i[male female other], required: true
    param :birthday, Date, required: true, desc: 'dd/mm/yyyy'
    param :hobbies, Array, desc: 'Id to lookup the report target'
  end
  example <<-EX
  {
    "success": true
  }
  EX
  def create; end
end
