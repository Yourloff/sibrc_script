from docx import Document
import os

def merge_documents(directory, output_file):
    merged_doc = Document()

    for filename in os.listdir(directory):
        if filename.endswith(".docx"):
            file_path = os.path.join(directory, filename)
            doc = Document(file_path)

            for element in doc.element.body:
                merged_doc.element.body.append(element)

    merged_doc.save(output_file)

# Пример использования:
merge_documents(os.path.join(os.getcwd(), 'acts'), "объединенный_документ.docx")
