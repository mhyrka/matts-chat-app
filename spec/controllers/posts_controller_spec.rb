# frozen_string_literal: true

require 'rails_helper'
require './spec/controllers/shared'

describe PostsController do
  include Devise::Test::ControllerHelpers
  let(:author) { FactoryBot.create(:user) }

  let!(:initial_post) do
    FactoryBot.create(:post, user: author, content: 'post content')
  end

  let(:app_user) { FactoryBot.create(:user) }

  describe 'GET show' do
    let!(:comment1) { FactoryBot.create(:comment, post: initial_post) }

    let!(:comment2) { FactoryBot.create(:comment, post: initial_post) }

    subject(:make_request) { get :show, params: { id: initial_post.id } }

    before { sign_in app_user }

    it 'shows the comments' do
      make_request

      expect(assigns(:comments)).to(eq([comment1, comment2]))
    end
  end

  describe 'POST create' do
    let!(:post_params) do
      { post: { title: 'post title', content: 'post content' } }
    end

    subject(:make_request) { post :create, params: post_params }

    before { sign_in author }

    it 'creates post' do
      expect { make_request }.to(change { Post.count }.by(1))
    end
  end

  describe 'PUT update' do
    new_content = 'some new content'

    let(:post_params) do
      { id: initial_post.id, post: { content: new_content } }
    end

    subject(:make_request) { put :update, params: post_params }

    context 'original author' do
      before { sign_in author }

      it 'updates post' do
        expect { make_request }
          .to(
            change { initial_post.reload.content }
              .from('post content')
              .to(new_content)
          )
      end
    end

    context 'not original author' do
      before { sign_in app_user }

      it 'returns a 401' do
        make_request

        expect(response.status).to(eq(401))
      end
    end
  end

  describe 'delete post' do
    let!(:post_params) do
      { id: initial_post.id }
    end

    subject(:make_request) { delete :destroy, params: post_params }

    context 'signed in' do
      before { sign_in author }

      it 'successfully deletes post' do
        expect { make_request }
          .to(
            change { initial_post.reload.deleted }
              .from(false)
              .to(true)
          )
      end
    end

    context 'not original author' do
      before { sign_in app_user }

      it 'returns a 401' do
        make_request

        expect(response.status).to(eq(401))
      end
    end
  end
end
