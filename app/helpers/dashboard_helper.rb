module DashboardHelper

  def dashboard_for(user)
    if user.admin?
      'admin_dashboard'
    elsif user.organization&.submitted?
      'organization_submitted_dashboard'
    elsif user.organization&.approved?
      'organization_approved_dashboard'
    else
      'create_application_dashboard'
    end
  end

end