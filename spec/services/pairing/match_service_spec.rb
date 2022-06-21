describe Pairing::MatchService do
  let(:user1) { create(:user, gender: 'male', birthday: Time.now.utc.to_date - 20.years) }
  let(:user2) { create(:user, gender: 'female', birthday: Time.now.utc.to_date - 20.years) }
  let(:result) { described_class.new(user1, user2).call }
  let!(:user_setting) do
    create(
      :user_setting,
      user_id: user1.id,
      from_age: 1,
      to_age: 30,
      lat: 16.0495615,
      long: 108.2387775,
      radius: 5,
      gender: 'female'
    )
  end
  let!(:user_setting2) do
    create(
      :user_setting,
      user_id: user2.id,
      from_age: 1,
      to_age: 30,
      lat: 16.051228,
      long: 108.213132,
      radius: 5,
      gender: 'male'
    )
  end

  context 'when 2 users matched' do


    it 'return true result' do
      expect(result).to eql({is_matching: true, reasons: []})
    end
  end

  context 'when 2 users too far' do
    let!(:user_setting) do
      create(
        :user_setting,
        user_id: user1.id,
        from_age: 1,
        to_age: 30,
        lat: 16.0495615,
        long: 108.2387775,
        radius: 1,
        gender: 'female'
      )
    end

    it 'return true result' do
      expect(result).to eql({is_matching: false, reasons: ["users2's location was not accepted by user1"]})
    end
  end

  context 'when user2 age is not accepted by user1' do
    let!(:user_setting) do
      create(
        :user_setting,
        user_id: user1.id,
        from_age: 1,
        to_age: 18,
        lat: 16.0495615,
        long: 108.2387775,
        radius: 5,
        gender: 'female'
      )
    end

    it 'return true result' do
      expect(result).to eql({is_matching: false, reasons: ["users2's age was not accepted by user1"]})
    end
  end

  context 'when user2 gender is not accepted by user1' do
    let!(:user_setting) do
      create(
        :user_setting,
        user_id: user1.id,
        from_age: 1,
        to_age: 30,
        lat: 16.0495615,
        long: 108.2387775,
        radius: 5,
        gender: 'male'
      )
    end

    it 'return true result' do
      expect(result).to eql({is_matching: false, reasons: ["users2 gender was not accepted by user1"]})
    end
  end
end
