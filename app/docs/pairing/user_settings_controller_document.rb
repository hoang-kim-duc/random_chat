module Pairing::UserSettingsControllerDocument
    extend Apipie::DSL::Concern

    api :GET, "/user_setting", "get current user setting"
    param :user_setting, Hash, require: true do
      param :from_age, Integer, required: true
      param :to_age, Integer, required: true
      param :lat, Float, require: true
      param :long, Float, require: true
      param :address, String, require: true
      param :radius, Integer, require: true
      param :gender, [:male, :female, :other], required: true
      param :enable_age_filter, [true, false]
      param :enable_location_filter, [true, false]
      param :enable_gender_filter, [true, false]
    end
    example <<-EG
    {
      "id": 6,
      "from_age": 19,
      "to_age": 29,
      "lat": 33.46449953116152,
      "long": 84.83343748723559,
      "address": "Suite 601 93664 Feil Stravenue, Raynormouth, IA 31317",
      "radius": 4,
      "gender": "female",
      "user_id": 36,
      "enable_age_filter": false,
      "enable_location_filter": false,
      "enable_gender_filter": false,
      "created_at": "2022-06-05T11:10:20.706Z",
      "updated_at": "2022-06-05T11:10:20.706Z"
    }
    EG
    def show; end

    api :POST, '/user_setting/update_or_create', 'user log in'
    param :user_setting, Hash, require: true do
      param :from_age, Integer
      param :to_age, Integer
      param :lat, Float
      param :long, Float
      param :address, String
      param :radius, Integer
      param :gender, [:male, :female, :other]
      param :enable_age_filter, [true, false]
      param :enable_location_filter, [true, false]
      param :enable_gender_filter, [true, false]
    end
    example <<-EG
    {
      "action": "update_user_settings",
      "user_setting": {
          "from_age": 1,
          "enable_age_filter": true,
          "id": 6,
          "to_age": 29,
          "lat": 33.46449953116152,
          "long": 84.83343748723559,
          "address": "Suite 601 93664 Feil Stravenue, Raynormouth, IA 31317",
          "radius": 4,
          "gender": "female",
          "user_id": 36,
          "enable_location_filter": false,
          "enable_gender_filter": false,
          "created_at": "2022-06-05T11:10:20.706Z",
          "updated_at": "2022-06-05T11:12:50.638Z"
      }
    }
    EG
    def update_or_create; end
end
