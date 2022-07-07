class ApplicationSerializer < ActiveModel::Serializer
  def process_time(datetime, user)
    return nil unless datetime

    datetime = datetime.in_time_zone(user.time_zone) if user&.time_zone
    datetime.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
  end
end
