module Admin
  class UserSerializer < ApplicationSerializer
    attributes :id, :name, :avatar_path, :last_online, :no_of_reports, :no_of_unresolved_reports
    attribute :online?, key: :is_online
  end
end
