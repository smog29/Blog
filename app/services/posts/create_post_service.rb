module Posts
  class CreatePostService < ApplicationService
    def initialize(title:, body:, journal_id:, current_user:)
      @title = title
      @body = body
      @journal_id = journal_id
      @current_user = current_user
    end

    def call
      post = Post.new(title:, body:, journal_id:)
      journal = ::Journal.find(journal_id)

      return { post: nil, errors: [ "Not Authorized" ] } if journal&.user&.id != current_user&.id

      if post.save
        { post: post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end

    private

    attr_reader :title, :body, :journal_id, :current_user
  end
end
