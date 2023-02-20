class UserMailer < ApplicationMailer
  default from: 'Central Oregon COAD <co.coad.dev@gmail.com>'

  def new_organization_application
    @to = params[:to]
    @new_organization = params[:new_organization]
    if Rails.env.production? || Rails.env.test?
      mail(to: @to, subject: 'New Organization Application Pending')
    else
      false
    end
  end

end
