module TicketsHelper
  include Pagy::Frontend

  def format_phone_number(number)
    PhonyRails.normalize_number(number, country_code: 'US')
  end
end
