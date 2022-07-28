class ReportsController < ApplicationController
  include ReportsControllerDocument

  def create
    report = current_user.sent_reports.create(report_params)
    if report.persisted?
      render json: {success: true}, status: :ok
    else
      render json: {success: false, errors: [report.errors.full_messages]}
    end
  end

  private

  def report_params
    params.require(:report).permit(:problem_type, :text, :target_id,
                                   :target_type, attachments: []).merge(owner_id: current_user.id)
  end
end
