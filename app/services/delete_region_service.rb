class DeleteRegionService

  attr_reader :region

  def initialize(region)
    @region = region
  end

  def run!
    region.tickets.update(region: Region.unspecified)
    region.destroy
  end

end
