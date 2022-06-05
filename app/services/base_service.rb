class BaseService
  attr_accessor :errors, :current_user, :result

  def success?
    !fail?
  end

  def fail?
    errors.any?
  end
end
