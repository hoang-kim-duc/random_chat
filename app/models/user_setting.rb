class UserSetting < ApplicationRecord
  belongs_to :user

  enum gender: [:male, :female, :other]

end
