#!/usr/bin/ruby

require './csvalidator'

if ARGV.length == 0
  puts "Usage:   ./csv_validator.rb file_name.csv"
else
  csv_path = ARGV[0]
  puts "Ok, parsing file #{csv_path}"

  validator = CSValidator.new(csv_path, {
    "Código Órgão Superior": [
      :is_not_empty,
      :is_integer,
      :is_positive
    ],
    "Código Órgão": [
      :is_not_empty,
      :is_integer,
      :is_positive
    ],
    "Código Unidade Gestora": [
      :is_not_empty,
      :is_integer,
      :is_positive
    ],
    "Valor Recebido": [
      :is_not_empty,
      :is_comma_float # ,
      # :is_positive
    ],
    "Nome Unidade Gestora": [
      :is_not_empty
      # :is_upcase
    ],
    "Ano e mês do lançamento": [
      :is_not_empty,
      {is_date_on_format: '%m/%Y'},
      {is_on_month: 9},
      {is_on_year: "2020"}
    ],
    "Sigla UF": [
      :is_not_empty,
      {has_max_length: 2},
      {has_min_length: 2},
      {has_length: 2},
      {is_one_of: [
        'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES',
        'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR',
        'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC',
        'SP', 'SE', 'TO', 'EX', '-1'
      ]}
    ]
  })

  validator.csv_content_preview
  validator.rules_overview
  validator.validate

  validator.overview([ :all_errors ])
end

