class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Obrigado pela mensagem. Entraremos em contato com você.'
    else
      flash.now[:error] = 'Não foi possível enviar a mensagem.'
      render :new
    end
  end
end
