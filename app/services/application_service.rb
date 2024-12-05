class ApplicationService
  def self.call(**args, &block)
    new(**args, &block).call
  end

  private

  def self.authorized?(current_user, user_id)
    current_user&.id == user_id
  end

  def authorized?(current_user, user_id)
    current_user&.id == user_id
  end
end
