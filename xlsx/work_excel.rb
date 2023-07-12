require 'roo'
require 'json'

class WorkExcel
  attr_reader :file, :name_org

  def initialize(file, name_org)
    @file = Roo::Spreadsheet.open(file)
    @name_org = name_org
  end

  def write_products_json
    products = []
    products_data = {}

    @file.each_row_streaming(offset: 1) do |row|
      product = {
        "product": {
          "denomination": row[0].value.gsub(/\s+/, " "),
          "invent_num": row[1].value.to_s,
          "create_manufacture": row[2].value.strftime("%d.%m.%Y")
        }
      }

      products << product
    end

    products_data[:products] = products
    json_data = JSON.generate(products_data)

    File.open("acts_data/products_#{@name_org}.json", 'w') do |file|
      file.write(json_data)
    end
  end

  def write_act_json(data_hash)
    json_data = JSON.generate(data_hash)
    File.open("acts_data/acts_#{@name_org}.json", 'w') { |file| file.write(json_data) }
  end
end
