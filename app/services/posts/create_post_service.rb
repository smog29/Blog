module Posts
  class CreatePostService
    def self.call(title:, body:, journal_id:, current_user:)
      post = Post.new(title:, body:, journal_id:)

      journal = ::Journal.find(journal_id)

      return { post: nil, errors: [ "Not Authorized" ] } if journal&.user&.id != current_user&.id

      if post.save
        { post: post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    end
  end
end
