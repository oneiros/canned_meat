require_dependency "canned_meat/application_controller"

module CannedMeat
  class TemplatesController < ApplicationController

    def index
      @templates = Template.order(name: :asc)
    end

    def show
      @template = Template.find(params[:id])
    end

    def new
      @template = Template.new
    end

    def create
      @template = Template.new(template_params)

      if @template.save
        redirect_to @template, notice: t('canned_meat.controllers.templates.created')
      else
        render action: 'new'
      end
    end

    def edit
      @template = Template.find(params[:id])
    end

    def update
      @template = Template.find(params[:id])

      if @template.update_attributes(template_params)
        redirect_to @template, notice: t('canned_meat.controllers.templates.updated')
      else
        render action: 'edit'
      end
    end

    def destroy
      @template = Template.find(params[:id])
      @template.destroy

      redirect_to canned_meat.templates_path, notice: t('canned_meat.controllers.templates.destroyed')
    end

    private

    def template_params
      params.require(:template).permit(:name, :html, :text)
    end
  end
end
