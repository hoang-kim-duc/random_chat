module Helpers::Attachable
  def add_one_attached(key)
    has_one_attached key

    define_method "#{key}_path" do |width = nil, height = nil|
      if self.send(key).attached?
        if width && height
          Rails.application.routes.url_helpers.rails_blob_path(self.send(key)
            .variant(resize_to_limit: [width, height]).processed)
        else
          Rails.application.routes.url_helpers.rails_blob_path(self.send(key))
        end
      else
        ''
      end
    rescue
      nil
    end
  end

  def add_many_attached(key)
    has_many_attached key

    key_singular = key.to_s.singularize.to_sym
    define_method "#{key_singular}_paths" do
      if self.send(key).attached?
        self.send(key).map do |attachment|
          Rails.application.routes.url_helpers.rails_blob_path(attachment)
        end
      else
        ''
      end
    rescue
      nil
    end
  end
end
