module Posts
  class DeletePostService < ApplicationService
    def initialize(id:, current_user:)
      @id = id
      @current_user = current_user
    end

    def call
      post = Post.find_by(id: id)

      return { success: false, errors: [ "Post not found" ] } if post.blank?

      if !authorized?(current_user, post.journal.user_id)
        return { success: false, errors: [ "You are not authorized to delete this post" ] }
      end

      destroy_post(post)
    end

    private

    attr_reader :id, :current_user

    def destroy_post(post)
      if post.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the post" ] }
      end
    end
  end
end
