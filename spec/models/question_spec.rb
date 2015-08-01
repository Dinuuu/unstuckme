require 'rails_helper'

describe Question do
  describe '#create' do
    context 'when creating a valid question' do
      let!(:params) { { creator: 'deviseToken', exclusive: false, limit: 5, options_attributes: [{ option: 'www.google.com' }, { option: 'www.yahoo.com'} ]}}
      it 'is valid' do
        expect(Question.new(params).valid?).to eq true
      end
    end
  end
end