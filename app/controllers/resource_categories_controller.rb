class ResourceCategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_resource_category, except: [:index, :new, :create]

  def index
    @resource_categories = ResourceCategory.all.order(:name)
  end

  def show; end

  def new
    @resource_category = ResourceCategory.new
  end

  def create
    @resource_category = ResourceCategory.new(resource_category_params)
    if @resource_category.save
      redirect_to resource_categories_path, notice: 'Category successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @resource_category.update(resource_category_params)
      redirect_to @resource_category, notice: 'Category successfully updated.'
    else
      render :edit
    end
  end

  def activate
    if @resource_category.activate
      redirect_to @resource_category, notice: 'Category activated.'
    else
      redirect_to @resource_category, alert: 'There was a problem activating the category.'
    end
  end

  def deactivate
    if @resource_category.deactivate
      redirect_to @resource_category, notice: 'Category deactivated.'
    else
      redirect_to @resource_category, alert: 'There was a problem deactivating the category.'
    end
  end

  def destroy
    delete_resource_category_service = DeleteResourceCategoryService.new(@resource_category)
    delete_resource_category_service.run!
    redirect_to resource_categories_path, notice: "Category #{@resource_category.name} was deleted.\nAssociated tickets now belong to the 'Unspecified' category."
  end

  private

  def set_resource_category
    @resource_category = ResourceCategory.find(params[:id])
  end

  def resource_category_params
    params.require(:resource_category).permit(:name)
  end

end
