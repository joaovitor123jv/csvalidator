#!/usr/bin/ruby

require 'csv'
require './validator'

class CSValidator < Validator
  def initialize(path, validation_rules)
    @validation_rules = validation_rules
    csv_content = CSV.read(path, col_sep: ';', encoding: 'ISO8859-1:utf-8')
    map_headers csv_content
    @data = csv_content.drop(1)

    @overview = {
      errors_amount: 0,
      warnings_amount: 0
    }
  end

  def map_headers(csv_content)
    @headers = csv_content[0].map.with_index{|item, index| [item.to_sym, index]}.to_h
  end

  def csv_content_preview
    puts '-' * 80
    puts 'CSV Content preview'
    puts "Headers: #{@headers.inspect}"

    (0..2).each do |index|
      puts "Row #{index}: #{@data[index].inspect}" unless @data[index].nil?
    end
  end

  def rules_overview
    puts '-' * 80
    puts 'CSValidator rules overview'
    pp @validation_rules
  end

  def validate
    @data.each.with_index do |row_content, row_index|
      @validation_rules.each do |validated_field_name, field_validations|
        field_index = @headers[validated_field_name]

        field_validations.each do |validation_function|
          if validation_function.kind_of? Symbol
            begin
              valid, new_content = self.method(validation_function).call(row_content[field_index], nil)
            rescue
              puts "Exception caught on line #{row_index}"
              puts "\t Validation method: #{validation_function.inspect}"
              puts "\t CSV Column index: #{field_index.inspect}"
              puts "\t CSV Column name: #{validated_field_name.inspect}"
              puts "\t Current field value: #{row_content[field_index].inspect}"
            end

            if valid
              @data[row_index][field_index] = new_content
            else
              @overview[:errors_amount] += 1
              puts "Validation #{validation_function.inspect} failed on line: #{row_index + 2}"
            end
          elsif validation_function.kind_of? Hash
            method_name = validation_function.keys.first

            begin
              valid, new_content = self.method(method_name).call(
                row_content[field_index], 
                validation_function[method_name]
              )
            rescue
              puts "Exception caught on line #{row_index}"
              puts "\t Validation method: #{method_name.inspect}"
              puts "\t CSV Column index: #{field_index.inspect}"
              puts "\t CSV Column name: #{validated_field_name.inspect}"
              puts "\t Current field value: #{row_content[field_index].inspect}"
            end

            if valid
              @data[row_index][field_index] = new_content
            else
              @overview[:errors_amount] += 1
              puts "Validation #{method_name.inspect} failed on line: #{row_index + 2}"
            end
          end
        end
      end
    end
  end

  def overview(options = [])
    puts "Amount of analyzed lines: #{@data.length}"
    puts "Amount of errors found: #{@overview[:errors_amount]}"

    if options.include? :all_warnings
      puts "--------- Warnings: ----------"

      puts "------------------------------"
    end
  end
end

