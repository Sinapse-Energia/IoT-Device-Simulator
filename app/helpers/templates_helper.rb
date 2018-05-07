module TemplatesHelper
  def templates_dropdown
  templates = Template.pluck(:name, :id)
  select_tag 'Select Template', options_for_select(templates << ['Create New Template', '0'], templates.first), class: 'form-control csdropdown', onchange: 'selected_template($(this))'
  end
end
