module CurrentReport
  extend ActiveSupport::Concern

  private

  def set_report
    @report = Report.find(session[:report_id])
  rescue ActiveRecord::RecordNotFound
    @report = Report.create(store_id: current_user.store.id, seller_id: current_user.id )
    session[:report_id] = @report.id
  end
end