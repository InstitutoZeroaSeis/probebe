class PartnersController < ApplicationController
  def show
    @partner = Partner.friendly.find params[:id]
    render layout: 'partner'
  end
end
