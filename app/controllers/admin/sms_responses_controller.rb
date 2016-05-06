class Admin::SmsResponsesController < Carnival::BaseAdminController
  private

  def permitted_params
    params.permit(sms_response: [:donor_id, :recipient_id, :text])
  end
end
