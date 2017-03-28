require 'time'

class AppOperations
  def self.get_compatible_combinations_of_elements searches_list, search_array
    # (1..2).flat_map{|size|
      comb_list = []
      hashes_list = []
      searches_list.combination(2).each do |search_comb|
        compatible_matrix = valid_combination?(search_comb)
        if compatible_matrix
          comb_list.push(search_comb)

          comb_result = Hash.new
          result_matrix = sum_matrices(compatible_matrix, search_array)
          percentage=get_percentage_of_compatibility result_matrix
          comb_result[:people]=[search_comb[0].user.name, search_comb[1].user.name]
          comb_result[:search_ids]=[search_comb[0].id, search_comb[1].id]
          comb_result[:percentage]=percentage
          comb_result[:used_times]=get_times_from_matrix result_matrix
          hashes_list.push(comb_result)
        end
      end.uniq
      return [comb_list, hashes_list]
    # }
  end

  def self.valid_combination? array
    return true unless array.length > 1
    if array.length == 2
      compatible_matrix = array[0].is_compatible?(array[1].array_of_desired_times) 
      if compatible_matrix != nil && (array[0].space.nil? || array[1].space.nil?)
        return compatible_matrix
      end
    end
    nil
  end

  def self.sum_matrices matrix1, matrix2
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
