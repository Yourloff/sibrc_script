from docx import Document
import os

def merge_documents(directory, output_file):
    merged_doc = Document()

    for i, filename in enumerate(os.listdir(directory)):
        if filename.endswith(".docx"):
            file_path = os.path.join(directory, filename)
            try:
                doc = Document(file_path)

                if i != 0:
                    merged_doc.add_page_break()

                for element in doc.element.body:
                    merged_doc.element.body.append(element)
            except Exception as e:
                print(f"Ошибка при обработке документа {filename}: {str(e)}")

    merged_doc.save(output_file)

merge_documents(os.path.join(os.getcwd(), 'acts'), "объединенный_документ.docx")
