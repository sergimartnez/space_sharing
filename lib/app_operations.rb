require 'time'

class AppOperations
  def self.sum_two_matrices matrix1, matrix2
    return matrix2 unless matrix1 != nil 
    mixed_matrix = matrix1.map.with_index do |array,i| 
      array.map.with_index do |item, j|
        item.to_i + (matrix2[i][j]).to_i
      end
    end
  end

  def self.reverse_matrix_values matrix
    matrix.map! do |array|
      array.map! {|x| x==1 ? 2 : x }
      array.map! {|x| x==0 ? 1 : x }
      array.map! {|x| x==2 ? 0 : x }
    end
    matrix
  end

  def self.check_matrix_compatibility matrix
    matrix.detect {|array| array.include? 2}
  end
  
  def self.get_percentage_of_compatibility matrix
    sum = 0
    matrix.each do |array|
      array.each do |hour|
        sum=sum+(hour.to_i)
      end
    end
    (sum/(7.0*24))*100
  end

  def self.obtain_array_of_desired_times
    start_arr = start.split(':')
    finish_arr = finish.split(':')
    day_array = Array.new(24, 0)
    if finish_arr[0].to_i < start_arr[0].to_i
      day_array[(start_arr[0].to_i)..23] = [1]*((23)-(start_arr[0].to_i))
      if finish_arr[0].to_i != 0
        day_array[0..(finish_arr[0].to_i - 1)] = [1]*(finish_arr[0].to_i)
      end
    else
      day_array[(start_arr[0].to_i)..(finish_arr[0].to_i - 1)] = [1]*((finish_arr[0].to_i)-(start_arr[0].to_i))
    end
    desired_matrix = Array.new(7){day_array}
  end

  def self.parse_ids_to_names array_ids
    users_array = array_ids.map do |search_id|
      Search.find_by(id: search_id).user.get_full_name
    end
  end

  def self.get_times_from_matrix matrix
    matrix.map do |day_array|
      get_times_from_daily_array day_array
    end
  end
  def self.get_times_from_daily_array day_array
    day_array.each.with_index.inject("") do |mem, (val, ind)|
      if ind != 0
        if day_array[ind-1]==0 && val==1
          if mem==""
            mem=mem + "From " + ind.to_s + ":00"
          else
            mem=mem + " and from " + ind.to_s + ":00"
            check=true
          end
        elsif day_array[ind-1]==1 && val==0
          mem=mem + " to " + ind.to_s + ":00"
        elsif ind==23 && val==1
          mem=mem + " to 24:00"
        end
      else
        if val==1
          mem=mem + "From " + ind.to_s + ":00"
        end
      end
      mem
    end
  end
end
