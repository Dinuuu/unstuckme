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
      before { get :index, user: 'MyDeviceToken' }
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

  describe '#vote' do
    let!(:questions) { create_list :question, 10, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }
    let!(:vote_params) { { voter: 'VoterDeviceToken', votes: [questions[0].options.first.id, questions[4].options.first.id, questions[6].options.first.id] } }
    context 'when voting into a question' do
      it 'returns http created' do
        post :vote, votation: vote_params
        expect(response.status).to eq 201
      end
      it 'creates answers as many as questions you vote on' do
        expect { post :vote, votation: vote_params }.to change(Answer, :count).by(3)
      end
    end
  end

  describe '#my_questions' do
    context 'when asking for the results of my questions' do
      let!(:questions) { create_list :question, 10, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }], creator: 'myDeviceToken' }
      before { get :my_questions, user: 'myDeviceToken' }
      it 'returns http ok' do
        expect(response.status).to eq 200
      end
      it 'returns 10 questions' do
        expect(body.size).to eq 10
      end
    end
  end

  describe '#my_answers' do
    context 'when asking for the questions I\'ve answered' do
      let!(:questions) { create_list :question, 10, options_attributes: [{ option: Faker::Avatar.image },{ option: Faker::Avatar.image }] }
      let!(:answer1) { Answer.create(question: questions[0], option: questions[0].options[1], voter: 'myDeviceToken')}
      let!(:answer2) { Answer.create(question: questions[2], option: questions[2].options[0], voter: 'myDeviceToken')}
      let!(:answer3) { Answer.create(question: questions[5], option: questions[5].options[1], voter: 'myDeviceToken')}
      before { get :my_answers, user: 'myDeviceToken' }
      it 'returns http ok' do
        expect(response.status).to eq 200
      end
      it 'returns 3 questions' do
        expect(body.size).to eq 3
      end
    end
  end
end