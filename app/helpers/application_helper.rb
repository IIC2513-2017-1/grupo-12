module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Dreamfunder'
    if page_title.empty?
      base_title
    else
      base_title + ' | ' + page_title
    end
  end

  def active_class(*args)
    if !args[2].nil?
      current_page?(controller: args[0], action: args[1], id: args[2]) ? 'active' : ''
    else
      current_page?(controller: args[0], action: args[1]) ? 'active' : ''
    end
  end
end
