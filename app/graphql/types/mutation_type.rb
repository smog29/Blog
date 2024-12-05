# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::Authentication::SignInMutation
    field :create_user, mutation: Mutations::Users::CreateUserMutation
    field :create_journal, mutation: Mutations::Journals::CreateJournalMutation
    field :create_post, mutation: Mutations::Posts::CreatePostMutation
    field :create_comment, mutation: Mutations::Comments::CreateCommentMutation
    field :delete_comment, mutation: Mutations::Comments::DeleteCommentMutation
    field :delete_post, mutation: Mutations::Posts::DeletePostMutation
    field :delete_journal, mutation: Mutations::Journals::DeleteJournalMutation
    field :update_user, mutation: Mutations::Users::UpdateUserMutation
  end
end
