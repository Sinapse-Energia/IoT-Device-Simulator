class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
    @templates = Template.all
  end

  def create
    @template = Template.new(template_params)

    file = params[:template][:hardware_json].read
    data = JSON.parse(file)
    @template.hardware_json = data

    if @template.save
      redirect_to :templates
    else
      redirect_back
    end
  end

  private

  def template_params
    params.require(:template).permit(:name, :json_name, :hardware_json)
  end
end
