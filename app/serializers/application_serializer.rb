class ApplicationSerializer < ActiveModel::Serializer
  def process_time(datetime)
    return nil unless datetime

    datetime.in_time_zone(object.recipient.time_zone).strftime('%H:%M %d/%m/%Y')
  end
end
