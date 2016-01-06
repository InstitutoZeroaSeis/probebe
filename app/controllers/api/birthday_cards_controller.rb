module Api
  class BirthdayCardsController < ApplicationController
    include HeaderAuthenticationConcern

    def show
      card = BirthdayCard.where(type: params[:type], age: params[:age]).first
      render json: card, root: false
    end
  end
end
