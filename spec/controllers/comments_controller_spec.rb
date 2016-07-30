require 'rails_helper'

describe CommentsController do

  let(:post) { create(:post) }
  let(:valid_attributes) { attributes_for(:comment, commentable_id: post.id, commentable_type: 'Post') }

  let(:invalid_attributes) { attributes_for(:comment, commentable_id: '') }

  describe '#index' do
    it 'assigns all comments as @comments' do
      comment = Comment.create! valid_attributes
      get :index, xhr: true
      expect(assigns(:comments)).to eq([comment])
      expect(response.code).to eq('200')
    end
  end

  describe '#show' do
    it 'assigns the requested comment as @comment' do
      comment = Comment.create! valid_attributes
      get :show, params: {id: comment.to_param}, xhr: true
      expect(assigns(:comment)).to eq(comment)
      expect(response.code).to eq('200')
    end
  end

  describe '#new' do
    it 'assigns a new comment as @comment' do
      get :new, xhr: true
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe '#edit' do
    it 'assigns the requested comment as @comment' do
      comment = Comment.create! valid_attributes
      get :edit, params: {id: comment.to_param}, xhr: true
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe '#update' do
    context 'with valid params' do
      let(:comment) { create(:comment) }
      let(:new_attributes) { attributes_for(:comment, body: 'Hello') }

      it 'assigns the requested comment as @comment' do
        comment = Comment.create! valid_attributes
        put :update, params: {id: comment.to_param, comment: valid_attributes}, xhr: true
        expect(assigns(:comment)).to eq(comment)
      end
    end

    context 'with invalid params' do
      it 'assigns the comment as @comment' do
        comment = Comment.create! valid_attributes
        put :update, params: {id: comment.to_param, comment: invalid_attributes}, xhr: true
        expect(assigns(:comment)).to eq(comment)
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested comment' do
      comment = Comment.create! valid_attributes
      expect {
        delete :destroy, params: {id: comment.to_param}, xhr: true
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the comments list' do
      comment = Comment.create! valid_attributes
      delete :destroy, params: {id: comment.to_param}, xhr: true
      expect(response.code).to eq('204')
    end
  end
end
