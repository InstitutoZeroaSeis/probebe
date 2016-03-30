class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = I18n.t('contacts.thanks')
    else
      flash.now[:error] = I18n.t('contacts.not_sent')
      render :new
    end
  end
end
