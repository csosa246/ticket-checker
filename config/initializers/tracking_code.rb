class TrackingCodeType < ActiveRecord::Type::Value
  def cast(value)
    TrackingCode.new(value) if value.present?
  end

  def serialize(code)
    code&.canonical
  end
end

ActiveRecord::Type.register(:tracking_code, TrackingCodeType)

