class Admin::EnginesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(engine: [:authorize_receive_sms])
  end
end
