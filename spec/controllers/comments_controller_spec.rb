# frozen_string_literal: true

require 'rails_helper'

describe CommentsController do
  include Devise::Test::ControllerHelpers
  let(:initial_post) { FactoryBot.create(:post) }

  let(:commenter) { FactoryBot.create(:user) }

  let(:app_user) { FactoryBot.create(:user) }

  post_content = 'great post m8'
  let(:comment) do
    FactoryBot.create(
      :comment,
      post: initial_post,
      user: commenter,
      content: post_content
    )
  end
  describe 'Post create' do
    let(:params) do
      {
        comment: {
          content: 'here is a reply',
          post_id: initial_post.id
        }
      }
    end

    subject(:make_request) { post :create, params: }
    context 'user signed in' do
      before { sign_in commenter }
      it 'creates a comment' do
        expect { make_request }.to(change { Comment.count }.by(1))
      end
    end
  end
end
