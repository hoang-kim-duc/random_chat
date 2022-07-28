module Admin
  class ReportsController < AdminController
    include Admin::ReportsControllerDocument

    before_action :find_report, only: [:resolve]

    def index
      @q = reports.ransack(params[:q])
      @reports = @q.result.includes(:attachments_blobs)
      render json: paging(@reports)
    end

    def resolve
      if @report.mark_as_resolved!
        render json: { status: :success }
      else
        render json: { status: :false }
      end
    end

    private

    def find_report
      @report = Report.find_by_id(params[:id])
    end

    def reports
      @reports ||= Report.where(target: params[:user_id])
    end
  end
end
