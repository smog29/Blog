# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_in_mutation, mutation: Mutations::SignInMutation
    field :create_user, mutation: Mutations::CreateUserMutation
    field :create_journal, mutation: Mutations::CreateJournalMutation
    field :create_post, mutation: Mutations::CreatePostMutation
    field :create_comment, mutation: Mutations::CreateCommentMutation
    field :delete_comment, mutation: Mutations::DeleteCommentMutation
    field :delete_post, mutation: Mutations::DeletePostMutation
    field :delete_journal, mutation: Mutations::DeleteJournalMutation
  end
end
