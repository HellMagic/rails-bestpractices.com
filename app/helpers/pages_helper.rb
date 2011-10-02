module PagesHelper
  def render_sidebar_content
    controller = params[:controller]
    action = params[:action]
    name = "#{controller}-#{action}-sidebar"
    page1 = Page.find_cached_by_name(name)
    if action == 'new' or action == 'edit'
      name = "#{controller}-form-sidebar"
    else
      name = "#{controller}-sidebar"
    end
    page2 = Page.find_cached_by_name(name)
    raw "#{page1.body if page1}#{page2.body if page2}"
  end
end
