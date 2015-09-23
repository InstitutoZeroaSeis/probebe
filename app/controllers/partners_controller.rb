class PartnersController < ApplicationController
  def show
    @partner = Partner.find params[:id]
    render layout: 'partner'
  end
end
