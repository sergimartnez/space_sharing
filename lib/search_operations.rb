class SearchOperations

  def self.get_day_array_of_desired_times start_hour, end_hour
    day_array = Array.new(24, 0)
    return day_array unless (start_hour!=nil && end_hour!=nil)
    if end_hour < start_hour
      if start_hour != 24
        day_array[start_hour..23] = [1]*((24)- start_hour)
      end
      if end_hour != 0
        day_array[0..(end_hour - 1)] = [1]*(end_hour)
      end
    else
      day_array[start_hour..(end_hour - 1)] = [1]*(end_hour-start_hour)
    end
    day_array
  end
end