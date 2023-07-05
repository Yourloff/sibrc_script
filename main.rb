require_relative 'docs/act_docx'
require_relative 'classes/organization'
require_relative 'classes/act'
require_relative 'classes/parent_organization'
require_relative 'xlsx/work_excel'
require_relative 'classes/data_reader'

# создание products
organization = Organization.new
excel = WorkExcel.new('list.xlsx', organization.short_name)
excel.write_products_json

# запись в документы
#doc = ActDocx::Document.new('data.json', 'templates/act.docx')
#doc.write_data_to_document

# сборка data
act = Act.new
consumer = organization.consumer
b = act.build
parent_org = ParentOrganization.new.signature
data = DataReader.new(organization.short_name).read

merged_data = b.merge **consumer, **data, **parent_org
# formatted_json = JSON.pretty_generate(merged_data)
excel.write_act_json(merged_data)
