class BaseService
  attr_accessor :errors, :current_user, :result

  def initialize(current_user)
    @result ||= {}
    @current_user = current_user
  end

  def success?
    !fail?
  end

  def fail?
    errors.any?
  end
end
