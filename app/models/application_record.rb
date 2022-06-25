# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def to_h
    serializer_class = self.class.to_s + 'Serializer'
    serializer_class.constantize.new(self).to_h
  end
end
