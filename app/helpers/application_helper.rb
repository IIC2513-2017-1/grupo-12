module ApplicationHelper

  # Checks if current page is the same as the one contained in the args params
  def active_class(*args)
    if !args[2].nil?
      current_page?(controller: args[0], action: args[1], id: args[2]) ? 'active' : ''
    else
      current_page?(controller: args[0], action: args[1]) ? 'active' : ''
    end
  end

end
