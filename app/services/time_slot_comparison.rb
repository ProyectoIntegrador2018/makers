class TimeSlotComparison
  def self.overlap?(chosen_time_slot, availability)
    start_time_is_contained?(chosen_time_slot, availability) &&
      end_time_is_contained?(chosen_time_slot, availability)
  end

  def self.start_time_is_contained?(chosen_time_slot, availability)
    availability.formatted_start_time <= chosen_time_slot[:start]
  end

  def self.end_time_is_contained?(chosen_time_slot, availability)
    availability.formatted_end_time >= chosen_time_slot[:end]
  end
end
