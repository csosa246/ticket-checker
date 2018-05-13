class TimeOfDayType < ActiveRecord::Type::Time
  def serialize(value)
    value.to_s if value.present?
  end

  def cast(value)
    Tod::TimeOfDay.parse(value) if value.present?
  end
end

ActiveRecord::Type.register(:time_of_day, TimeOfDayType)

