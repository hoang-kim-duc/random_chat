module Helpers::Reportable
  def self.included(klass)
    klass.scope :with_no_of_reports, -> {
      scope = Report.where(target_type: klass.name)
      reports = scope.group(:target_id).count(:id)
      unresolved_reports = scope.group(:target_id).where(status: :unresolved).count(:id)
      each do |object|
        object.no_of_reports = reports[object.id] || 0
        object.no_of_unresolved_reports = unresolved_reports[object.id] || 0
      end
      self
    }
  end

  attr_accessor :no_of_reports, :no_of_unresolved_reports
end
