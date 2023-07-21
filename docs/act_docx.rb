require 'sablon'
require 'json'
require 'fileutils'

module ActDocx
  class Document
    ACTS_DIRECTORY = 'acts_docx'
    OUTPUT_FILE = 'combined.docx'

    def initialize(data_file, template_file)
      @data = read_data_json(data_file)
      @template = Sablon.template(template_file)
    end

    def write_data_to_document
      FileUtils.mkdir_p(ACTS_DIRECTORY)

      products = @data['products']
      @data.delete('products')

      products.each_with_index do |hash, index|
        @data.merge!(products[index])

        output_file = "#{ACTS_DIRECTORY}/#{get_filename(index)}"
        begin
          @template.render_to_file(output_file, @data)
        rescue Sablon::ContextError => e
          puts "Ошибка при записи в документ Word: #{e.message}"
        end

        puts "Документ сохранен: #{output_file}"

        @data.delete('product')
      end

      #system("python3 docs/merged_docx.py")

      puts "Документы успешно созданы в каталоге #{ACTS_DIRECTORY}"
    end

    private

    def read_data_json(data_file)
      JSON.parse(File.read(data_file))
    end

    def get_filename(index)
      formatted_date_time = Time.now.strftime("%d%m%y%H%M%S")
      "#{formatted_date_time}_#{index + 1}.docx"
    end

    # проверка ключей
    def check_keys(key)

    end
  end
end
