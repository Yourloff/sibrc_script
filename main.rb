require 'sablon'
require 'json'

data = JSON.parse File.read('data.json')
template = Sablon.template 'act.docx'
template.render_to_file('output.docx', data)
