class SearchOperations

  def self.store_day_array_of_desired_times start_hour, end_hour
    day_array = Array.new(24, 0)
    if !end_hour.nil? & !start_hour.nil?
      if end_hour < start_hour
        day_array[start_hour..23] = [1]*((23)- start_hour)
        if end_hour != 0
          day_array[0..(end_hour - 1)] = [1]*(end_hour)
        end
      else
        day_array[start_hour..(end_hour - 1)] = [1]*(end_hour-start_hour)
      end
    end
    day_array
  end
end