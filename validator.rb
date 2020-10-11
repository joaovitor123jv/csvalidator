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
    begin
      return [true, Date.strptime(field_content, validation_params)]
    rescue
      return [false, nil]
    end
  end

  def is_on_month(field_content, validation_params)
    return [false, nil] unless ['Date', 'Time'].include? field_content.class.to_s
    if validation_params.class.to_s == 'String'
      return [false, nil] unless field_content.month == Integer(validation_params, 10)
    else
      return [false, nil] unless field_content.month == validation_params
    end
    return [true, field_content]
  end

  def is_on_year(field_content, validation_params)
    return [false, nil] unless ['Date', 'Time'].include? field_content.class.to_s
    if validation_params.class.to_s == 'String'
      return [false, nil] unless field_content.year == Integer(validation_params, 10)
    else
      return [false, nil] unless field_content.year == validation_params
    end
    return [true, field_content]
  end

  def is_one_of(field_content, validation_params)
    return [false, nil] unless validation_params.include? field_content
    return [true, field_content]
  end

  def has_max_length(field_content, validation_params)
    return [false, nil] unless field_content.length <= validation_params
    return [true, field_content]
  end

  def has_min_length(field_content, validation_params)
    return [false, nil] unless field_content.length >= validation_params
    return [true, field_content]
  end

  def has_length(field_content, validation_params)
    return [false, nil] unless field_content.length == validation_params
    return [true, field_content]
  end
end
