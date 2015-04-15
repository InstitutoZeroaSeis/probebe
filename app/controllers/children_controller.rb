class ChildrenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: current_profile.children, root: false
  end

  def create
    child = Child.new(permitted_params.merge(profile: current_profile))
    if child.save
      head :ok
    else
      render json: { errors: child.errors }
    end
  end

  protected

  def permitted_params
    params.require(:child).permit(:name, :birth_date, :gender)
  end
end
