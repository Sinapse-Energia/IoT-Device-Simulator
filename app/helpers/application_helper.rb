module ApplicationHelper
  def current_class?(path)
    request.path == path
  end
end
