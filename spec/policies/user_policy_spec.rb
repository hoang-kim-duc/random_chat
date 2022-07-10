require 'rspec'

describe 'UserPolicy' do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:conversation_status) { 'opening' }
  let!(:conversation) { create(:conversation, status: conversation_status) }
  let!(:user_conversation1) do
    create(:user_conversation, user: user1, conversation: conversation)
  end
  let!(:user_conversation2) do
    create(:user_conversation, user: user2, conversation: conversation)
  end
  let(:post1) { create(:post, user: user1) }
  let(:post2) { create(:post, user: user2) }

  let(:user1_can_access_user2_avatar?) do
    UserPolicy.can_access_blob?(user1, user2.avatar.attachments[0].key)
  end
  let(:can_access_own_avatar?) do
    UserPolicy.can_access_blob?(user1, user1.avatar.attachments[0].key)
  end
  let(:user1_can_access_user2_image_post?) do
    UserPolicy.can_access_blob?(user1, post2.image.attachments[0].key)
  end
  let(:can_access_own_image_post?) do
    UserPolicy.can_access_blob?(user1, post1.image.attachments[0].key)
  end
  let(:user1_can_read_posts_of_user2?) do
    UserPolicy.can_read_posts_of_owner?(user1, user2)
  end
  let(:user1_can_read_own_posts?) do
    UserPolicy.can_read_posts_of_owner?(user1, user1)
  end

  context 'is not in any shared conversation' do
    let(:conversation_status) { 'opening' }

    it 'cannot access user2 avatar' do
      expect(user1_can_access_user2_avatar?).to eql(false)
    end

    it 'can access own avatar' do
      expect(can_access_own_avatar?).to eql(true)
    end

    it 'cannot access user2 post image' do
      expect(user1_can_access_user2_image_post?).to eql(false)
    end

    it 'can access own post image' do
      expect(can_access_own_image_post?).to eql(true)
    end

    it "cannot read user2's posts" do
      expect(user1_can_read_posts_of_user2?).to eql(false)
    end

    it 'can read own posts' do
      expect(user1_can_read_own_posts?).to eql(true)
    end
  end

  context 'is in any shared conversation' do
    let(:conversation_status) { 'sharing' }

    it 'can access user2 avatar' do
      expect(user1_can_access_user2_avatar?).to eql(true)
    end

    it 'can access own avatar' do
      expect(can_access_own_avatar?).to eql(true)
    end

    it 'cannot access user2 post image' do
      expect(user1_can_access_user2_image_post?).to eql(true)
    end

    it 'can access own post image' do
      expect(can_access_own_image_post?).to eql(true)
    end

    it "cannot read user2's posts" do
      expect(user1_can_read_posts_of_user2?).to eql(true)
    end

    it 'can read own posts' do
      expect(user1_can_read_own_posts?).to eql(true)
    end
  end

  describe '.can_modify_post?' do
    context 'mine post' do
      it 'can modify' do
        result = UserPolicy.can_modify_post?(user1, post1)
        expect(result).to eql(true)
      end
    end

    context "other's post" do
      it 'cannot modify' do
        result = UserPolicy.can_modify_post?(user1, post2)
        expect(result).to eql(false)
      end
    end
  end
end
