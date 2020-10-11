class Validator
  def is_integer(field_content, validation_params)
    begin
      return [true, Integer(field_content, 10)]
    rescue => exception
      puts 'On validation is_integer: cant convert to integer'
      return [false, nil]
    end
  end

  def is_float(field_content, validation_params)
    begin
      return [true, Float(field_content)]
    rescue => exception
      puts 'On validation is_float: cant convert to integer'
      return [false, nil]
    end
  end

  def is_comma_float(field_content, validation_params)
    begin
      return [true, Float(field_content.gsub(',', '.'))]
    rescue => exception
      puts 'On validation is_comma_float: cant convert to integer'
      return [false, nil]
    end
  end

  def is_comma_float_with_thousands_separator(field_content, validation_params)
    begin
      return [true, Float(field_content.gsub('.', ''),gsub(',', '.'))]
    rescue => exception
      puts 'On validation is_comma_float_with_thousands_separator: cant convert to integer'
      return [false, nil]
    end
  end

  def is_positive(field_content, validation_params)
    begin
      return [true, field_content] if field_content >= 0
      return [false, field_content]
    rescue => exception
      puts 'On validation is_positive: Is not a number'
      return [false, nil]
    end
  end

  def is_upcase(field_content, validation_params)
    begin
      return [true, field_content] if field_content.upcase == field_content
      return [false, nil]
    rescue => exception
      puts "On validation is_upcase: Unhandled exception: |#{exception}|"
      return [false, nil]
    end
  end

  def is_not_empty(field_content, validation_params)
    return [false, nil] if field_content.nil?
    return [false, nil] if field_content == ""
    return [true, field_content]
  end

  def is_not_zero(field_content, validation_params)
    return [false, nil] if field_content.nil?
    return [false, nil] if field_content == "0"
    return [false, nil] if field_content == 0
    return [true, field_content]
  end

  def is_date_on_format(field_content, validation_params)
    Date.strptime(field_content, validation_params)
  end

  def is_on_month(field_content, validation_params)
    return [false, nil] unless ["Date", "Time"].include? field_content
    return [false, nil] unless field_content.month == Integer(validation_params, 10)
    return [true, field_content]
  end
end
