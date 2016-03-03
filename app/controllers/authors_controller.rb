class AuthorsController < ApplicationController

  def show
    @author = Authors::Author.find(params[:id])
  end
end
