class DeleteResourceCategoryService

  attr_reader :resource_category

  def initialize(resource_category)
    @resource_category = resource_category
  end

  def run!
    resource_category.tickets.update(resource_category: ResourceCategory.unspecified)
    resource_category.destroy
  end

end
