require 'rails_helper'

describe RequestTalkPushCandidate do

  describe 'validations' do
    context 'candidate_email uniqueness' do
      let!(:talk_push_candidate) do
        FactoryBot.create(:request_talk_push_candidate)
      end
      let!(:dup_candidate) do
        FactoryBot.build(:request_talk_push_candidate,
                         candidate_email: talk_push_candidate.candidate_email
        )
      end

      it 'does not create a duplicated candidate' do
        counter = RequestTalkPushCandidate.count
        dup_candidate.save
        expect(counter).to eq(1)
        expect(dup_candidate.errors.messages[:candidate_email]).to include('has already been taken')
      end
    end
  end
end
