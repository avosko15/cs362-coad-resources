class DashboardController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    @status_options = status_options
    @pagy, @tickets = tickets
  end

  private

  def status_options
    if current_user.admin?
      ['Open', 'Captured', 'Closed']
    elsif current_user.organization&.approved?
      ['Open', 'My Captured', 'My Closed']
    else
      ['Open']
    end
  end

  def tickets
    case params[:status]
    when 'Open'
      pagy, tickets = pagy(Ticket.open, items: 10)
    when 'Closed'
      pagy, tickets = pagy(Ticket.closed, items: 10)
    when 'Captured'
      pagy, tickets = pagy(Ticket.all_organization, items: 10)
    when 'My Captured'
      pagy, tickets = pagy(Ticket.organization(current_user.organization&.id), items: 10)
    when 'My Closed'
      pagy, tickets = pagy(Ticket.closed_organization(current_user.organization&.id), items: 10)
    else
      pagy, tickets = pagy(Ticket.all, items: 10)
    end

    tickets = tickets.region(params[:region_id]) if params[:region_id].present?
    tickets = tickets.resource_category(params[:resource_category_id]) if params[:resource_category_id].present?
    tickets = tickets.reverse if params[:sort_order] == 'Newest First'

    [pagy, tickets]
  end

end
