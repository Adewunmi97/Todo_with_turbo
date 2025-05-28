require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:todo) { Todo.create!(title: 'Some Task', status: 'incomplete') }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: todo.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'updates the requested todo' do
      patch :update, params: { id: todo.id, todo: { title: 'Updated Task' } }
      todo.reload
      expect(todo.title).to eq('Updated Task')
    end

    context 'with Turbo Stream format' do
      it 'renders the turbo stream template' do
        patch :update, params: { id: todo.id, todo: { title: 'Updated via Turbo' } }, format: :turbo_stream
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response.body).to include('turbo-stream')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:todo) { Todo.create!(title: 'Destroy Me', status: 'incomplete') }

    it 'destroys the requested todo' do
      expect {
        delete :destroy, params: { id: todo.id }, format: :turbo_stream
      }.to change(Todo, :count).by(-1)
    end
  end
end
