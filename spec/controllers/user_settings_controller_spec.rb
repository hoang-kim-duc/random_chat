RSpec.describe UserSettingsController do
  let(:user) { create(:user) }
  let(:response_body) { JSON.parse(response.body) }

  before do
    user.confirm
    sign_in(user)
  end

  describe '#show' do
    context 'not created yet' do
      it "create and return new user_setting" do
        get :show, as: :json
        expect(response_body['id']).not_to be_nil
      end
    end

    context 'created' do
      let!(:user_setting) { create(:user_setting, user_id: user.id) }
      it "return created user_setting" do
        get :show, as: :json
        expect(response_body).to include(
          'from_age' => user_setting.from_age,
          'to_age'   => user_setting.to_age,
          'lat'      => user_setting.lat,
          'long'     => user_setting.long,
          'address'  => user_setting.address
        )
      end
    end
  end

  describe '#update_or_create' do
    let(:update_user_setting_params) do
      build(:user_setting, user_id: user.id).attributes.except('id', 'updated_at', 'created_at')
    end

    context 'not created yet' do
      it "create and return new user_setting" do
        post :update_or_create, params: { user_setting: update_user_setting_params }, as: :json
        expect(UserSetting.last.attributes).to include(update_user_setting_params)
      end
    end

    context 'created' do
    let!(:user_setting) { create(:user_setting, user_id: user.id) }
      it "return created user_setting" do
        post :update_or_create, params: { user_setting: update_user_setting_params }, as: :json
        user_setting.reload
        expect(user_setting.attributes).to include(update_user_setting_params)
      end
    end
  end
end
