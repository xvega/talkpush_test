require 'rails_helper'

describe Candidate do

  describe 'validations' do
    context 'email uniqueness' do
      let!(:candidate) { FactoryBot.create(:candidate) }
      let!(:dup_candidate) do
        FactoryBot.build(:candidate, email: candidate.email)
      end

      it 'does not create a duplicated candidate' do
        counter = Candidate.count
        dup_candidate.save
        expect(counter).to eq(1)
        expect(dup_candidate.errors.messages[:email]).to include('has already been taken')
      end
    end
  end
end