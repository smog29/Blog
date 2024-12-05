class ApplicationService
  def self.call(**args, &block)
    new(**args, &block).call
  end

  private

  def authorized?(current_user, user_id)
    current_user&.id == user_id
  end
end
