require_relative 'docs/act_docx'

doc = ActDocx::Document.new('data.json', 'templates/act.docx')
doc.write_data_to_document
