# frozen_string_literal: true

class UserSetting < ApplicationRecord
  belongs_to :user

  enum gender: %i[male female other]

  def accepted_age?(age)
    from_age <= age && age <= to_age
  end
end
