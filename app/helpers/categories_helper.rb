# frozen_string_literal: true

# methods to generate tags for category selector form
module CategoriesHelper
  def gen_input(number, category, categories)
    checked = if categories.include? category
                'checked'
              else
                ''
              end
    text = "<input #{checked} for=\"project_category_ids_#{number}\" value=\"#{number}\""
    text += 'name="project[category_ids][]" type="checkbox">'
    text
  end

  def gen_label(number, name)
    "<label for=\"project_category_ids_#{number}\">#{name}</label>"
  end
end
