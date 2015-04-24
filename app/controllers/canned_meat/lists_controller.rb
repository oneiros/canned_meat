require_dependency "canned_meat/application_controller"

module CannedMeat
  class ListsController < ApplicationController

    def index
      @lists = List.order(name: :asc)
    end

    def show
      @list = List.find(params[:id])
    end

    def new
      @list = List.new
    end

    def create
      @list = List.new(list_params)

      if @list.save
        redirect_to @list, notice: t('canned_meat.controllers.lists.created')
      else
        render action: 'new'
      end
    end

    def edit
      @list = List.find(params[:id])
    end

    def update
      @list = List.find(params[:id])

      if @list.update_attributes(list_params)
        redirect_to @list, notice: t('canned_meat.controllers.lists.updated')
      else
        render action: 'edit'
      end
    end

    def destroy
      @list = List.find(params[:id])
      @list.destroy

      redirect_to canned_meat.lists_path, notice: t('canned_meat.controllers.lists.destroyed')
    end

    private

    def list_params
      params.require(:list).permit(:name)
    end
  end
end
