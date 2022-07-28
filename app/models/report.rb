class Report < ApplicationRecord
  include AASM

  belongs_to :owner, class_name: 'User'
  belongs_to :target, polymorphic: true
  enum problem_type: ['spam', 'nude photo', 'violence', 'hate speech', 'terrorism', 'others']
  has_many_attached :attachments

  aasm column: :status do
    state :unresolved, initial: true
    state :resolved

    event :mark_as_resolved do
      transitions from: [:unresolved, :resolved], to: :resolved
    end

    event :mark_as_unresolved do
      transitions from: [:unresolved, :resolved], to: :unresolved
    end
  end

  def attachment_paths
    if self.attachments.attached?
      self.attachments.map do |attachment|
        Rails.application.routes.url_helpers.rails_blob_path(attachment)
      end
    else
      ''
    end
  rescue
    nil
  end
end
