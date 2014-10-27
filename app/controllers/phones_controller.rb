class PhonesController < ApplicationController

  private
  
  def permitted_params
    params.permit(phone: [:number, :type])
  end

end