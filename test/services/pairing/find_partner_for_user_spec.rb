require "./test/test_helper"

module Pairing
  RSpec.describe FindPartnerForUser do
    describe "#call" do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:service1) { Pairing::FindPartnerForUser.new(user1.id) }
      let(:service2) { Pairing::FindPartnerForUser.new(user2.id) }

      after do
        SystemVar.users_queue.clear!
      end

      context "two match user join" do
        it "shoudnt pair when first one joined" do
          expect(service1).not_to receive(:notify_pairing_success)
          service1.call
        end

        it "should pair when second one joined" do
          service1.call
          expect(service2).to receive(:notify_pairing_success)
          service2.call
        end
      end

      context "join twice" do
        it "should be enqueue just once" do
          service1.call
          service1.call
          expect(SystemVar.users_queue.size).to eql(1)
        end
      end
    end
  end
end
