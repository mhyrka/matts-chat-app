# frozen_string_literal: true

require 'rails_helper'

describe PostsController do
  include Devise::Test::ControllerHelpers
  let(:author) { FactoryBot.create(:user) }

  let!(:initial_post) do
    FactoryBot.create(:post, user: author, content: 'some words')
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
end
