require 'roo'

xlsx = Roo::Spreadsheet.open('list.xlsx')

products = []

# Читаем данные из таблицы
xlsx.each_row_streaming(offset: 1) do |row|
  product = {
    "product": {
      "denomination": row[0].value,
      "invent_num": row[1].value.to_s,
      "create_manufacture": row[2].value.strftime("%d.%m.%Y")
    }
  }

  products << product
end

# Преобразуем данные в формат JSON
json_data = JSON.generate(products)

# Записываем данные в файл data.json
File.open('data1.json', 'w') do |file|
  file.write(json_data)
end
