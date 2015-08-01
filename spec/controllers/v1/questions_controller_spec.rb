require 'rails_helper'

describe V1::QuestionsController do
  let(:body) { JSON.parse(response.body) if response.body.present? }
  describe '#create' do
    context 'when creating a valid question' do
      let!(:question_attributes) { attributes_for :question, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }
      it 'returns http created' do
        post :create, question: question_attributes
        expect(response.status).to eq 201
      end
      it 'creates a new Question' do
        expect { post :create, question: question_attributes }.to change(Question, :count).by(1)
      end
    end
  end

  describe '#index' do
    context 'when asking for the questions' do
      let!(:non_exclusive_questions) { create_list :question, 10, exclusive: false, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }

      let!(:exclusive_questions) { create_list :question, 5, exclusive: true, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }
      before { get :index }
      it 'returns all the non exlusive questions' do
        expect(body.all? { |q| q['exclusive'] }).to eq false
      end
      it 'returns http success' do
        expect(response.status).to eq 200
      end
      it 'returns 10 elements' do
        expect(body.size).to eq 10
      end
    end
  end

  describe '#destroy' do
    context 'when destroying my own question' do
      let!(:question) { create :question, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }
      it 'destroys the object' do
        expect { delete :destroy, id: question.id, creator: question.creator }.to change(Question, :count).by(-1)
      end
    end
  end

  describe '#show' do
    context 'when asking for a question' do
      let!(:question) { create :question, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }
      before { get :show, id: question.id }
      it 'returns the asked question' do
        expect(body['id']).to eq question.id
      end
      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end
  end
end