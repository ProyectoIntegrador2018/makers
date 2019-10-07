class TimeUtils
  def self.extract_time(date_time)
    date_time.strftime('%H:%M')
  end
end
