require_relative 'docs/docx'

doc = Docx::Document.new('data.json', 'templates/act.docx')
doc.write_data_to_document
