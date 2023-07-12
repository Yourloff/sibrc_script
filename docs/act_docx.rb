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

      @data['products'].each_with_index do |hash, index|
        output_file = "#{ACTS_DIRECTORY}/#{get_filename(index)}"
        @template.render_to_file(output_file, hash)
        puts "Документ сохранен: #{output_file}"
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
  end
end
